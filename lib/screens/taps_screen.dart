import 'package:flutter/material.dart';
import 'package:meal_app_v2/providers/language_provider.dart';
import 'package:meal_app_v2/screens/categories_screen.dart';
import 'package:meal_app_v2/screens/favorites_srceen.dart';
import 'package:meal_app_v2/widgets/drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const route = "/TabsScreen";
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    CategoriesScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<LanguageProvider>(context);
    List<String> _pagesTitle = [
      "${_lang.getText("categories")}",
      "${_lang.getText("your_favorites")}",
    ];
    return Directionality(
      textDirection: _lang.isAr == false ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pagesTitle[_currentIndex]),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            // selectedLabelStyle: ,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 0 ? Icons.category : Icons.category_outlined, size: 27),
                label: "${_lang.getText("categories_tab")}",
              ),
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 0 ? Icons.star_outline : Icons.star, size: 27),
                label: "${_lang.getText("favorites_tab")}",
              ),
            ],
          ),
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}
