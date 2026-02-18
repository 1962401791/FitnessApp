#ifndef NUTRITIONCALCULATOR_H
#define NUTRITIONCALCULATOR_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

/**
 * @brief Result of macro calculation for a given amount of food.
 */
struct NutritionResult {
    double proteinG = 0;
    double carbsG = 0;
    double fatG = 0;
    double kcal = 0;
};

/**
 * @brief Computes protein, carbs, fat and kcal for a food amount.
 * Values are per 100g in the food database; amount is in grams.
 */
class NutritionCalculator : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit NutritionCalculator(QObject *parent = nullptr);

    /**
     * @brief Compute nutrition for a given amount (grams) using per-100g values.
     * @param proteinPer100g Protein per 100g
     * @param carbsPer100g   Carbs per 100g
     * @param fatPer100g     Fat per 100g
     * @param kcalPer100g    Kcal per 100g
     * @param amountG        Amount in grams
     * @return Aggregated nutrition for amountG
     */
    Q_INVOKABLE static NutritionResult compute(
        double proteinPer100g, double carbsPer100g, double fatPer100g,
        double kcalPer100g, double amountG);

    /**
     * @brief Compute kcal from macros (4 kcal per g protein/carbs, 9 per g fat).
     */
    Q_INVOKABLE static double kcalFromMacros(double proteinG, double carbsG, double fatG);
};

#endif // NUTRITIONCALCULATOR_H
