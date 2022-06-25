//import 'package:drmohan/screens/screen_listofnotifications.dart';
//import 'package:drmohan/screens/screen_myshoppingorders.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  static String appTitle = "Dr. Mohan's";
  setAppBarTitle(String title) {
    appTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          appTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.015,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 116, 191, 1),
        actions: <Widget>[
          Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            InkWell(
                onTap: () {
                  /*MyShoppingOrdersScreen.orderDataReceived = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyShoppingOrdersScreenStateful(),
                      ));*/
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: 0.01,
                    heightFactor: 0.01,
                    child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/cart.png'),
                    //fit: BoxFit.cover,
                  ),
                )),
            InkWell(
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListOfNotificationsScreen(),
                      ));*/
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: 0.01,
                    heightFactor: 0.01,
                    child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/notification.png'),
                    //fit: BoxFit.cover,
                  ),
                )),
          ])
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
