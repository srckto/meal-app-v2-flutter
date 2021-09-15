import 'package:flutter/material.dart';
import 'package:meal_app_v2/dummy_data.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/widgets/category_items.dart';
import 'package:meal_app_v2/widgets/drawer.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  static const route = "/CategoriesScreen";

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        itemCount: DUMMY_CATEGORIES.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2.9 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return CategoryItem(
            color: DUMMY_CATEGORIES[index].color,
            id: DUMMY_CATEGORIES[index].id,
            title: "${_lang.getText("cat-c${index+1}")}",
          );
        },
      ),
      drawer: CustomDrawer(),
    );
  }
}
