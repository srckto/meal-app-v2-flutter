import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/theme_provider.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchChangeMode extends StatefulWidget {
  @override
  _SwitchChangeModeState createState() => _SwitchChangeModeState();
}

class _SwitchChangeModeState extends State<SwitchChangeMode> {
  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<LanguageProvider>(context);

    bool? val = Provider.of<ColorProvider>(context, listen: false).themeState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("${_lang.getText("light_theme")}", style: Theme.of(context).textTheme.subtitle1),
        Switch(
            value: val!,
            onChanged: (value) async {
              Provider.of<ColorProvider>(context, listen: false).changeThemeMode(value);
              SharedPreferences _pref = await SharedPreferences.getInstance();
              _pref.setBool("switch", value);
            }),
        Text("${_lang.getText("dark_theme")}", style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
