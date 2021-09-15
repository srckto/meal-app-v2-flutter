import 'package:flutter/material.dart';
import 'package:meal_app_v2/models/meal.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/providers/meal_provider.dart';
import 'package:meal_app_v2/widgets/meal_items.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const route = "/CategoryMealsScreen";

  @override
  Widget build(BuildContext context) {
    final availabeMeal = Provider.of<MealProvider>(context).allMealAvailable;

    final Map<String, String> routeArg = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String? categoryTitle = routeArg["title"];
    final String? categoryId = routeArg["id"];
    final List<Meal> mealsSelected = availabeMeal.where((element) => element.categories.contains(categoryId)).toList();

    final _lang = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: _lang.isAr == false ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: mealsSelected.isEmpty
            ? Center(child: Text("Not found any meal in this category."))
            : ListView.builder(
                itemCount: mealsSelected.length,
                itemBuilder: (ctx, index) {
                  return MealItem(
                    id: mealsSelected[index].id,
                    title: "${_lang.getText("meal-${mealsSelected[index].id}")}",
                    imageUrl: mealsSelected[index].imageUrl,
                    duration: mealsSelected[index].duration,
                    complexity: mealsSelected[index].complexity,
                    affordability: mealsSelected[index].affordability,
                  );
                },
              ),
      ),
    );
  }
}
