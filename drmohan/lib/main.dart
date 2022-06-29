// @dart=2.9
import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drmohan/screens/screen_dailyhealthtracker.dart';
/*import 'package:drmohan/screens/screen_bookappointment.dart';
import 'package:drmohan/screens/screen_dailyhealthtracker.dart';
import 'package:drmohan/screens/screen_diabetesshoppe.dart';
import 'package:drmohan/screens/screen_healthrecord.dart';
import 'package:drmohan/screens/screen_healthrecordclinicalsummary.dart';
import 'package:drmohan/screens/screen_prescriptionsrefills.dart';
import 'package:drmohan/screens/screen_razorpayment.dart';
import 'package:drmohan/screens/screen_statefulbottomsheet.dart';*/
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:drmohan/widgets/menu_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';

import 'models/model_appinfo.dart';
import 'models/model_appscreensdata.dart';
import 'models/model_dashboarditem.dart';
import 'models/model_notifiesitem.dart';
import 'models/model_profile.dart';
import 'models/model_spotlightitem.dart';
import 'services/http_service.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => DrMohanAppAnimation(),
      '/first': (context) => DrMohanApp(),
      '/second': (context) => OTVerficationState(),
      '/third': (context) => ProfileScreen(),
      '/fourth': (context) => DashboardScreen(),
      /*'/fifth': (context) => BookAppointmentScreenState(),
      '/clinic': (BuildContext context) => HealthRecordClinicalSummaryScreenStateful(),*/
    },
  ));
}

class DrMohanAppAnimation extends StatelessWidget {
  //https://www.rsolutions7.com/drmohan/images/dmdscLOGO.png
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset('asset/image/dmdscLOGO.png'),
          nextScreen: DrMohanApp(),
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.topToBottom,
        ));
  }
}

class DrMohanApp extends StatelessWidget {
  final HttpService httpService = HttpService();

  static List<AppInfoItem> appinfoitems = [];
  static List<String> appinfoitemsarr = [];

  callToSetAppBarTitle() => createState().setAppBarTitle("Dr. Mohan");

  static getAppScreensDataItem(int index) {
    return appinfoitemsarr[index];
  }

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  Widget build(BuildContext context) {
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: FutureBuilder(
        future: httpService.getAppInfoData(),
        builder: (BuildContext context, AsyncSnapshot<List<AppInfoItem>> snapshot) {
          if (snapshot.hasData) {
            appinfoitems = snapshot.data;
            appinfoitemsarr = appinfoitems?.cast<String>();
            return GestureDetector(
              onTap: () {
                OTPVerification.OTPreceived = false;
                OTPVerification.getotpstr = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTVerficationState()),
                );
              },
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * .40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .30,
                  ),
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          /*backgroundImage: NetworkImage(
                            DrMohanApp.appinfoitems[0].srntxt2 + 'images/dmdscLOGOsmall.png',
                          ),*/
                          child: Image.asset('asset/image/dmdscLOGOsmall.png'),
                          radius: 70,
                        ),
                      ), //dmdscLOGOsmall.png
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 30),
                        child: Align(
                          child: Image.network(
                            DrMohanApp.appinfoitems[0].srntxt2 + 'images/welcometext.png',
                            scale: 2,
                          ),
                          //fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else {
            //return Center(child: CircularProgressIndicator());
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5, bottom: 30),
                          child: new CircularProgressIndicator(strokeWidth: 5),
                        ),
                        Container(child: Text("App data loading.Please wait!")),
                      ],
                    ),
                  )),
            );
          }
        },
      ),
    );
  }
}

class OTVerficationState extends StatefulWidget {
  createState() {
    return OTPVerification();
  }
}

//class OTPVerification extends State<_OTPVerification> {
//class OTPVerification extends StatelessWidget {
class OTPVerification extends State<OTVerficationState> {
  static List<AppScreensDataItem> appscreensdataitems = [];
  static List<String> appscreensdataitemsarr = [];
  static Object jObj = [];
  final HttpService httpService = HttpService();

  callToSetAppBarTitle() => createState().setAppBarTitle("Verify OTP");
  static String getotpstr = "";
  static String phone = "";
  static String otptxt1 = "";
  static String otptxt2 = "";
  static String otptxt3 = "";
  static String otptxt4 = "";
  static String verifyotpstr = "";
  static String tokenstr = "";
  static BuildContext buildContext = BuildContext as BuildContext;
  static String otptxts = "";
  static bool OTPreceived = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  static updateOTPTexts(JSONObj) {
    jObj = JSONObj;
    otptxts = JSONObj;
    OTPVerification.otptxt1 = JSONObj[0];
    OTPVerification.otptxt2 = JSONObj[1];
    OTPVerification.otptxt3 = JSONObj[2];
    OTPVerification.otptxt4 = JSONObj[3];
  }

  @override
  void initState() {
    super.initState();
    otptxt1 = "";
    otptxt2 = "";
    otptxt3 = "";
    otptxt4 = "";
    phone = "";
    print(OTPreceived);
    print("OTPreceived");
    OTPreceived = false;
    getotpstr = "";
    _phoneNumberController.text = "";
    /*_phoneNumberController.addListener(() {
      final String text = _phoneNumberController.text.toLowerCase();
      _phoneNumberController.value = _phoneNumberController.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });*/
  }

  static loadProfileScreen() {
    Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (buildContext) => ProfileScreen()),
    );
  }

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    callToSetAppBarTitle();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      //onPrimary: Color.fromRGBO(108, 239, 232, 1),
      onPrimary: Color.fromRGBO(0, 0, 0, 1),
      primary: Colors.lightBlueAccent,
      minimumSize: Size(MediaQuery.of(context).size.width * 0.1, 36),
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: FutureBuilder(
        future: httpService.getAppScreensData(),
        builder: (BuildContext context, AsyncSnapshot<List<AppScreensDataItem>> snapshot) {
          if (snapshot.hasData) {
            appscreensdataitems = snapshot.data;
            appscreensdataitemsarr = appscreensdataitems?.cast<String>();
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: NetworkImage(DrMohanApp.appinfoitems[0].srntxt2 + "images/otpbg.png"),
                    image: new AssetImage('asset/image/OTPbg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Container(
                            margin: new EdgeInsets.only(top: 50.0),
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Align(
                                alignment: Alignment.center,
                                widthFactor: 0.01,
                                heightFactor: 0.01,
                                child: Image.network(
                                  OTPVerification.appscreensdataitems[36].srntxt2 + 'images/dmdscLOGObig.png',
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                //fit: BoxFit.cover,
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: Text(
                            OTPVerification.appscreensdataitems[1].srntxt1,
                            style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.037),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: TextField(
                            onTap: () {
                              print("tap");
                              //FocusScope.of(context).highlightMode.name;
                            },
                            onChanged: (text) {
                              getotpstr = text;
                            },
                            autofocus: false,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, color: Colors.black),
                            textAlign: TextAlign.center,
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.emailAddress,
                            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: OTPVerification.appscreensdataitems[1].srntxt2,
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: Text(
                            OTPVerification.appscreensdataitems[1].srntxt3 + phone,
                            style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.037),
                          ),
                        ),
                        /*Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.45,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(108, 239, 232, 1),
                                    Color.fromRGBO(77, 207, 247, 1)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Text("hi")),*/
                        Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                            child: ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                httpService.getOTP();
                                FocusManager.instance.primaryFocus?.unfocus();
                                var _timer = Timer(
                                    Duration(seconds: 5),
                                    () => setState(() {
                                          if ((otptxts != null) && (otptxts.length > 0)) {
                                            otptxt1 = otptxts[0];
                                            otptxt2 = otptxts[1];
                                            otptxt3 = otptxts[2];
                                            otptxt4 = otptxts[3];
                                          }
                                        }));
                              },
                              child: Text(OTPVerification.appscreensdataitems[1].srntxt4, style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.037)),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: Visibility(
                              visible: OTPreceived,
                              child: Text(
                                OTPVerification.appscreensdataitems[1].srntxt5,
                                style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.037),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: Visibility(
                              visible: OTPreceived,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      child: Text(
                                        otptxt1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Aleo', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.055),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      child: Text(
                                        otptxt2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Aleo', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.055),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      child: Text(
                                        otptxt3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Aleo', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.055),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      child: Text(
                                        otptxt4,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Aleo', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.055),
                                      ),
                                    ),
                                  ])),
                        ),
                        Container(
                          //OTPreceived
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.transparent),
                          child: Visibility(
                              visible: OTPreceived,
                              child: ElevatedButton(
                                style: raisedButtonStyle,
                                onPressed: () {
                                  httpService.verifyOTP();
                                },
                                child: Text(OTPVerification.appscreensdataitems[1].srntxt6, style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.037)),
                              )),
                        ),
                      ]),
                    )));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  callToSetAppBarTitle() => createState().setAppBarTitle(OTPVerification.appscreensdataitems[2].srntxt1);
  static String requestTypeStr = "";
  static Profile selectedProfile = [] as Profile;
  static BuildContext buildContext = BuildContext as BuildContext;
  @override
  AppBarWidget createState() => AppBarWidget();
  final HttpService httpService = HttpService();

  static loadDashboardForSingleProfile() {
    Navigator.push(
        buildContext,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    callToSetAppBarTitle();
    return WillPopScope(
        onWillPop: () {
          print('Backbutton pressed (device or appbar button), do whatever you want.');
          OTPVerification.OTPreceived = false;
          OTPVerification.getotpstr = "";
          Navigator.push(
              buildContext,
              MaterialPageRoute(
                builder: (context) => OTVerficationState(),
              ));
          /*//trigger leaving and use own data
      Navigator.pop(context, false);

      //we need to return a future
      return Future.value(false);*/
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          extendBody: true,
          drawer: MenuDrawerWidget(),
          appBar: AppBarWidget(),
          body: FutureBuilder(
            future: httpService.getProfiles(),
            builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
              if (snapshot.hasData) {
                List<Profile> profiles = snapshot.data;
                return Container(
                    height: MediaQuery.of(context).size.height * 0.79,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white38,
                    ),
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          margin: EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 5.0, color: Colors.grey),
                            ),
                          ),
                          child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 100,
                                  heightFactor: 50,
                                  child: Text(
                                    OTPVerification.appscreensdataitems[2].srntxt2,
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, color: Colors.blue, fontWeight: FontWeight.bold),
                                  )))),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.79,
                        margin: EdgeInsets.all(5),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: false,
                          itemCount: profiles?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                    bottom: BorderSide(width: 1.0, color: Colors.blue),
                                    top: BorderSide(width: 1.0, color: Colors.blue),
                                    right: BorderSide(width: 1.0, color: Colors.blue),
                                    left: BorderSide(width: 1.0, color: Colors.blue),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    new BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white),
                              child: InkWell(
                                onTap: () {
                                  selectedProfile = profiles[index];
                                  print(selectedProfile.MrNo);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DashboardScreen(),
                                      ));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      margin: EdgeInsets.only(left: 5),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Text(
                                            '${profiles[index].PatientName[0]}',
                                            style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.075),
                                          )),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      width: 0.7,
                                      color: Colors.blue,
                                    ),
                                    Container(
                                        //color: Colors.yellow,
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        width: MediaQuery.of(context).size.width * 0.45,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.all(0),
                                                    color: Colors.white,
                                                    height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.45,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        profiles[index].PatientName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                                          color: Colors.blue,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.all(0),
                                                    height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        DrMohanApp.appinfoitems[0].srntxt4.split(',')[1] + ": ",
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                                          color: Colors.blue,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                    height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.30,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        profiles[index].DOB.split(" ")[0],
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.all(0),
                                                    height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        DrMohanApp.appinfoitems[0].srntxt4.split(',')[0] + ":",
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                                          color: Colors.blue,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                    height: MediaQuery.of(context).size.height * 0.02,
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        profiles[index].MrNo,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      margin: EdgeInsets.only(left: 15),
                                      child: Image.network(
                                        OTPVerification.appscreensdataitems[36].srntxt2 + "images/" + profiles[index].Gender.toLowerCase() + ".png",
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        width: MediaQuery.of(context).size.width * 0.7,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ])));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            tooltip: 'Dr. Mohan\'s',
            //child: Icon(Icons.add, color: Colors.blue),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(OTPVerification.appscreensdataitems[36].srntxt2 + 'images/dmdscLOGOsmall.png'),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {},
          ),
          /*bottomNavigationBar: BottomAppBarWidget(),*/
        ));
  }
}

class DashboardScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  static List<String> dashboardTitles = [];
  static List<String> dashboardImgUrl = [];
  static List<String> dashboardScreens = [];
  static List<SpotLightitem> spotLights = [];
  static List<Notifiesitem> notifies = [];
  static List<String> carouselList = [];
  static List<String> carousellinkTypeList = [];
  int currentCarouselIndex = 0;
  callToSetAppBarTitle() => createState().setAppBarTitle(OTPVerification.appscreensdataitems[3].srntxt1);

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  Widget build(BuildContext context) {
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      drawer: MenuDrawerWidget(),
      appBar: AppBarWidget(),
      body: FutureBuilder(
        future: httpService.getDashboardItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Dashboarditem>> snapshot) {
          if (snapshot.hasData) {
            List<Dashboarditem> dashboarditems = snapshot.data;
            return Container(
                height: MediaQuery.of(context).size.height * 0.79,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white38,
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      //width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 5.0, color: Colors.grey),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          print("tapped");
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ));*/
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(left: 3),
                              child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    ProfileScreen.selectedProfile.PatientName[0],
                                    style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.055),
                                  )),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: 0.7,
                              color: Colors.blue,
                            ),
                            Container(
                              //color: Colors.yellow,
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.6,
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(0),
                                          color: Colors.white,
                                          height: MediaQuery.of(context).size.height * 0.03,
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ProfileScreen.selectedProfile.PatientName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.032,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                      Container(
                                        color: Colors.red,
                                        height: MediaQuery.of(context).size.height * 0.03,
                                        width: MediaQuery.of(context).size.width * 0.14,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ProfileScreen(),
                                                    //builder: (context) => DoctorsListScreen(),
                                                    //builder: (context) => ChooseLocationScreen(),
                                                  ));
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                OTPVerification.appscreensdataitems[4].srntxt5,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.022,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(0),
                                          height: MediaQuery.of(context).size.height * 0.03,
                                          width: MediaQuery.of(context).size.width * 0.11,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              DrMohanApp.appinfoitems[0].srntxt4.split(',')[0] + ":",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.032,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.03,
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ProfileScreen.selectedProfile.MrNo,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.034,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(0),
                                          height: MediaQuery.of(context).size.height * 0.03,
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              DrMohanApp.appinfoitems[0].srntxt4.split(',')[1] + ": ",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.034,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.03,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ProfileScreen.selectedProfile.DOB.split(" ")[0],
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.034,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, margin: EdgeInsets.only(left: 2), child: Image.network(DrMohanApp.appinfoitems[0].srntxt2 + "/images/" + ProfileScreen.selectedProfile.Gender.toLowerCase() + ".png"))
                          ],
                        ),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        margin: EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          border: Border(
                            bottom: BorderSide(width: 0.0, color: Colors.grey),
                          ),
                        ),
                        child: Align(
                            child: Text(
                          notifies[0].Text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            color: Colors.white,
                          ),
                        )
                            /*child: Html(
                          data: notifies[0].Text,
                          defaultTextStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.043,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )*/
                            )),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: OTPVerification.appscreensdataitems[3].srntxt5.split(',').length,
                          itemBuilder: (BuildContext context, int index) {
                            return MouseRegion(
                                onHover: (event) {
                                  // appContainer.style.cursor = 'pointer';
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border(
                                          bottom: BorderSide(width: 2.0, color: Colors.lightBlueAccent),
                                          top: BorderSide(width: 2.0, color: Colors.lightBlueAccent),
                                          right: BorderSide(width: 2.0, color: Colors.lightBlueAccent),
                                          left: BorderSide(width: 2.0, color: Colors.lightBlueAccent),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          new BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        color: Colors.white),
                                    child: InkWell(
                                        onTap: () {
                                          String srn = dashboardScreens[index];
                                          loadScreen(context, srn);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, margin: EdgeInsets.all(10), child: Image.network(DrMohanApp.appinfoitems[0].srntxt2 + "" + dashboardImgUrl[index])),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.08,
                                              width: 2,
                                              color: Colors.blue,
                                            ),
                                            Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                margin: EdgeInsets.all(10),
                                                child: Html(
                                                  data: dashboardTitles[index],
                                                  defaultTextStyle: TextStyle(
                                                    fontSize: MediaQuery.of(context).size.width * 0.043,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ))
                                          ],
                                        ))));
                          },
                        )),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                        children: [
                          Text(
                            OTPVerification.appscreensdataitems[3].srntxt3,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.043,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            OTPVerification.appscreensdataitems[3].srntxt4,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.025,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        margin: EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(226, 227, 231, 1),
                          border: Border(
                            bottom: BorderSide(width: 0.0, color: Colors.grey),
                          ),
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              currentCarouselIndex = index;
                              //setState((){});
                            },
                          ),
                          items: carouselList
                              .map((item) => Container(
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: InkWell(
                                          onTap: () {
                                            //print(currentCarouselIndex);
                                          },
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                                                  /*Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            200, 0, 0, 0),
                                                        Color.fromARGB(
                                                            0, 0, 0, 0)
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                                  child: Text(
                                                    'No. image',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width * 0.043.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),*/
                                                ],
                                              ))),
                                    ),
                                  ))
                              .toList(),
                        )),
                  ],
                )));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: OTPVerification.appscreensdataitems[36].srntxt3,
        //child: Icon(Icons.add, color: Colors.blue),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(OTPVerification.appscreensdataitems[36].srntxt2 + 'images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  loadScreen(context, lVal) {
    if (lVal.toLowerCase() == "bookappointmentscreen") {
      /*RazorPaymentScreenState.HomeCollectionSelectedOption = "no";
      BookAppointmentScreen.homebloodcollectiondateUpdated = "false";
      BookAppointmentScreen.lastVisitedLocationDetailsChanged = "false";
      BookAppointmentScreen.lastVisitedDocDetailsChanged = "false";
      BookAppointmentScreen.showHomeCollectionDateInstruction = false;
      BookAppointmentScreen.showHomeCollectionTabContent = false;
      BookAppointmentScreen.paylaterselected = false;
      StatefulBottomSheetState.bsshowHomeCollectionDateInstruction = false;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookAppointmentScreenState(),
            //builder: (context) => DoctorsListScreen(),
            //builder: (context) => ChooseLocationScreen(),
          ));*/
    } else if (lVal.toLowerCase() == "healthrecordscreen") {
      /*HealthRecordClinicalSummaryScreen.selectedTestDropdownItemChanged = "false";
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthRecordScreen(),
          ));*/
    } else if (lVal.toLowerCase() == "dailyhealthtrackerscreen") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyHealthTrackerScreen(),
          ));
    } else if (lVal.toLowerCase() == "prescriptionsrefillsscreen") {
      /*PrescriptionsRefillsScreen.prescriptionDataReceived = "false";
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionsRefillsScreenStateful(),
          ));*/
    } else if (lVal.toLowerCase() == "diabetesshoppescreen") {
      /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiabetesShoppeScreenState(),
          ));*/
    }
  }
}

showSuccessToast(String str) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check),
        const SizedBox(
          width: 12.0,
        ),
        Text(str),
      ],
    ),
  );
}

showErrorToast(String str) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.warning_amber_outlined),
        const SizedBox(
          width: 12.0,
        ),
        Text(str),
      ],
    ),
  );
}
/*
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
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(urlImage)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            */
/*CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(0, 116, 191, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )*/ /*

          ],
        ),
      ),
    );
*/
