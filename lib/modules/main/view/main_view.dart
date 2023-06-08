import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../export_files.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  String _currentPage = "Main";
  List<String> pageKeys = ["Main", "Search", "Basket", "Account"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Main": GlobalKey<NavigatorState>(),
    "Search": GlobalKey<NavigatorState>(),
    "Basket": GlobalKey<NavigatorState>(),
    "Account": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Main") {
            _selectTab("Main", 1);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Main"),
          _buildOffstageNavigator("Search"),
          _buildOffstageNavigator("Basket"),
          _buildOffstageNavigator("Account"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg'),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              label: 'Поиск',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/basket.svg'),
              label: 'Корзина',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/account.svg'),
              label: 'Аккаунт',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
