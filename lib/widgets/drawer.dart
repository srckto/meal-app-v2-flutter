import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/screens/about.dart';
import 'package:meal_app_v2/screens/filter_screen.dart';
import 'package:meal_app_v2/screens/taps_screen.dart';
import 'package:provider/provider.dart';

import 'switch_change_mode.dart';
import 'switch_languge_change.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final _lang = Provider.of<LanguageProvider>(context);

    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              width: mediaQuery.width,
              child: Center(
                child: Text(
                  "Meal App",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            decoration: BoxDecoration(
              // color: Colors.transparent,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, TabsScreen.route),
            child: Text(
              "${_lang.getText("drawer_item1")}",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, FilterScreen.route),
            child: Text(
              "${_lang.getText("drawer_item2")}",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => AboutScreen())),
            child: Text(
              "${_lang.getText("drawer_item3")}",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 45),
          SwitchChangeMode(),
          SizedBox(height: 20),
          Divider(thickness: 2),
          SwitchLanguageChange(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: Text(
                    'v2.0.0',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
