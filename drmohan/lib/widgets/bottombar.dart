import 'package:drmohan/main.dart';
/*import 'package:drmohan/screens/screen_bookappointment.dart';*/
//import 'package:drmohan/screens/screen_feedback.dart';
/*import 'package:drmohan/screens/screen_prescriptionsrefills.dart';*/
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*Padding(
              padding: const EdgeInsets.all(215.0),
              child: Icon(Icons.home_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(Icons.calendar_today_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(Icons.medical_services_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(Icons.feedback_outlined),
            )*/
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ));
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.05,
                  heightFactor: 0.05,
                  child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/home.png', width: MediaQuery.of(context).size.width * 0.1, height: MediaQuery.of(context).size.height * 0.1),
                  //fit: BoxFit.cover,
                ),
              )),
          InkWell(
              onTap: () {
                /*print("tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookAppointmentScreenState(),
                    ));*/
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.only(left: 0),
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.01,
                  heightFactor: 0.01,
                  child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/calendar.png', width: MediaQuery.of(context).size.width * 0.1, height: MediaQuery.of(context).size.height * 0.1),
                  //fit: BoxFit.cover,
                ),
              )),
          InkWell(
              onTap: () {
                /*PrescriptionsRefillsScreen.prescriptionDataReceived = "false";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrescriptionsRefillsScreenStateful(),
                    ));*/
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.01,
                  heightFactor: 0.01,
                  child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/healthrecord.png', width: MediaQuery.of(context).size.width * 0.1, height: MediaQuery.of(context).size.height * 0.1),
                  //fit: BoxFit.cover,
                ),
              )),
          InkWell(
              onTap: () {
                /*FeedbackScreen.thanksNote = "";
                FeedbackScreen.showthanksNote = false;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackScreenStateful(),
                    ));*/
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.01,
                  heightFactor: 0.01,
                  child: Image.network(OTPVerification.appscreensdataitems![36].srntxt2 + 'images/common/feedback.png', width: MediaQuery.of(context).size.width * 0.1, height: MediaQuery.of(context).size.height * 0.1),
                  //fit: BoxFit.cover,
                ),
              )),
        ],
      ),
      color: Color.fromRGBO(0, 116, 191, 1),
      elevation: 9.0,
      notchMargin: 7.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void selectedBottombarItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
        break;
      case 1:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FeedbackScreenStateful(),
        ));*/
        break;
      case 2:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FeedbackScreenStateful(),
        ));*/
        break;
      case 3:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FeedbackScreenStateful(),
        ));*/
        break;
    }
  }
}
