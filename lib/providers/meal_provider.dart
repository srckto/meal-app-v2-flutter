import 'package:flutter/cupertino.dart';
import 'package:meal_app_v2/dummy_data.dart';
import 'package:meal_app_v2/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  List<Meal> allMealAvailable = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  bool? iconState = false;

  Map<String, bool> filters = {
    "isGlutenFree": false,
    "isLactoseFree": false,
    "isVegan": false,
    "isVegetarian": false,
  };

  // to change filters map with shared preferences
  // use in updateAllMealAvailable
  // lib\screens\meal_detail_screen.dart
  // lib\screens\filter_screen.dart
  Future getFiltersPreferences() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    filters = {
      "isGlutenFree": _pref.getBool("isGlutenFree") ?? false,
      "isLactoseFree": _pref.getBool("isLactoseFree") ?? false,
      "isVegan": _pref.getBool("isVegan") ?? false,
      "isVegetarian": _pref.getBool("isVegetarian") ?? false,
    };
    notifyListeners();
  }

  // use it when the begin-up app. file : main
  Future setFilterValue() async {
    {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setBool("isGlutenFree", filters["isGlutenFree"]!);
      _pref.setBool("isLactoseFree", filters["isLactoseFree"]!);
      _pref.setBool("isVegan", filters["isVegan"]!);
      _pref.setBool("isVegetarian", filters["isVegetarian"]!);
    }
    notifyListeners();
  }

  // use it when the begin-up app. file : main
  Future updateAllMealAvailable() async {
    await getFiltersPreferences();
    if (!filters["isGlutenFree"]! && !filters["isLactoseFree"]! && !filters["isVegan"]! && !filters["isVegetarian"]!) {
      allMealAvailable = DUMMY_MEALS;
    } else {
      allMealAvailable = DUMMY_MEALS.where((element) {
        if (filters["isGlutenFree"]! && filters["isGlutenFree"]! == element.isGlutenFree) {
          return true;
        }
        if (filters["isLactoseFree"]! && filters["isLactoseFree"]! == element.isLactoseFree) {
          return true;
        }
        if (filters["isVegan"]! && filters["isVegan"]! == element.isVegan) {
          return true;
        }
        if (filters["isVegetarian"]! && filters["isVegetarian"]! == element.isVegetarian) {
          return true;
        }
        return false;
      }).toList();
    }

    notifyListeners();
  }

  // use it when the begin-up app. file : main
  Future upDateFavoriteMeal() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Set<String> keys = _pref.getKeys();
    DUMMY_MEALS.forEach((element) {
      if (keys.contains(element.id)) {
        if (!favoriteMeals.any((element2) => element == element2)) {
          favoriteMeals.add(element);
        }
      }
    });
    notifyListeners();
  }

  // Chaneg List (favoriteMeals) and get a favorite meal or delete
  Future addFavoriteMealOrRemove({required String mealSelectedId, required Meal mealSelect}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (_pref.containsKey(mealSelectedId)) {
      favoriteMeals.add(mealSelect);
    } else {
      favoriteMeals.remove(mealSelect);
    }
    upDateFavoriteMeal();
    notifyListeners();
  }

  // To fillter
  void filter({
    required bool isGlutenFree,
    required bool isLactoseFree,
    required bool isVegan,
    required bool isVegetarian,
  }) {
    if (!isGlutenFree && !isLactoseFree && !isVegan && !isVegetarian) {
      allMealAvailable = DUMMY_MEALS;
    } else {
      allMealAvailable = DUMMY_MEALS.where((element) {
        if (isGlutenFree && isGlutenFree == element.isGlutenFree) {
          return true;
        }
        if (isLactoseFree && isLactoseFree == element.isLactoseFree) {
          return true;
        }
        if (isVegan && isVegan == element.isVegan) {
          return true;
        }
        if (isVegetarian && isVegetarian == element.isVegetarian) {
          return true;
        }
        return false;
      }).toList();
    }

    notifyListeners();
  }

  // to change icon in screen [meal_detail_screen]
  void changeIcon(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var key = _pref.getKeys();
    if (key.contains(id)) {
      iconState = true;
    } else {
      iconState = false;
    }
    notifyListeners();
  }
}
