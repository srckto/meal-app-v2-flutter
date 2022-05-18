import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styleClass.dart';

class ColorProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool? themeState = false;

  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: StyleClass.R_D92818,
    ),
    primaryColor: StyleClass.R_D92818,
    accentColor: StyleClass.O_D97904,
    buttonColor: StyleClass.B_262523,
    cardColor: StyleClass.R_D92818.withOpacity(0.5),
    canvasColor: StyleClass.W_FDFEE2.withAlpha(250),
    backgroundColor: StyleClass.B_262523,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: StyleClass.R_D92818,
      selectedItemColor: StyleClass.W_FDFEE2,
    ),
    fontFamily: "IBM",
    textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontSize: 20.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          subtitle2: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          headline1: TextStyle(
            fontSize: 60,
            color: StyleClass.R_D92818,
            fontFamily: "CherryAndKisses",
          ),
          headline2: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: StyleClass.W_FDFEE2.withAlpha(250),
          ),
        ),
  );

  ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF242227), 
    ),
    primaryColor: Color(0xFF262626),
    accentColor: Color(0xFF242227),
    cardColor: Color(0xFF242227).withOpacity(0.5),
    canvasColor: Color(0xFF737373),
    fontFamily: "IBM",
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF262626),
      selectedItemColor: StyleClass.W_FDFEE2,
    ),
    backgroundColor: Color(0xFF262626),
    textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontSize: 20.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
          subtitle2: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          headline1: TextStyle(
            fontSize: 60,
            color: StyleClass.R_D92818,
            fontFamily: "CherryAndKisses",
          ),
          headline2: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline4: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF737373),
          ),
        ),
  );

  void getValuePrefrence() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    themeState = _pref.getBool("switch") ?? false;
    changeThemeMode(themeState!);
    notifyListeners();
  }

  void changeThemeMode(bool value) {
    if (value == false) {
      themeMode = ThemeMode.light;
      themeState = false;
    } else {
      themeMode = ThemeMode.dark;
      themeState = true;
    }
    notifyListeners();
  }
}
