#include "core/NutritionCalculator.h"

NutritionCalculator::NutritionCalculator(QObject *parent) : QObject(parent) {}

NutritionResult NutritionCalculator::compute(
    double proteinPer100g, double carbsPer100g, double fatPer100g,
    double kcalPer100g, double amountG)
{
    if (amountG <= 0)
        return {};
    const double scale = amountG / 100.0;
    NutritionResult r;
    r.proteinG = proteinPer100g * scale;
    r.carbsG = carbsPer100g * scale;
    r.fatG = fatPer100g * scale;
    r.kcal = kcalPer100g * scale;
    return r;
}

double NutritionCalculator::kcalFromMacros(double proteinG, double carbsG, double fatG)
{
    return proteinG * 4 + carbsG * 4 + fatG * 9;
}
