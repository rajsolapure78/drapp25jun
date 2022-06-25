import 'package:drmohan/main.dart';
//import 'package:drmohan/screens/screen_diabetesshoppe.dart';
//import 'package:drmohan/screens/screen_myorders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  late BuildContext commoncontext;
  @override
  Widget build(BuildContext context) {
    commoncontext = context;
    final name = ProfileScreen.selectedProfile.PatientName;
    final email = '';
    final urlImage = '';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => {},
              /*onClicked: () => Navigator.of(context).push(
                  MaterialPageRoute(
                builder: (context) => DiabetesShoppeScreenState(
                    //name: 'Sarah Abs',
                    //urlImage: urlImage,
                    ),
              )),*/
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  //const SizedBox(height: 12),
                  //buildSearchField(),
                  const SizedBox(height: 7),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt1,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menuhome.png',
                    onClicked: () => selectedItem(context, 0),
                  ),
                  Divider(color: Colors.blueGrey),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt2,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menumyorders.png',
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 7),
                  Divider(color: Colors.blueGrey),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt3,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menuaccount.png',
                    onClicked: () => selectedItem(context, 2),
                  ),
                  Divider(color: Colors.blueGrey),
                  const SizedBox(height: 7),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt4,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menucliniclocator.png',
                    onClicked: () => selectedItem(context, 3),
                  ),
                  Divider(color: Colors.blueGrey),
                  const SizedBox(height: 7),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt5,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menuhelp.png',
                    onClicked: () => selectedItem(context, 4),
                  ),
                  Divider(color: Colors.blueGrey),
                  const SizedBox(height: 7),
                  buildMenuItem(
                    text: OTPVerification.appscreensdataitems![33].srntxt6,
                    icon: OTPVerification.appscreensdataitems![36].srntxt2 + 'images/menu/menulogout.png',
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          color: Color.fromRGBO(0, 116, 191, 1),
          padding: padding.add(EdgeInsets.symmetric(vertical: 10)),
          child: Row(
            children: [
              //CircleAvatar(radius: 20, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: MediaQuery.of(commoncontext).size.width * 0.037, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: MediaQuery.of(commoncontext).size.width * 0.030, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              /*CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(0, 116, 191, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )*/
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required String icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.blueGrey;

    return ListTile(
      leading: Image.network(icon),
      title: Text(text, style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: color, fontSize: MediaQuery.of(commoncontext).size.width * 0.037)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
        break;
      case 1:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyOrdersScreen(),
        ));*/
        break;
      case 2:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyOrdersScreen(),
        ));*/
        break;
      case 3:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyOrdersScreen(),
        ));*/
        break;
      case 4:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyOrdersScreen(),
        ));*/
        break;
      case 5:
        OTPVerification.OTPreceived = false;
        OTPVerification.getotpstr = "";
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DrMohanAppAnimation(),
        ));
        break;
    }
  }
}
