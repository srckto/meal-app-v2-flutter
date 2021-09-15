import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/theme_provider.dart';
import 'package:meal_app_v2/providers/meal_provider.dart';
import 'package:meal_app_v2/screens/favorites_srceen.dart';
import 'package:meal_app_v2/screens/filter_screen.dart';
import 'package:meal_app_v2/screens/meal_detail_screen.dart';
import 'package:meal_app_v2/screens/taps_screen.dart';
import 'package:provider/provider.dart';

import 'providers/language_provider.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        // ChangeNotifierProxyProvider<LanguageProvider, ColorProvider>(
        //   create: (_) => ColorProvider(),
        //   update: (BuildContext context,  languageProvider,  colorProvider) => ColorProvider(languageProvider.isEn),
        // ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // to prepare the app and get all settings.
    Provider.of<MealProvider>(context, listen: false).updateAllMealAvailable();
    Provider.of<MealProvider>(context, listen: false).upDateFavoriteMeal();
    Provider.of<MealProvider>(context, listen: false).setFilterValue();
    Provider.of<ColorProvider>(context, listen: false).getValuePrefrence();
    Provider.of<LanguageProvider>(context, listen: false).getLang();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ColorProvider>(context).themeMode,
      theme: Provider.of<ColorProvider>(context).lightTheme,
      darkTheme: Provider.of<ColorProvider>(context).darkTheme,
      title: 'Meal App',
      routes: {
        "/": (_) => TabsScreen(),
        TabsScreen.route: (_) => TabsScreen(),
        FilterScreen.route: (_) => FilterScreen(),
        FavoritesScreen.route: (_) => FavoritesScreen(),
        CategoriesScreen.route: (_) => CategoriesScreen(),
        CategoryMealsScreen.route: (_) => CategoryMealsScreen(),
        MealDetail.route: (_) => MealDetail(),
      },
      // home: CategoriesScreen(),
    );
  }
}
