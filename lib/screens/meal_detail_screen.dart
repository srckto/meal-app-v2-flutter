import 'package:flutter/material.dart';
import 'package:meal_app_v2/models/meal.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const route = "/MealDetail";

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String? idArg = routeArg["id"];
    final String? titleArg = routeArg["title"];
    final Meal itemSelected = DUMMY_MEALS.firstWhere((element) => element.id == idArg);
    int stepsCountDivider = 0;
    int ingredientsCountDivider = 0;
    Provider.of<MealProvider>(context, listen: false).changeIcon(itemSelected.id);
    bool? _iconStat = Provider.of<MealProvider>(context).iconState;

    final _lang = Provider.of<LanguageProvider>(context);
    final List<String> _ingredients = _lang.getText("ingredients-$idArg") as List<String>;
    final List<String> _steps = _lang.getText("steps-$idArg") as List<String>;

    return Directionality(
      textDirection: _lang.isAr == false ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titleArg!),
        ),
        body: ListView(
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: FadeInImage(
                    placeholder: AssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      itemSelected.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${_lang.getText("Ingredients")}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: _ingredients.map((element) {
                    ingredientsCountDivider++;
                    return Column(
                      children: [
                        Text(
                          element,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        if (ingredientsCountDivider != _ingredients.length) Divider(thickness: 2),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Text(
              "${_lang.getText("Steps")}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _steps.map((element) {
                    stepsCountDivider++;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$stepsCountDivider - $element",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        if (stepsCountDivider != _steps.length) Divider(thickness: 2),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences _pref = await SharedPreferences.getInstance();
            _pref.containsKey(itemSelected.id) ? _pref.remove(itemSelected.id) : _pref.setString(itemSelected.id, itemSelected.id);
            await Provider.of<MealProvider>(context, listen: false).addFavoriteMealOrRemove(mealSelectedId: itemSelected.id, mealSelect: itemSelected);

            print("keys ${_pref.getKeys()}");
          },
          child: Icon(_iconStat! ? Icons.star : Icons.star_border, size: 29),
        ),
      ),
    );
  }
}
