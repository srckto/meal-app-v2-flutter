import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:provider/provider.dart';

class SwitchLanguageChange extends StatefulWidget {
  @override
  _SwitchLanguageChangeState createState() => _SwitchLanguageChangeState();
}

class _SwitchLanguageChangeState extends State<SwitchLanguageChange> {
  @override
  Widget build(BuildContext context) {
    bool currentLang = Provider.of<LanguageProvider>(context).isAr;
    final _lang = Provider.of<LanguageProvider>(context);

    return Column(
      children: [
        Text(
          "${_lang.getText("drawer_switch_title")}",
          style: Theme.of(context).textTheme.headline3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${_lang.getText("drawer_switch_item1")}", style: Theme.of(context).textTheme.subtitle1),
            Switch(
              value: currentLang,
              onChanged: (value) async {
                Provider.of<LanguageProvider>(context, listen: false).changeLang();
              },
            ),
            Text("${_lang.getText("drawer_switch_item2")}", style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ],
    );
  }
}
