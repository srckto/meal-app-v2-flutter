import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/providers/meal_provider.dart';
import 'package:meal_app_v2/widgets/meal_items.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  static const route = "/FavoritesScreen";

  @override
  Widget build(BuildContext context) {
    final mealListFavorite = Provider.of<MealProvider>(context).favoriteMeals;
    final _lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: mealListFavorite.isEmpty
          ? Center(child: Text("${_lang.getText("favorites_text")}"))
          : ListView.builder(
              itemCount: mealListFavorite.length,
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: mealListFavorite[index].id,
                  title: "${_lang.getText("meal-${mealListFavorite[index].id}")}",
                  imageUrl: mealListFavorite[index].imageUrl,
                  duration: mealListFavorite[index].duration,
                  complexity: mealListFavorite[index].complexity,
                  affordability: mealListFavorite[index].affordability,
                );
              },
            ),
    );
  }
}
