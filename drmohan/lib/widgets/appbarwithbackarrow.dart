import 'package:flutter/material.dart';

class AppBarWithBackArrowWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  static String appTitle = "Dr. Mohan's";
  setAppBarWithBackArrowTitle(String title) {
    appTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(appTitle),
        backgroundColor: Color.fromRGBO(0, 116, 191, 1),
        actions: <Widget>[
          IconButton(
            tooltip: 'Cart',
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Notification',
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
