import 'package:flutter/material.dart';

import '../../../export_files.dart';
import '../../basket/view/cart_view.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == "Main") {
      child = const CategoryView();
    } else if (tabItem == "Search") {
      child = const CategoryView();
    } else if (tabItem == "Basket") {
      child = const BasketView();
    } else if (tabItem == "Account") {
      child = const CategoryView();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
