import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:drmohan/main.dart';
import 'package:drmohan/models/model_appinfo.dart';
import 'package:drmohan/models/model_appscreensdata.dart';
import 'package:drmohan/models/model_fooddetailitem.dart';
import 'package:drmohan/models/model_foodportiondetail.dart';
import 'package:drmohan/models/model_healthtrackeritem.dart';
import 'package:drmohan/models/model_healthtrackerrecord.dart';
import 'package:drmohan/models/model_notifiesitem.dart';
import 'package:drmohan/models/model_spotlightitem.dart';
import 'package:drmohan/models/model_testlistdetailitem.dart';
import 'package:drmohan/models/model_testresultitem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../models/model_dashboarditem.dart';
import '../models/model_profile.dart';

class HttpService {
  String postsURL = ""; //"https://jsonplaceholder.typicode.com/posts";
  //"https://rsolutions7.com/drmohan/languages/en_us/profiles.json";
  static Map<String, String> headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};

  getHeadersWithBearer() {
    return headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
  }

  Future<List<AppInfoItem>> getAppInfoData() async {
    //postsURL = "https://rsolutions7.com/drmohan/languages/en_us/appscreensdata.json";

    postsURL = "https://rsolutions7.com/drmohan/languages/en_us/appinfo.json";
    Response res = await get(Uri.parse(postsURL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<AppInfoItem> appinfoitemitems = body
          .map(
            (dynamic item) => AppInfoItem.fromJson(item),
          )
          .toList();
      print(appinfoitemitems.toString());
      return appinfoitemitems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<AppScreensDataItem>> getAppScreensData() async {
    //postsURL = "https://rsolutions7.com/drmohan/languages/en_us/appscreensdata.json";
    postsURL = "https://rsolutions7.com/drmohan/languages/" + DrMohanApp.appinfoitems![0].srntxt1 + "/appscreensdata.json";

    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<AppScreensDataItem> appscreensdataitem = body
          .map(
            (dynamic item) => AppScreensDataItem.fromJson(item),
          )
          .toList();
      return appscreensdataitem;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future createArray() async {
    Map<String, dynamic> myObject = {'Code': "mycode", 'Name': "", 'Rate': "", 'Type': "", 'Qty': "", 'Amount': "", 'TotalAmount': ""};

    List<Map<String, dynamic>> send = [];
    send.add(myObject);
    send[0]["Code"] = "code123";
  }

  Future getOTP() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/SendOTP";
    var body = "";
    ProfileScreen.requestTypeStr = "mrn";
    if (OTPVerification.getotpstr.length > 10) {
      final postData = {"UserID": "Rihas", "Pwd": "Riha123", "MrNo": OTPVerification.getotpstr, "Channel": "App"};
      body = json.encode(postData);
    } else {
      final postData = {"UserID": "Rihas", "Pwd": "Riha123", "Phone": OTPVerification.getotpstr, "Channel": "App"};
      ProfileScreen.requestTypeStr = "mobile";
      body = json.encode(postData);
    }

    //"TEMPTNGPM004238",
    //{"Phone":"9698694094","Mrno":"TEMPTNGPM004238","OTP":"1234","TokenValue":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSaWhhcyIsImp0aSI6IjUxYTUyY2RjLTA4NDYtNDYzZi1iMjRjLWY3ZGViMDA1NTIzYyIsImV4cCI6MTY0NjU2NTcxMiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3QifQ.eYKhJtQOaZOop2FmRTmM4M5Z5yydqpb86OlQUKlT7Z8","Status":"Success","Channel":"App"}
    //encode Map to JSON
    var res = await post(Uri.parse(postsURL), headers: {"Content-Type": "application/json"}, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      if ((jsonData["Status"].toString().toLowerCase().replaceAll(" ", "") == "fails")) {
        Fluttertoast.showToast(msg: OTPVerification.appscreensdataitems[1].srntxt7, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        return;
      }
      if (jsonData["Status"].toString().toLowerCase().replaceAll(" ", "") != "norecords") {
        //final data = jsonDecode(res.body).decoded['OTP'];
        OTPVerification.phone = jsonData["Phone"].toString();
        /*OTPVerification.otptxt1 = jsonData["OTP"][0];
      OTPVerification.otptxt2 = jsonData["OTP"][1];
      OTPVerification.otptxt3 = jsonData["OTP"][2];
      OTPVerification.otptxt4 = jsonData["OTP"][3];*/
        OTPVerification.updateOTPTexts(jsonData["OTP"]);
        OTPVerification.verifyotpstr = jsonData["OTP"].toString();
        OTPVerification.tokenstr = jsonData["TokenValue"].toString();
        OTPVerification.OTPreceived = true;
      } else {
        Fluttertoast.showToast(msg: OTPVerification.appscreensdataitems[1].srntxt7, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 20.0);
      }
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future verifyOTP() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/VerifyOTP";
    var body = "";
    final postData = {"Phone": OTPVerification.phone, "OTP": OTPVerification.verifyotpstr, "Channel": "App"};
    body = json.encode(postData);

    //"TEMPTNGPM004238",
    //{"Phone":"9698694094","Mrno":"TEMPTNGPM004238","OTP":"1234","TokenValue":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSaWhhcyIsImp0aSI6IjUxYTUyY2RjLTA4NDYtNDYzZi1iMjRjLWY3ZGViMDA1NTIzYyIsImV4cCI6MTY0NjU2NTcxMiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3QifQ.eYKhJtQOaZOop2FmRTmM4M5Z5yydqpb86OlQUKlT7Z8","Status":"Success","Channel":"App"}
    //encode Map to JSON
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      if (res.body.replaceAll('"', '') == '1') {
        OTPVerification.loadProfileScreen();
      }
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Profile>> getProfiles() async {
    var body = "";
    if (ProfileScreen.requestTypeStr == "mrn") {
      final postData = {"MrNo": OTPVerification.getotpstr, "Channel": "App"};
      body = json.encode(postData);
      postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetPatientDetails";
    } else {
      final postData = {"Phone": OTPVerification.phone, "Channel": "App"};
      body = json.encode(postData);
      postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetPatientDetailsbyMobile";
    }
    var res = await post(Uri.parse(postsURL), headers: getHeadersWithBearer(), body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> body = jsonData["lstdata"];
      List<Profile> profiles = body
          .map(
            (dynamic item) => Profile.fromJson(item),
          )
          .toList();
      if (profiles.length == 1) {
        ProfileScreen.selectedProfile = profiles[0];
        ProfileScreen.loadDashboardForSingleProfile();
      }
      return profiles;
      /*List<dynamic> body = jsonDecode(res.body);
      List<Profile> profiles = body
          .map(
            (dynamic item) => Profile.fromJson(item),
          )
          .toList();
      return profiles;*/
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Dashboarditem>> getDashboardItems() async {
    DashboardScreen.dashboardTitles = OTPVerification.appscreensdataitems![3].srntxt5.split(',');
    DashboardScreen.dashboardImgUrl = OTPVerification.appscreensdataitems![3].srntxt6.split(',');
    DashboardScreen.dashboardScreens = OTPVerification.appscreensdataitems![3].srntxt7.split(',');
    var body = "";
    postsURL = 'http://drmohansdiabetes.net/dmdscwebapi/api/GetDashboard';
    final postData = {"MrNo": ProfileScreen.selectedProfile.MrNo, "Channel": "App"};
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempspotLights = jsonData["spotLights"];
      DashboardScreen.spotLights = tempspotLights
          .map(
            (dynamic item) => SpotLightitem.fromJson(item),
          )
          .toList();
      List<dynamic> tempnotifies = jsonData["notifies"];
      DashboardScreen.notifies = tempnotifies
          .map(
            (dynamic item) => Notifiesitem.fromJson(item),
          )
          .toList();
      DashboardScreen.carouselList = [];
      for (var i = 0; i < jsonData["spotLights"].length; i++) {
        if (jsonData["spotLights"][i]["linkType"].toString().toLowerCase() == "image") {
          DashboardScreen.carouselList.add(jsonData["spotLights"][i]["link"]);
          DashboardScreen.carousellinkTypeList.add(jsonData["spotLights"][i]["linkType"]);
        }
      }
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  //Future getLastVisit() async {
  /*Future<List<Dashboarditem>> getLastVisit() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetLastVisit";
    var body = "";

    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "EXTTNGPM004611",
      "Channel": "App"
    };
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(res.body);
      print("BookAppointmentScreen.appointmentbooked");
      if (jsonData["Appointment"]["AppointmentStatus"].toString().toLowerCase().replaceAll(" ", "") == "appointmentbooked") {
        BookAppointmentScreen.appointmentbooked = true;
      } else if (jsonData["Appointment"]["AppointmentStatus"].toString().toLowerCase().replaceAll(" ", "") == "slotavailable") {
        BookAppointmentScreen.appointmentbooked = false;
      }
      String badatestr = (jsonData["Appointment"]["AppointmentDate"].toString());
      print("badatestr -- " + badatestr);
      //String badateyr = badatestr.split(" ");

      BookAppointmentScreen.appointmentDate = jsonData["Appointment"]["AppointmentDate"].toString();
      print("BookAppointmentScreen.appointmentbooked");
      //DrMohanApp.appinfoitems[0].srntxt2;
      String imgClickMeURL = DrMohanApp.appinfoitems[0].srntxt2 + "images/clickmeimgurl.png";
      //jsonData["VstLst"][0]["DrImgUrl"] = "";
      //jsonData["VstLst"][0]["DrName"] = "";
      print("BookAppointmentScreen.lastVisitedDocDetailsChanged " + BookAppointmentScreen.lastVisitedDocDetailsChanged);
      if (BookAppointmentScreen.lastVisitedDocDetailsChanged == "false") {
        if ((jsonData["VstLst"][0]["DrImgUrl"] != "") && (jsonData["VstLst"][0]["DrImgUrl"] != null)) {
          BookAppointmentScreen.lastVisitedDocImgURL = jsonData["VstLst"][0]["DrImgUrl"];
        } else {
          BookAppointmentScreen.lastVisitedDocImgURL = imgClickMeURL;
        }
        if ((jsonData["VstLst"][0]["DrName"] != "") && (jsonData["VstLst"][0]["DrName"] != null)) {
          BookAppointmentScreen.lastVisitedDocName = jsonData["VstLst"][0]["DrName"];
        } else {
          BookAppointmentScreen.lastVisitedDocName = "Select doctor";
        }
        if ((jsonData["VstLst"][0]["DrID"] != "") && (jsonData["VstLst"][0]["DrID"] != null)) {
          BookAppointmentScreen.lastVisitedDocId = jsonData["VstLst"][0]["DrID"];
        } else {
          BookAppointmentScreen.lastVisitedDocId = "";
        }
      }
      if (BookAppointmentScreen.lastVisitedLocationDetailsChanged == "false") {
        if ((jsonData["VstLst"][0]["LocID"] != "") && (jsonData["VstLst"][0]["LocID"] != null)) {
          BookAppointmentScreen.lastVisitedLocId = jsonData["VstLst"][0]["LocID"];
        } else {
          BookAppointmentScreen.lastVisitedLocId = "1082";
        }
        if ((jsonData["VstLst"][0]["LocID"] != "") && (jsonData["VstLst"][0]["LocID"] != null)) {
          BookAppointmentScreen.lastVisitedLocName = jsonData["VstLst"][0]["LocName"];
        } else {
          BookAppointmentScreen.lastVisitedLocName = "Gopalapuram-IP";
        }
      }
      GetLeaveDateList();
      //import 'package:intl/intl.dart';

      //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(jsonData["VstLst"][0]["EncounteredDate"]);
      //String formattedEncounteredDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(jsonData["VstLst"][0]["EncounteredDate"]).toString();
      //DateTime dateTime = DateFormat("MM/dd/yyyy HH:mm:ss").parse("18-11-2021 8:40:23");
      //print(dateTime.toString()); // something like 2013-04-20

      */ /*print(jsonData["VstLst"][0]["EncounteredDate"].split(" ")[0].toString().replaceAll("-", "/"));
      print("formatted");*/ /*
      //BookAppointmentScreen.appointmentDate = jsonData["Appointment"]["AppointmentDate"];
      //BookAppointmentScreen.appointmentDate = jsonData["VstLst"][0]["EncounteredDate"].split(" ")[0].toString().replaceAll("-", "/");
      BookAppointmentScreen.appointmentStatus = jsonData["Appointment"]["AppointmentStatus"];
    } else {
      throw "Unable to retrieve posts.";
    }
    return [];
  }

  Future GetLeaveDateList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetLeaveDateList";
    var body = "";
    final postData = {"Channel": "App", "locid": BookAppointmentScreen.lastVisitedLocId, "type": "H"};
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      String fromDateStr = jsonData["FromDate"].replaceAll("T", " ").replaceAll("Z", "").toString() + ".000";
      int baFromDateyr = int.parse(fromDateStr.split(" ")[0].split("-")[0]);
      int baFromDatemn = int.parse(fromDateStr.split(" ")[0].split("-")[1]);
      int baFromDatede = int.parse(fromDateStr.split(" ")[0].split("-")[2]);
      BookAppointmentScreen.baFromDate = DateTime(baFromDateyr, baFromDatemn, baFromDatede);

      String endDateStr = jsonData["ToDate"].replaceAll("T", " ").replaceAll("Z", "").toString() + ".000";
      int baEndDateyr = int.parse(endDateStr.split(" ")[0].split("-")[0]);
      int baEndDatemn = int.parse(endDateStr.split(" ")[0].split("-")[1]);
      int baEndDatede = int.parse(endDateStr.split(" ")[0].split("-")[2]);

      BookAppointmentScreen.baEndDate = DateTime(baEndDateyr, baEndDatemn, baEndDatede);

      List<dynamic> tempsdocleaves = jsonData["List"];
      BookAppointmentScreen.doctorleaves = [];
      BookAppointmentScreen.doctorleavesDateTime = [];
      for (var i = 0; i < tempsdocleaves.length; i++) {
        BookAppointmentScreen.doctorleaves.add(tempsdocleaves[i]["Date"].split("T")[0].toString());
        int badocleaveyr = int.parse(tempsdocleaves[i]["Date"].split("T")[0].split("-")[0]);
        int badocleavemn = int.parse(tempsdocleaves[i]["Date"].split("T")[0].split("-")[1]);
        int badocleavede = int.parse(tempsdocleaves[i]["Date"].split("T")[0].split("-")[2]);
        DateTime badocleaveDate = DateTime(badocleaveyr, badocleavemn, badocleavede);
        BookAppointmentScreen.doctorleavesDateTime.add(badocleaveDate);
      }
      BookAppointmentScreen.doctorleavesDateTime.sort(((a, b) => a.compareTo(b)));
      List<DateTime> days = [];
      BookAppointmentScreen.doctoravailableDateTime = [];
      for (int i = 0; i <= BookAppointmentScreen.baEndDate.difference(BookAppointmentScreen.baFromDate).inDays; i++) {
        days.add(DateTime(BookAppointmentScreen.baFromDate.year, BookAppointmentScreen.baFromDate.month, BookAppointmentScreen.baFromDate.day + i));
        //BookAppointmentScreen.doctoravailableDateTime.add(DateTime(BookAppointmentScreen.baFromDate.year, BookAppointmentScreen.baFromDate.month, BookAppointmentScreen.baFromDate.day + i));
      }
      for (var i = 0; i < BookAppointmentScreen.doctorleavesDateTime.length; i++) {
        if (days.contains(BookAppointmentScreen.doctorleavesDateTime[i])) {
          DateTime obj = BookAppointmentScreen.doctorleavesDateTime[i];
          days.remove(obj);
          //BookAppointmentScreen.doctoravailableDateTime.remove(obj);
        }
      }
      BookAppointmentScreen.doctoravailableDateTime = days;
    } else {
      throw "Unable to retrieve posts.";
    }
    return [];
  }

  Future<List<Dashboarditem>> GetLastTestAdvice() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetLastTestAdvice";
    var body = "";
    RazorPaymentScreenState.hospitalvisitDate = BookAppointmentScreen.appointmentDate;
    var formattedDate = "";
    if (BookAppointmentScreen.appointmentDate.contains("/")) {
      var dateArr = BookAppointmentScreen.appointmentDate.split("/");
      formattedDate = dateArr[1] + "/" + dateArr[0] + "/" + dateArr[2];
    }
    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      "locid": BookAppointmentScreen.lastVisitedLocId,
      "Channel": "App",
      "AppointmentDate": formattedDate //BookAppointmentScreen.appointmentDate
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      RazorPaymentScreenState.testIDList = [];
      RazorPaymentScreenState.testNameList = [];
      RazorPaymentScreenState.testDaysDueList = [];
      RazorPaymentScreenState.testAmountList = [];
      RazorPaymentScreenState.totalAmountfortest = "0";
      List<dynamic> tempLastTestItems = jsonData["tstList"];
      RazorPaymentScreenState.testListItemsforBookAppointment = jsonData["tstList"];
      if (tempLastTestItems != null) {
        RazorPaymentScreenState.testListItems = tempLastTestItems
            .map(
              (dynamic item) => TestListItem.fromJson(item),
            )
            .toList();
        int tAmount = 0;
        for (var i = 0; i < tempLastTestItems.length; i++) {
          RazorPaymentScreenState.testIDList.add(tempLastTestItems[i]["TestID"]);
          RazorPaymentScreenState.testNameList.add(tempLastTestItems[i]["TestName"]);
          RazorPaymentScreenState.testDaysDueList.add(tempLastTestItems[i]["TestID"]);
          RazorPaymentScreenState.testAmountList.add(tempLastTestItems[i]["Rate"]);
          tAmount = tAmount + int.parse(tempLastTestItems[i]["Rate"]);
        }
        RazorPaymentScreenState.testListItemsforBookAppointmentOrDets = [];
        for (var j = 0; j < tempLastTestItems.length; j++) {
          Map<String, dynamic> myObject = {'Code': "mycode", 'Name': "", 'Amount': "", 'TotalAmount': ""};
          RazorPaymentScreenState.testListItemsforBookAppointmentOrDets.add(myObject);
          RazorPaymentScreenState.testListItemsforBookAppointmentOrDets[j]["Code"] = tempLastTestItems[j]["TestID"].toString();
          RazorPaymentScreenState.testListItemsforBookAppointmentOrDets[j]["Name"] = tempLastTestItems[j]["TestName"].toString();
          RazorPaymentScreenState.testListItemsforBookAppointmentOrDets[j]["Amount"] = tempLastTestItems[j]["Rate"].toString();
          RazorPaymentScreenState.testListItemsforBookAppointmentOrDets[j]["TotalAmount"] = tAmount.toString();
        }
        RazorPaymentScreenState.totalAmountfortest = tAmount.toString();
      } else {
        tempLastTestItems = [];
      }
    } else {
      throw "Unable to retrieve posts.";
    }
    GetAddressList();
    return [];
  }

  Future GetAddressList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetAddressList";
    var body = "";
    final postData = {
      "Phone": ProfileScreen.selectedProfile.Phone,
      "Channel": "App",
    };
    body = json.encode(postData);
    print(body);
    print("addresslistbody");
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List<dynamic> tempaddressitems = jsonData["addressList"];
      print(tempaddressitems.length);
      print("tempaddressitems.length ");
      print(tempaddressitems);

      if (tempaddressitems != null) {
        List<Addressitem> addressitems = tempaddressitems
            .map(
              (dynamic item) => Addressitem.fromJson(item),
            )
            .toList();
        RazorPaymentScreenState.addressIdList = [];
        RazorPaymentScreenState.addressList = [];
        RazorPaymentScreenState.pincodeList = [];
        RazorPaymentScreenState.cateogryIdList = [];
        RazorPaymentScreenState.addressLatList = [];
        RazorPaymentScreenState.addressLonList = [];
        print(tempaddressitems.length);
        print("length");
        Map<String, dynamic> myAddressObject = {'AddressID': "0", 'Address': "No data available", 'Pincode': "", 'Category': "", 'Lat': "", 'Long': ""};
        if (tempaddressitems.length == 0) {
          print("if");
          RazorPaymentScreenState.addressIdList.add("0");
          RazorPaymentScreenState.addressList.add("Address not available");
          RazorPaymentScreenState.pincodeList.add("0");
          RazorPaymentScreenState.cateogryIdList.add("0");
          RazorPaymentScreenState.addressLatList.add("0");
          RazorPaymentScreenState.addressLonList.add("0");
          print(RazorPaymentScreenState.addressList);
          print("RazorPaymentScreenState.addressList ");
        } else {
          print("else");
          for (var i = 0; i < tempaddressitems.length; i++) {
            RazorPaymentScreenState.addressIdList.add(tempaddressitems[i]["AddressID"].toString());
            RazorPaymentScreenState.addressList.add(tempaddressitems[i]["Address"].toString());
            RazorPaymentScreenState.pincodeList.add(tempaddressitems[i]["Pincode"].toString());
            RazorPaymentScreenState.cateogryIdList.add(tempaddressitems[i]["Category"].toString());
            RazorPaymentScreenState.addressLatList.add(tempaddressitems[i]["Lat"].toString());
            RazorPaymentScreenState.addressLonList.add(tempaddressitems[i]["Long"].toString());
          }
        }
        RazorPaymentScreenState.selectedAddress = RazorPaymentScreenState.addressList[0];
        RazorPaymentScreenState.selectedLat = RazorPaymentScreenState.addressLatList[0];
        RazorPaymentScreenState.selectedLon = RazorPaymentScreenState.addressLonList[0];
      } else {
        RazorPaymentScreenState.addressIdList = [];
        RazorPaymentScreenState.addressList = [];
        RazorPaymentScreenState.pincodeList = [];
        RazorPaymentScreenState.cateogryIdList = [];
        RazorPaymentScreenState.addressLatList = [];
        RazorPaymentScreenState.addressLonList = [];

        RazorPaymentScreenState.addressIdList.add("0");
        RazorPaymentScreenState.addressList.add("Data not available");
        RazorPaymentScreenState.pincodeList.add("0");
        RazorPaymentScreenState.cateogryIdList.add("0");
        RazorPaymentScreenState.addressLatList.add("0");
        RazorPaymentScreenState.addressLonList.add("0");
        RazorPaymentScreenState.selectedAddress = RazorPaymentScreenState.addressList[0];
        RazorPaymentScreenState.selectedLat = RazorPaymentScreenState.addressLatList[0];
        RazorPaymentScreenState.selectedLon = RazorPaymentScreenState.addressLonList[0];
        print(RazorPaymentScreenState.addressList);
        print("RazorPaymentScreenState.addressList2 ");
      }

      //return addressitems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future BookAppointment() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/BookAppointment";

    //if (BookAppointmentScreen.appointmentDate.length > 0) {
    print(BookAppointmentScreen.appointmentDate);
    print("BookAppointmentScreen.appointmentDateBookAppointment");
    var dateBAArr = BookAppointmentScreen.appointmentDate.split("/");
    var formattedBADate = dateBAArr[1] + "/" + dateBAArr[0] + "/" + dateBAArr[2];
    print(BookAppointmentScreen.appointmentDate);
    print("BookAppointmentScreen.appointmentDate");
    var formattedHCDate = "";
    if (RazorPaymentScreenState.homebloodcollectiondate.length > 0) {
      var dateHCArr = RazorPaymentScreenState.homebloodcollectiondate.split("/");
      formattedHCDate = dateHCArr[1] + "/" + dateHCArr[0] + "/" + dateHCArr[2];
    } else {
      formattedHCDate = formattedBADate;
    }
    print(RazorPaymentScreenState.homebloodcollectiondate.length);
    print(formattedHCDate);
    print(formattedBADate);
    print("formattedHCDate -->");
    var body = "";
    final postData = {"PatientType": "R", "MRNo": ProfileScreen.selectedProfile.MrNo, "PatientName": ProfileScreen.selectedProfile.PatientName, "Age": ProfileScreen.selectedProfile.Age, "Gender": ProfileScreen.selectedProfile.Gender, "MobileNo": ProfileScreen.selectedProfile.Phone, "EmailID": ProfileScreen.selectedProfile.Email, "DrID": BookAppointmentScreen.lastVisitedDocId, "LocID": BookAppointmentScreen.lastVisitedLocId, "AppointmentDate": formattedBADate, "HomeCollection": RazorPaymentScreenState.HomeCollectionSelectedOption, "HCDate": formattedHCDate, "Address": RazorPaymentScreenState.selectedAddress, "Village": ProfileScreen.selectedProfile.Village, "City": ProfileScreen.selectedProfile.City, "Pincode": ProfileScreen.selectedProfile.Pincode, "TeleConsult": "", "TestPath": "", "Lat": RazorPaymentScreenState.selectedLat, "Long": RazorPaymentScreenState.selectedLon, "Channel": "App", "orDet": RazorPaymentScreenState.testListItemsforBookAppointmentOrDets, "orTotalAmount": RazorPaymentScreenState.totalAmountfortest};
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      //if(res.BookingID != null)
      var jsonData = jsonDecode(res.body);
      print(res.body);
      print(" BookAppointment res.body ");
      BookAppointmentSuccessScreen.BookingID = jsonData["BookingID"];
      BookAppointmentSuccessScreen.AppointmentDate = jsonData["AppointmentDate"];
      RazorPaymentScreenState.loadBookAppointmentSuccessScreen();
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<PrescriptionListItem>> GetPrescriptionList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetPrescriptionList";
    var body = "";

    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "TNGPM0000112597",
      "Channel": "App",
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempPrescriptionListItems = jsonData["presList"];
      if (tempPrescriptionListItems != null) {
        PrescriptionsRefillsScreen.prescriptionlistitems = tempPrescriptionListItems
            .map(
              (dynamic item) => PrescriptionListItem.fromJson(item),
            )
            .toList();
        if (PrescriptionsRefillsScreen.prescriptionDataReceived == "false") {
          PrescriptionsRefillsScreen.prescriptionlistitemslength = tempPrescriptionListItems.length;
          PrescriptionsRefillsScreen.prescriptionlistitemslengthforoutercontainer = tempPrescriptionListItems.length;
          double tPrescriptionAmount = 0;
          PrescriptionsRefillsScreen.prescriptionorderlistitems = [];
          PrescriptionsRefillsScreen.qtycontrollers = [];
          for (var i = 0; i < tempPrescriptionListItems.length; i++) {
            double tempTotal = 0;
            tempTotal = (double.parse(tempPrescriptionListItems[i]["rate"]) * int.parse(tempPrescriptionListItems[i]["qty"]));
            tPrescriptionAmount = tPrescriptionAmount + tempTotal;
            Map<String, dynamic> myObject = {'Code': "mycode", 'Name': "", 'Rate': "", 'Type': "", 'Qty': "", 'Amount': "", 'TotalAmount': ""};
            List<Map<String, dynamic>> send = [];
            send.add(myObject);
            PrescriptionsRefillsScreen.prescriptionorderlistitems.add(myObject);
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Code"] = tempPrescriptionListItems[i]["generic"].toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Name"] = tempPrescriptionListItems[i]["ItemName"].toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Rate"] = tempPrescriptionListItems[i]["rate"].toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Type"] = tempPrescriptionListItems[i]["uom"].toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Qty"] = tempPrescriptionListItems[i]["qty"].toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Amount"] = tempTotal.toString();
            PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["TotalAmount"] = tPrescriptionAmount.toString();
            PrescriptionsRefillsScreen.qtycontrollers.add(new TextEditingController(text: tempPrescriptionListItems[i]["qty"].toString()));

            if (PrescriptionsRefillsScreen.qtycontrollers.length > 0) {
              PrescriptionsRefillsScreen.qtycontrollers[i].text = (int.parse(tempPrescriptionListItems[i]["qty"])).toString();
            }
          }
          PrescriptionsRefillsScreen.showprescriptiondays = true;
          PrescriptionsRefillsScreen.totalAmountforprescription = tPrescriptionAmount.toStringAsFixed(2);

          PrescriptionsRefillsScreen.prescriptionDataReceived = "true";
        }
      } else {
        PrescriptionsRefillsScreen.prescriptionlistitems = [];
        PrescriptionsRefillsScreen.showprescriptiondays = false;
        PrescriptionsRefillsScreen.prescriptionlistitemslength = 0;
        PrescriptionsRefillsScreen.prescriptionlistitemslengthforoutercontainer = 2;
        PrescriptionsRefillsScreen.totalAmountforprescription = "0";
      }
    } else {
      throw "Unable to retrieve posts.";
    }
    return [];
  }

  Future PrescriptionByDays() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/PrescriptionByDays";
    var body = "";

    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "TNGPM0000112597",
      "Days": PrescriptionsRefillsScreen.PrescriptionDays,
      "Channel": "App",
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempPrescriptionListItems = jsonData["presList"];
      if (tempPrescriptionListItems != null) {
        PrescriptionsRefillsScreen.prescriptionlistitems = tempPrescriptionListItems
            .map(
              (dynamic item) => PrescriptionListItem.fromJson(item),
            )
            .toList();
        //if (PrescriptionsRefillsScreen.prescriptionDataReceived == "false") {
        PrescriptionsRefillsScreen.prescriptionlistitemslength = tempPrescriptionListItems.length;
        PrescriptionsRefillsScreen.prescriptionlistitemslengthforoutercontainer = tempPrescriptionListItems.length;
        double tPrescriptionAmount = 0;
        PrescriptionsRefillsScreen.prescriptionorderlistitems = [];
        for (var i = 0; i < tempPrescriptionListItems.length; i++) {
          double tempTotal = 0;
          tempTotal = (double.parse(tempPrescriptionListItems[i]["rate"]) * int.parse(tempPrescriptionListItems[i]["qty"]));
          tPrescriptionAmount = tPrescriptionAmount + tempTotal;
          Map<String, dynamic> myObject = {'Code': "mycode", 'Name': "", 'Rate': "", 'Type': "", 'Qty': "", 'Amount': "", 'TotalAmount': ""};
          List<Map<String, dynamic>> send = [];
          send.add(myObject);
          PrescriptionsRefillsScreen.prescriptionorderlistitems.add(myObject);
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Code"] = tempPrescriptionListItems[i]["generic"].toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Name"] = tempPrescriptionListItems[i]["ItemName"].toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Rate"] = tempPrescriptionListItems[i]["rate"].toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Type"] = tempPrescriptionListItems[i]["uom"].toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Qty"] = tempPrescriptionListItems[i]["qty"].toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["Amount"] = tempTotal.toString();
          PrescriptionsRefillsScreen.prescriptionorderlistitems[i]["TotalAmount"] = tPrescriptionAmount.toString();
        }
        PrescriptionsRefillsScreen.totalAmountforprescription = tPrescriptionAmount.toStringAsFixed(2);
        //PrescriptionsRefillsScreen.prescriptionDataReceived = "true";
        PrescriptionsRefillsScreen.setPrescriptionByDays();
        //}
      } else {
        PrescriptionsRefillsScreen.prescriptionlistitems = [];
        PrescriptionsRefillsScreen.prescriptionlistitemslength = 0;
        PrescriptionsRefillsScreen.prescriptionlistitemslengthforoutercontainer = 2;
        PrescriptionsRefillsScreen.totalAmountforprescription = "0";
      }
    } else {
      throw "Unable to retrieve posts.";
    }
    //return [];
  }

  Future OrderPrescription() async {
    //postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/OrdersRequest";
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/Orders";

    print("OrderPrescription -->");
    var body = "";
    final postData = {
      "PatientType": "M",
      "MRNo": ProfileScreen.selectedProfile.MrNo,
      "PatientName": ProfileScreen.selectedProfile.PatientName,
      "Age": ProfileScreen.selectedProfile.Age,
      "Gender": ProfileScreen.selectedProfile.Gender,
      "MobileNo": ProfileScreen.selectedProfile.Phone,
      "EmailID": ProfileScreen.selectedProfile.Email,
      "MedicinePath": "test1_medicine.pdf",
      */ /*"DrID": BookAppointmentScreen.lastVisitedDocId,
      "LocID": BookAppointmentScreen.lastVisitedLocId,
      "AppointmentDate": BookAppointmentScreen.appointmentDate,
      "HomeCollection": RazorPaymentScreenState.HomeCollectionSelectedOption,
      "HCDate": RazorPaymentScreenState.homebloodcollectiondate,
      "Address": RazorPaymentScreenState.selectedAddress,
      "Village": ProfileScreen.selectedProfile.Village,
      "City": ProfileScreen.selectedProfile.City,
      "Pincode": ProfileScreen.selectedProfile.Pincode,
      "TeleConsult": "",
      "TestPath": "",
      "Lat": RazorPaymentScreenState.selectedLat,
      "Long": RazorPaymentScreenState.selectedLon,*/ /*
      "Channel": "App",
      "orDet": PrescriptionsRefillsScreen.prescriptionorderlistitems,
      "orTotalAmount": PrescriptionsRefillsScreen.totalAmountforprescription
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body); //{"OrderID":"538","OrderDate":"01-06-2022","Status":"Ordered"}
      if (jsonData["Status"].toString().toLowerCase() == "ordered") {
        PrescriptionOrderedsuccess.OrderID = jsonData["OrderID"];
        PrescriptionOrderedsuccess.OrderDate = jsonData["OrderDate"];
        PrescriptionsRefillsScreen.loadPrescriptionOrderedsuccessScreen();
      }
    } else {
      throw "Unable to retrieve posts.";
    }
  }*/
/*
  Future<String> uploadFiles(List<String> paths) async {
    Uri uri = Uri.parse('https://rsolutions7.com/drmohan');
    MultipartRequest request = MultipartRequest('POST', uri);
    for (String path in paths) {
      request.files.add(await MultipartFile.fromPath('files', path));
    }

    StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    print('\n\n');
    return responseString;
  }

  Future SaveAddress() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/SaveAddress";
    var body = "";
    //RazorPaymentScreenState.selectedIndex
    final postData = {
      {"MrNo": ProfileScreen.selectedProfile.MrNo, "Phone": ProfileScreen.selectedProfile.Phone, "FlatNo": RazorPaymentScreenState.selectedAddress.split(",")[0], "Street": StatefulBottomSheetState.Street, "Area": StatefulBottomSheetState.Area, "City": StatefulBottomSheetState.City, "Pincode": StatefulBottomSheetState.Pincode, "Category": StatefulBottomSheetState.locType, "Lat": StatefulBottomSheetState.selectedLocLat, "Long": StatefulBottomSheetState.selectedLocLon, "Channel": "App"}
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    //var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    /*if (res.statusCode == 200) {
      print(res.body);
      if (res.body.replaceAll('"', '') == 'Success') {
        // OTPVerification.loadProfileScreen();
      }
    } else {
      throw "Unable to retrieve posts.";
    }*/
  }

  Future<List<Doctoritem>> getDoctorItems() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetDrList";
    var body = "";
    final postData = {
      //BookAppointmentScreen.lastVisitedLocId,
      "locid": BookAppointmentScreen.lastVisitedLocId,
      //"locid": "1083",
      "Channel": "App",
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> body = jsonData["drLst"];
      List<Doctoritem> doctoritems = body
          .map(
            (dynamic item) => Doctoritem.fromJson(item),
          )
          .where((o) => o.Display == 'YES')
          .toList();
      DoctorsListScreen.doctorsCount = doctoritems.length;
      DoctorsListScreen.selectedDoctor = doctoritems[0];
      return doctoritems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Locationitem>> getLocationItems() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetBranchList";
    var body = "";
    final postData = {"Channel": "App"};
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> body = jsonData["brnLst"];
      List<Locationitem> locationitems = body
          .map(
            (dynamic item) => Locationitem.fromJson(item),
          )
          .toList();

      if (ChooseLocationScreen.searchString.isEmpty) {
        ChooseLocationScreen.SearchLocationitems = locationitems;
        ChooseLocationScreen.duplicateSearchLocationitems = locationitems;
        ChooseLocationScreen.setMarkers();
        //ChooseLocationScreen.datareceived = "true";
        //return [];
      }
      return locationitems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<HealthRecorditem>> getHealthRecordClinicalSummaryItems() async {
    HealthRecordClinicalSummaryScreen.clinicalsummaryTitles = OTPVerification.appscreensdataitems![21].srntxt2.split(',');
    HealthRecordClinicalSummaryScreen.clinicalsummaryImgUrl = OTPVerification.appscreensdataitems![21].srntxt5.split(',');
    HealthRecordClinicalSummaryScreen.clinicalsummaryScreens = OTPVerification.appscreensdataitems![21].srntxt6.split(',');
    var body = "";
    postsURL = 'http://drmohansdiabetes.net/dmdscwebapi/api/GetTestList';
    final postData = {
      //"MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "TNGPM0000219100",
      "Channel": "App"
    };
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempClinicalSummaryItems = jsonData["testList"];
      HealthRecordClinicalSummaryScreen.clinicalSummayItems = tempClinicalSummaryItems
          .map(
            (dynamic item) => ClinicalSummayItem.fromJson(item),
          )
          .toList();
      HealthRecordClinicalSummaryScreen.testNamesList = [];
      HealthRecordClinicalSummaryScreen.testIdsList = [];
      HealthRecordClinicalSummaryScreen.yAxisStartValueList = [];
      HealthRecordClinicalSummaryScreen.yAxisEndValueList = [];
      HealthRecordClinicalSummaryScreen.yAxisRangeValueList = [];
      HealthRecordClinicalSummaryScreen.refStartRangeList = [];
      HealthRecordClinicalSummaryScreen.refEndRangeList = [];
      for (var i = 0; i < tempClinicalSummaryItems.length; i++) {
        HealthRecordClinicalSummaryScreen.testNamesList.add(tempClinicalSummaryItems[i]["TestShName"]);
        HealthRecordClinicalSummaryScreen.testIdsList.add(tempClinicalSummaryItems[i]["TestID"]);

        HealthRecordClinicalSummaryScreen.yAxisStartValueList.add(tempClinicalSummaryItems[i]["YAxisStartValue"]);
        HealthRecordClinicalSummaryScreen.yAxisEndValueList.add(tempClinicalSummaryItems[i]["YAxisEndValue"]);
        HealthRecordClinicalSummaryScreen.yAxisRangeValueList.add(tempClinicalSummaryItems[i]["YAxisRange"]);
        HealthRecordClinicalSummaryScreen.refStartRangeList.add(tempClinicalSummaryItems[i]["StartReferenceRange"]);
        HealthRecordClinicalSummaryScreen.refEndRangeList.add(tempClinicalSummaryItems[i]["EndReferenceRange"]);
      }
      if (HealthRecordClinicalSummaryScreen.selectedTestDropdownItemChanged == "false") {
        HealthRecordClinicalSummaryScreen.selectedTest = HealthRecordClinicalSummaryScreen.testNamesList[0];
        HealthRecordClinicalSummaryScreen.selectedTestId = HealthRecordClinicalSummaryScreen.testIdsList[HealthRecordClinicalSummaryScreen.testNamesList.indexOf(HealthRecordClinicalSummaryScreen.selectedTest)];
        getHealthRecordClinicalSummaryTestResultItems();
      }
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<HealthRecorditem>> getHealthRecordClinicalSummaryTestResultItems() async {
    var body = "";
    postsURL = 'http://drmohansdiabetes.net/dmdscwebapi/api/GetTestResultList';
    final postData = {
      //"MrNo": "TNGPM0000050459",
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      "TestID": HealthRecordClinicalSummaryScreen.selectedTestId,
      "Channel": "App"
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempClinicalSummaryTestResultItems = [];
      tempClinicalSummaryTestResultItems = jsonData["testResults"];
      print(tempClinicalSummaryTestResultItems);
      print(tempClinicalSummaryTestResultItems.length);
      print("tempClinicalSummaryTestResultItems");
      if (tempClinicalSummaryTestResultItems.length > 1) {
        print(tempClinicalSummaryTestResultItems.length);
        print("---");
        HealthRecordClinicalSummaryScreen.visitDateList = [];
        HealthRecordClinicalSummaryScreen.resultList = [];
        HealthRecordClinicalSummaryScreen.refRangeList = [];
        HealthRecordClinicalSummaryScreen.gridDataList = [];
        for (var i = 0; i < tempClinicalSummaryTestResultItems.length; i++) {
          HealthRecordClinicalSummaryScreen.visitDateList.add(tempClinicalSummaryTestResultItems[i]["VisitDate"]);
          HealthRecordClinicalSummaryScreen.resultList.add(tempClinicalSummaryTestResultItems[i]["Result"]);
          HealthRecordClinicalSummaryScreen.refRangeList.add(tempClinicalSummaryTestResultItems[i]["RefRange"]);
          HealthRecordClinicalSummaryScreen.gridDataList.add(tempClinicalSummaryTestResultItems[i]["VisitDate"].split(" ")[0]);
          HealthRecordClinicalSummaryScreen.gridDataList.add(tempClinicalSummaryTestResultItems[i]["Result"].toString());
        }
        //String xVal = HealthRecordClinicalSummaryScreen.yAxisStartValueList
        int incrementIndex = HealthRecordClinicalSummaryScreen.testIdsList.indexOf(HealthRecordClinicalSummaryScreen.selectedTestId);
        int incrementBy = int.parse(HealthRecordClinicalSummaryScreen.yAxisRangeValueList[incrementIndex]);
        HealthRecordClinicalSummaryScreen.intervalBy = incrementBy.toDouble();

        HealthRecordClinicalSummaryScreen.minimumX = double.parse(HealthRecordClinicalSummaryScreen.yAxisStartValueList[incrementIndex]);
        HealthRecordClinicalSummaryScreen.minimumY = double.parse(HealthRecordClinicalSummaryScreen.yAxisStartValueList[incrementIndex]);
        HealthRecordClinicalSummaryScreen.maximumX = double.parse(HealthRecordClinicalSummaryScreen.yAxisEndValueList[incrementIndex]);
        HealthRecordClinicalSummaryScreen.maximumY = double.parse(HealthRecordClinicalSummaryScreen.yAxisEndValueList[incrementIndex]);

        HealthRecordClinicalSummaryScreen.startRange = double.parse(HealthRecordClinicalSummaryScreen.refStartRangeList[incrementIndex]);
        HealthRecordClinicalSummaryScreen.endRange = double.parse(HealthRecordClinicalSummaryScreen.refEndRangeList[incrementIndex]);

        List<int> xValList = [];
        int xStart = int.parse(HealthRecordClinicalSummaryScreen.yAxisStartValueList[incrementIndex]);
        for (var i = 0; i < HealthRecordClinicalSummaryScreen.resultList.length; i++) {
          xStart = xStart + incrementBy;
          xValList.add(xStart);
        }

        HealthRecordClinicalSummaryScreen.spotsList = HealthRecordClinicalSummaryScreen.resultList.asMap().entries.map((e) {
          return FlSpot(xValList[e.key.toInt()].toDouble(), int.parse(HealthRecordClinicalSummaryScreen.resultList[e.key.toInt()]).toDouble());
        }).toList();
      } else {}
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<HealthRecorditem>> getHealthRecordVisitSummaryItems() async {
    HealthRecordScreen.healthrecordTitles = OTPVerification.appscreensdataitems![21].srntxt2.split(',');
    HealthRecordScreen.healthrecordImgUrl = OTPVerification.appscreensdataitems![21].srntxt5.split(',');
    HealthRecordScreen.healthrecordScreens = OTPVerification.appscreensdataitems![21].srntxt6.split(',');
    var body = "";
    postsURL = 'http://drmohansdiabetes.net/dmdscwebapi/api/GetVisitSummary';
    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "TNGPM0000219100",
      "Channel": "App"
    };
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempVisitSummaryItems = jsonData["Visits"];
      if (tempVisitSummaryItems != null) {
        HealthRecordScreen.visitSummayItems = tempVisitSummaryItems
            .map(
              (dynamic item) => VisitSummayItem.fromJson(item),
            )
            .toList();
      } else {
        HealthRecordScreen.visitSummayItems = [];
      }
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<HealthRecorditem>> getHealthRecordPrescriptionItems() async {
    HealthRecordPrescriptionScreen.prescriptionTitles = OTPVerification.appscreensdataitems![21].srntxt2.split(',');
    HealthRecordPrescriptionScreen.prescriptionImgUrl = OTPVerification.appscreensdataitems![21].srntxt5.split(',');
    HealthRecordPrescriptionScreen.prescriptionScreens = OTPVerification.appscreensdataitems![21].srntxt6.split(',');
    var body = "";
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetPrescriptionList";
    final postData = {
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      //"MrNo": "TNGPM0000234757",
      "Channel": "App"
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempPrescriptionItems = jsonData["presList"];
      if (tempPrescriptionItems != null) {
        HealthRecordPrescriptionScreen.prescriptionItems = tempPrescriptionItems
            .map(
              (dynamic item) => PrescriptionItem.fromJson(item),
            )
            .toList();
      } else {
        HealthRecordPrescriptionScreen.prescriptionItems = [];
      }
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<HealthRecorditem>> getHealthLabreportItems() async {
    HealthRecordLabReportsScreen.labreportTitles = OTPVerification.appscreensdataitems![21].srntxt2.split(',');
    HealthRecordLabReportsScreen.labreportImgUrl = OTPVerification.appscreensdataitems![21].srntxt5.split(',');
    HealthRecordLabReportsScreen.labreportScreens = OTPVerification.appscreensdataitems![21].srntxt6.split(',');
    var body = "";
    postsURL = 'http://drmohansdiabetes.net/dmdscwebapi/api/GetLabResult';
    final postData = {
      //"MrNo": ProfileScreen.selectedProfile.MrNo,
      "MrNo": "TNGPM0000050459",
      "Channel": "App"
    };
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempabreportItems = jsonData["LabResults"];
      if (tempabreportItems != null) {
        HealthRecordLabReportsScreen.labreportItems = tempabreportItems
            .map(
              (dynamic item) => LabResultItem.fromJson(item),
            )
            .toList();
      } else {
        HealthRecordLabReportsScreen.labreportItems = [];
      }
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<ShoppingCategoryItem>> getShoppingCategories() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetCategoryList";
    var body = "";
    final postData = {"Channel": "App"};
    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> tempcategoryitems = jsonData["itemCategories"];
      List<ShoppingCategoryItem> shoppingcategoryitems = [];
      if (tempcategoryitems != null) {
        shoppingcategoryitems = tempcategoryitems
            .map(
              (dynamic item) => ShoppingCategoryItem.fromJson(item),
            )
            .toList();
        //DiabetesShoppeScreen.totalshoppingcategoryItems =
        DiabetesShoppeScreen.shoppingids = [];
        DiabetesShoppeScreen.shoppingcategories = [];
        var items = jsonData["itemCategories"];
        DiabetesShoppeScreen.shoppingsubcategoryTitles = [];
        DiabetesShoppeScreen.shoppingsubcategoryImageUrls = [];
        DiabetesShoppeScreen.shoppingsubcategoryIDs = [];
        for (var i = 0; i < items.length; i++) {
          DiabetesShoppeScreen.shoppingids.add(items[i]["ID"]);
          DiabetesShoppeScreen.shoppingsubcategorieslength.add(items[i]["SubCategories"].length);
          DiabetesShoppeScreen.shoppingcategories.add(items[i]["Category"]);
          DiabetesShoppeScreen.shoppingsubcategoriesStr.add(items[i]["SubCategories"].toString());

          List<dynamic> tempsubcategories = items[i]["SubCategories"];
          List<SubCategoryItem> tempsubcategoryitems = tempsubcategories
              //DiabetesShoppeScreen.shoppingsubcategories = tempsubcategories
              .map(
                (dynamic item) => SubCategoryItem.fromJson(item),
              )
              .toList();

          for (var j = 0; j < tempsubcategoryitems.length; j++) {
            DiabetesShoppeScreen.shoppingsubcategoryTitles.add(tempsubcategoryitems[j].subCategory);
            DiabetesShoppeScreen.shoppingsubcategoryImageUrls.add(tempsubcategoryitems[j].ImageUrl);
            DiabetesShoppeScreen.shoppingsubcategoryIDs.add(tempsubcategoryitems[j].SubCatID);
          }
        }
        print(DiabetesShoppeScreen.shoppingcategories.length.toString() + " to string");
      } else {
        shoppingcategoryitems = [];
      }
      return shoppingcategoryitems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Productsitem>> getMyShoppingOrdersItems() async {
    if (MyShoppingOrdersScreen.orderDataReceived == false) {
      MyShoppingOrdersScreen.orderqtycontrollers = [];
      for (var i = 0; i < MyShoppingOrdersScreen.orderedproductsitem.length; i++) {
        MyShoppingOrdersScreen.orderqtycontrollers.add(new TextEditingController(text: "1"));
        if (MyShoppingOrdersScreen.orderqtycontrollers.length > 0) {
          MyShoppingOrdersScreen.orderqtycontrollers[i].text = (int.parse("1")).toString();
        }
      }
      MyShoppingOrdersScreen.orderDataReceived = true;
    }
    return MyShoppingOrdersScreen.orderedproductsitem;
  }

  Future OrderShoppinCart() async {
    //postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/OrdersRequest";
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/Shopping";

    List<Map<String, dynamic>> temporderedproductsitem = [];
    double tOrderProductTotalAmount = 0;
    for (var i = 0; i < temporderedproductsitem.length; i++) {
      double tempTotal = 0;
      tempTotal = (double.parse(MyShoppingOrdersScreen.orderedproductsitem[i].Rate) * int.parse(MyShoppingOrdersScreen.orderedproductsitem[i].Qty));
      tOrderProductTotalAmount = tOrderProductTotalAmount + tempTotal;
      Map<String, dynamic> myObject = {'Code': "mycode", 'Name': "", 'Rate': "", 'Qty': "", 'Amount': "", 'Category': "", 'ImgURL': "", 'TotalAmount': ""};
      List<Map<String, dynamic>> send = [];
      send.add(myObject);
      temporderedproductsitem.add(myObject);
      temporderedproductsitem[i]["Code"] = MyShoppingOrdersScreen.orderedproductsitem[i].Code.toString();
      temporderedproductsitem[i]["Name"] = MyShoppingOrdersScreen.orderedproductsitem[i].Name.toString();
      temporderedproductsitem[i]["Rate"] = MyShoppingOrdersScreen.orderedproductsitem[i].Rate.toString();
      temporderedproductsitem[i]["Qty"] = MyShoppingOrdersScreen.orderedproductsitem[i].Rate.toString();
      temporderedproductsitem[i]["Amount"] = tempTotal.toString();
      temporderedproductsitem[i]["Category"] = MyShoppingOrdersScreen.orderedproductsitem[i].Category.toString();
      temporderedproductsitem[i]["ImgURL"] = MyShoppingOrdersScreen.orderedproductsitem[i].ImgURL.toString();
      temporderedproductsitem[i]["TotalAmount"] = tOrderProductTotalAmount.toString();
    }
    print(tOrderProductTotalAmount);
    print("tOrderProductTotalAmount");
    var body = "";
    final postData = {"PatientType": "M", "MRNo": ProfileScreen.selectedProfile.MrNo, "PatientName": ProfileScreen.selectedProfile.PatientName, "Age": ProfileScreen.selectedProfile.Age, "Gender": ProfileScreen.selectedProfile.Gender, "MobileNo": ProfileScreen.selectedProfile.Phone, "EmailID": ProfileScreen.selectedProfile.Email, "Channel": "App", "orDet": temporderedproductsitem, "orTotalAmount": tOrderProductTotalAmount};
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      if (jsonData["Status"].toString().toLowerCase() == "ordered") {
        ShoppingOrdersuccess.ShoppingOrderID = jsonData["OrderID"];
        ShoppingOrdersuccess.ShoppingOrderDate = jsonData["OrderDate"];
        MyShoppingOrdersScreen.loadShoppingOrdersuccessScreen();
      }
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Ordersitem>> getMyOrdersItems() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetOrderList";
    var body = "";
    final postData = {
      //"MrNo": "TEMPTNGPM004238",
      "MrNo": ProfileScreen.selectedProfile.MrNo,
      "Channel": "App"
    };
    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> body = jsonData["S_orders"];
      List<Ordersitem> ordersitems = body
          .map(
            (dynamic item) => Ordersitem.fromJson(item),
          )
          .toList();
      return ordersitems;
      /*var jsonData = jsonDecode(res.body);
      print("jsonData " + jsonData);
      List<dynamic> body = jsonData["S_orders"];

      List<Ordersitem> ordersitems = body
          .map(
            (dynamic item) => Ordersitem.fromJson(item),
          )
          .toList();
      //List<Ordersitem> ordersitems = [];
      return ordersitems;*/
    } else {
      throw "Unable to retrieve posts.";
    }

    /*if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Ordersitem> ordersitems = body
          .map(
            (dynamic item) => Ordersitem.fromJson(item),
          )
          .toList();

      return ordersitems;
    } else {
      throw "Unable to retrieve posts.";
    }*/
  }

  Future<List<Notifiesitem>> getNotificationItems() async {
    return DashboardScreen.notifies;
  }

  Future<List<Productsitem>> getProductsItems() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetItemList";
    var body = "";
    final postData = {
      "Category": DiabetesShoppeScreen.selectedCategory,
      "SubCatID": DiabetesShoppeScreen.selectedSubCategoryId,
      "Channel": "App",
    };

    body = json.encode(postData);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List<dynamic> body = jsonData["itemList"];
      List<Productsitem> productsitems = [];
      if (ProductsListScreen.prodctlistecreated == false) {
        productsitems = body
            .map(
              (dynamic item) => Productsitem.fromJson(item),
            )
            .toList();

        ProductsListScreen.productsCount = productsitems.length;
        ProductsListScreen.selectedproductitems = productsitems;
        ProductsListScreen.imgNetworkStrs = [];
        for (var i = 0; i < productsitems.length; i++) {
          productsitems[i].itemSelected = false;
          ProductsListScreen.selectedproductitems[i].itemSelected = false;
          ProductsListScreen.imgNetworkStrs.add(DrMohanApp.appinfoitems[0].srntxt2 + "images/plusorange.png");
        }
        print(ProductsListScreen.selectedproductitems.length);
        print("ProductsListScreen.selectedproductitems");
        ProductsListScreen.prodctlistecreated = true;
      } else {
        productsitems = ProductsListScreen.selectedproductitems;
      }
      return productsitems;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future submitFeedback() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/FeedbackInsert";
    var body = "";
    final postData = {
      /*"LocID": BookAppointmentScreen.lastVisitedLocId,
      "LocName": BookAppointmentScreen.lastVisitedLocId,*/
      "LocID": ProfileScreen.selectedProfile.LocID,
      "LocName": ProfileScreen.selectedProfile.LocName,
      "Mobile": ProfileScreen.selectedProfile.Phone,
      "Feedback": FeedbackScreen.feedbackstr,
      "Rating": FeedbackScreen.ratings,
      "Channel": "App"
    };

    body = json.encode(postData);
    print(ProfileScreen.selectedProfile.LocID);
    print(ProfileScreen.selectedProfile.LocName);
    print(body);
    print("feedbackbody");
    //var res = await post(Uri.parse(postsURL), headers: getHeadersWithBearer(), body: body);

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);

    print(res.body);
    print("feedback res body");
    if (res.statusCode == 200) {
      FeedbackScreen.thanksNote = "";
      FeedbackScreen.showthanksNote = true;
      FeedbackScreen.showThanksNoteText();
      FeedbackScreen.showfeedbacksubmittedToast();
    } else {
      throw "Unable to retrieve posts.";
    }
  }*/

  Future<List<TestResultItem>> getTestResultList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetTestResultList";
    var body = "";
    print(ProfileScreen.selectedProfile.MrNo);
    print("mr");
    final postData = {"MrNo": ProfileScreen.selectedProfile.MrNo, "Channel": "App", "TestID": "62"};
    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      print(res.body);

      List<TestResultItem> testResultItems = (jsonData["testResults"] as List).map((e) => TestResultItem.fromMap(e)).toList();
      if (testResultItems != null) {
        return testResultItems;
      }
    }
    return [];
  }

  // Future<List<HealthTrackerItem>> getHealthTrackerList() async {
  //   postsURL =
  //       "http://drmohansdiabetes.net/dmdscwebapi/api/GetHealthTrackerList";
  //   var body = "";
  //   final postData = {
  //     "Channel": "App",
  //   };
  //   body = json.encode(postData);
  //   print(body.toString());
  //
  //   final headersWithBearer = {
  //     "Content-Type": "application/json",
  //     "authorization": "Bearer " + OTPVerification.tokenstr
  //   };
  //   var res =
  //       await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
  //   if (res.statusCode == 200) {
  //     var jsonData = jsonDecode(res.body);
  //     print(res.body);
  //
  //     List<HealthTrackerItem> healthTrackerListItems =
  //         (jsonData["list"] as List)
  //             .map((e) => HealthTrackerItem.fromMap(e))
  //             .toList();
  //     if (healthTrackerListItems != null) {
  //       return healthTrackerListItems;
  //     }
  //   }
  //   return [];
  // }

  Future<int> saveBloodPressure(int vitalId, int value1, int value2) async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/SaveVitals";
    var body = "";

    final postData = {"Channel": "App", "MrNo": ProfileScreen.selectedProfile.MrNo, "VitalID": vitalId, "Value1": value1, "Value2": value2};

    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    return res.statusCode;
  }

  Future<int> saveBloodGlucose(int vitalId, int value1) async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/SaveVitals";
    var body = "";
    final postData = {"Channel": "App", "MrNo": ProfileScreen.selectedProfile.MrNo, "VitalID": vitalId, "Value1": value1};

    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    return res.statusCode;
  }

  Future<List<TestListDetailItem>> getTestList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetTestList";
    var body = "";
    final postData = {"Channel": "App"};

    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map;
      return (map["testList"] as List).map((e) => TestListDetailItem.fromMap(e)).toList();
    }
    return [];
  }

  Future<List<HealthTrackerItem>> getHealthTrackerList() async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetHealthTrackerList";
    var body = "";
    final postData = {
      "Channel": "App",
    };
    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    print(res.body);
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map;
      if (map["Status"] == "Success") {
        List<HealthTrackerItem> healthTrackerListItems = (map["list"] as List).map((e) => HealthTrackerItem.fromMap(e)).toList();
        return healthTrackerListItems;
      }
    }
    return [];
  }

  Future<HealthTrackerRecord> getHealthTrackerRecord(String date, int vitalId) async {
    postsURL = "http://drmohansdiabetes.net/dmdscwebapi/api/GetHTRecordList";
    var body = "";
    final postData = {"Channel": "App", "mrno": ProfileScreen.selectedProfile.MrNo, "date": date, "vitalid": vitalId};

    body = json.encode(postData);
    print(body.toString());

    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + OTPVerification.tokenstr};
    var res = await post(Uri.parse(postsURL), headers: headersWithBearer, body: body);
    print(res.body);
    print(" get " + res.body);
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      if (map["Status"] == "Success") {
        return HealthTrackerRecord.fromMap(map);
      }
    }
    return HealthTrackerRecord.fromMap({});
  }

  Future<List<FoodDetailItem>> getFoodDetails(String food) async {
    final postsURL = Uri.parse("http://49.207.187.43/MDRF/mobileAuth/getFoodDetails");
    var body = "";
    final postData = {"foodName": food};

    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + "9335c45b-85ea-4669-85f5-68544877eb51"};
    var res = await post(postsURL, headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      print(res.body);
      final map = jsonDecode(res.body) as Map;
      return (map["foodDetails"] as List).map((e) => FoodDetailItem.fromMap(e)).toList();
    }
    return [];
  }

  Future<List<FoodPortionDetail>> getPortionDetails(int foodId) async {
    final postsURL = Uri.parse("http://49.207.187.43/MDRF/mobileAuth/getPortionDetails");
    var body = "";
    final postData = {"foodID": foodId};

    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + "9335c45b-85ea-4669-85f5-68544877eb51"};
    var res = await post(postsURL, headers: headersWithBearer, body: body);
    if (res.statusCode == 200) {
      print(res.body);
      final map = jsonDecode(res.body) as Map;
      return (map["foodDetails"] as List).map((e) => FoodPortionDetail.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> emailFoodName(String food) async {
    final postsURL = Uri.parse("http://49.207.187.43/MDRF/mobileAuth/emailFoodName");
    var body = "";
    final postData = {"foodName": food};

    body = json.encode(postData);
    final headersWithBearer = {"Content-Type": "application/json", "authorization": "Bearer " + "9335c45b-85ea-4669-85f5-68544877eb51"};
    var res = await post(postsURL, headers: headersWithBearer, body: body);
    return res.statusCode;
  }
}
