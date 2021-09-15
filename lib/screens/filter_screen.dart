import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  static const route = "/FilterScreen";

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool? _isGlutenFree = false, _isLactoseFree = false, _isVegan = false, _isVegetarian = false;

  Future getPreferenceValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      _isGlutenFree = _pref.getBool("isGlutenFree");
      _isLactoseFree = _pref.getBool("isLactoseFree");
      _isVegan = _pref.getBool("isVegan");
      _isVegetarian = _pref.getBool("isVegetarian");
    });
  }

  @override
  void initState() {
    getPreferenceValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: _lang.isAr == false ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${_lang.getText("filters_appBar_title")}"),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "${_lang.getText("filters_screen_title")}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text(
                "${_lang.getText("Gluten-free")}",
                style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              value: _isGlutenFree!,
              onChanged: (bool value) {
                setState(() {
                  _isGlutenFree = value;
                });
              },
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text(
                "${_lang.getText("Lactose-free")}",
                style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              value: _isLactoseFree!,
              onChanged: (bool value) {
                setState(() {
                  _isLactoseFree = value;
                });
              },
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text(
                "${_lang.getText("Vegan")}",
                style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              value: _isVegan!,
              onChanged: (bool value) {
                setState(() {
                  _isVegan = value;
                });
              },
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text(
                "${_lang.getText("Vegetarian")}",
                style: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              value: _isVegetarian!,
              onChanged: (bool value) {
                setState(() {
                  _isVegetarian = value;
                });
              },
            ),
            SizedBox(height: 25),
            Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<MealProvider>(context, listen: false).filter(
                    isGlutenFree: _isGlutenFree!,
                    isLactoseFree: _isLactoseFree!,
                    isVegan: _isVegan!,
                    isVegetarian: _isVegetarian!,
                  );
                  SharedPreferences _pref = await SharedPreferences.getInstance();
                  _pref.setBool("isGlutenFree", _isGlutenFree!);
                  _pref.setBool("isLactoseFree", _isLactoseFree!);
                  _pref.setBool("isVegan", _isVegan!);
                  _pref.setBool("isVegetarian", _isVegetarian!);
                },
                child: Text(
                  "${_lang.getText("save_filter")}",
                  style: TextStyle(fontSize: 20, color: Theme.of(context).canvasColor),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
