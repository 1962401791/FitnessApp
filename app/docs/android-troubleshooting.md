# Android 构建与部署故障排除

## 错误：设备不支持套件架构（设备 ABI 为空）

### 现象

- 提示：**部署设备"xxx"不支持套件架构。套件支持"arm64-v8a"，但设备使用""。**
- CMake 配置失败，调用栈指向 `qt_add_qml_module` 和 Qt 的 `qt6_android_generate_deployment_settings`。

### 原因

Qt Creator 在配置或部署时会把**当前选中的 Android 设备**的 ABI 传给 CMake。若设备未正确上报 ABI（显示为空字符串），Qt 的 Android 宏在生成部署路径时会出错，导致配置失败。  
这是 Qt Creator 的已知问题（[QTCREATORBUG-27103](https://bugreports.qt.io/browse/QTCREATORBUG-27103)），部分版本在“设备 ABI 为空”时仍会提前校验并导致失败。

### 解决思路（任选其一）

#### 1. 先不部署到该设备，仅构建 APK（推荐）

目标：让 CMake 只做“构建”，不依赖当前设备的 ABI。

- 在 Qt Creator 中：
  - **Projects** → 当前 **Run** 配置 → **Run** 一栏里，把 **Run on device** 暂时改为 **None** 或另一个能正确识别 ABI 的设备/模拟器；或
  - 只点 **Build**（Ctrl+B），不要点 **Run**。
- 重新 **Configure** / **Build**。若配置通过，会在 `build/.../` 下生成 APK。
- 手动安装到真机：
  ```bash
  adb -s <设备ID> install -r path/to/build/.../FitnessApp.apk
  ```
  设备 ID 可在 **Devices → Android** 中查看，或运行 `adb devices`。

这样可避免“设备 ABI 为空”在配置阶段触发 Qt 的部署逻辑。

#### 2. 检查设备是否真的上报了 ABI

在项目目录打开终端：

```bash
adb -s W4IFZLQ4ONYPU4DM shell getprop ro.product.cpu.abi
```

- 若输出为空或命令失败：说明系统/驱动/ADB 未正确上报 ABI，Qt Creator 无法识别。
- 若输出为 `arm64-v8a` 等：说明设备正常，问题多半在 Qt Creator 对设备的缓存或识别。可尝试：
  - **Devices → Android** → 删除该设备 → 重新插拔 USB、重新启用 USB 调试 → 让 Qt 再次检测设备；
  - 或重启 Qt Creator 后重试。

#### 3. 换用 armeabi-v7a 套件（临时）

若当前设备在“armeabi-v7a”套件下能被正确识别（设备列表里该设备显示架构而非空白）：

- 在 Qt Creator 中切换到 **Qt 6.10.2 for Android armeabi-v7a** 套件；
- 重新配置并构建，再部署到该设备。

适合先跑通流程，后续再排查 arm64-v8a + 该设备。

#### 4. 使用模拟器

若手头有 Android 模拟器（AVD），且其在 Qt Creator 的 **Devices** 中显示正常架构：

- 将 **Run** 目标选为该模拟器；
- 用 **arm64-v8a** 或 **x86_64**（与 AVD 架构一致）套件构建并运行。

可先验证应用，再单独处理真机 ABI 问题。

#### 5. 升级 Qt Creator（若可行）

QTCREATORBUG-27103 在 Qt Creator 7.0.0-beta2 / 11.0.0 中有修复（允许在 kit/device ABI 异常时继续部署，失败延后到安装阶段）。若你使用的版本较旧，可考虑升级到 11+ 或更新版本，可能减少“设备 ABI 为空”导致的配置失败。

---

## 与本项目的关系

- 错误来自 **Qt Creator + 设备 ABI 检测**，与 `CMakeLists.txt` 中的 `qt_add_qml_module` 用法无关，无需改项目 CMake 即可按上述方式规避。
- 若你验证了设备 ABI（如 `getprop`）并尝试了重新添加设备/换套件/仅构建不部署后仍有新报错，可把完整错误信息与 Qt Creator、Qt、NDK 版本补充到 `log.md` 或提 issue 以便继续排查。
