import 'dart:developer';

import 'package:drmohan/models/model_dietdetailitem.dart';
import 'package:drmohan/models/model_mydietitem.dart';
import 'package:drmohan/screens/screen_addfood.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../main.dart';
import '../models/model_dashboarditem.dart';
import '../services/http_service.dart';
import 'list_item.dart';

bool showprescription = true;
bool hideprescription = false;

showHidePrescription(String id) {
  print("id --> " + id);
  if (id == "2") {
    showprescription = false;
    hideprescription = true;
    print("showprescription" + showprescription.toString());
  } else {
    showprescription = true;
    hideprescription = false;
  }
}

class DailyHealthTrackerMyDietScreen extends StatefulWidget {
  const DailyHealthTrackerMyDietScreen({Key? key}) : super(key: key);

  @override
  _DailyHealthTrackerMyDietScreenState createState() => _DailyHealthTrackerMyDietScreenState();
}

class _DailyHealthTrackerMyDietScreenState extends State<DailyHealthTrackerMyDietScreen> {
  int index = 0;
  final HttpService httpService = HttpService();
  static bool showHide = true;
  var diet = [
    MyDietItem(diet: "Breakfast", totalConsumedCalories: "0", totalCalories: "563", dietDetails: []),
    MyDietItem(diet: "Morning Snack", totalConsumedCalories: "0", totalCalories: "211", dietDetails: []),
    MyDietItem(diet: "Lunch", totalConsumedCalories: "0", totalCalories: "563", dietDetails: []),
    MyDietItem(diet: "Evening Snack", totalConsumedCalories: "0", totalCalories: "211", dietDetails: []),
    MyDietItem(diet: "Dinner", totalConsumedCalories: "0", totalCalories: "563", dietDetails: []),
  ];
  int consumerCalories = 0;

  callToSetAppBarTitle() => createState().setAppBarTitle("My Diet");

  @override
  AppBarWidget createState() => AppBarWidget();

  static setshowhide() {
    print("before --> " + showHide.toString());
    showHide = true;
    print("after --> " + showHide.toString());
  }

  @override
  void initState() {
    // print("before " + showHide.toString());
    // showHide = true;
    // print("after " + showHide.toString());
    // dietCopy = List<DietItem>.from(diet);
  }

  @override
  Widget build(BuildContext context) {
    // dietCopy.forEach((element) {
    //   consumerCalories = consumerCalories + int.parse(element.consumerCalories);
    // });
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      appBar: AppBarWidget(),
      body: FutureBuilder(
        future: httpService.getDashboardItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Dashboarditem>> snapshot) {
          log('data: $snapshot.hasData');
          if (snapshot.hasData) {
            List<Dashboarditem>? dashboarditems = snapshot.data;
            return Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
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
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.09,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DrMohanApp.appinfoitems![0].srntxt4.split(',')[0] + ":",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DrMohanApp.appinfoitems![0].srntxt4.split(',')[1] + ": ",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                      /*Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.5,
                                margin: EdgeInsets.only(left: 10),
                                child: Html(
                                  data:
                                      //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                      ProfileScreen
                                              .selectedProfile.PatientName +
                                          "<br>" +
                                          DrMohanApp.appinfoitems![0].srntxt4
                                              .split(',')[0] +
                                          ": " +
                                          ProfileScreen.selectedProfile.MrNo +
                                          "<br>" +
                                          DrMohanApp.appinfoitems![0].srntxt4
                                              .split(',')[1] +
                                          ": " +
                                          ProfileScreen.selectedProfile.DOB
                                              .split(" ")[0],
                                )),*/
                      Container(height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, margin: EdgeInsets.only(left: 2), child: Image.network(DrMohanApp.appinfoitems![0].srntxt2 + "/images/" + ProfileScreen.selectedProfile.Gender.toLowerCase() + ".png"))
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white),
                child: Column(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: Row(children: [
                        Text(
                          consumerCalories.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const Text(" " + "of 2100 Cal eaten", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18))
                      ]),
                    ),
                    Image.network('https://www.rsolutions7.com/drmohan/images/graph.png'),
                  ]),
                ]),
              ),
              Row(children: [
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 20,
                  lineHeight: 6.0,
                  percent: consumerCalories / 2100,
                  progressColor: Colors.orange,
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: diet.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final dietItem = diet[index];
                    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      InkWell(
                        onTap: () async {
                          this.index = index;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFoodScreen(diet: dietItem.diet),
                            ),
                          ).then((value) {
                            var foodItemDetails = (value as List).map((e) => e as String).toList();
                            print(foodItemDetails[0]);
                            DietDetailItem dietDetailItem = DietDetailItem(food: foodItemDetails[0], size: foodItemDetails[1] + " " + foodItemDetails[2], consumedCalories: foodItemDetails[3]);
                            setState(() {
                              consumerCalories = consumerCalories + int.parse(foodItemDetails[3]);
                              dietItem.totalConsumedCalories = (int.parse(dietItem.totalConsumedCalories) + int.parse(foodItemDetails[3])).toString();
                              dietItem.dietDetails.add(dietDetailItem);
                            });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 8, 10),
                          child: Row(children: [
                            Expanded(
                              child: Text(
                                dietItem.diet,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                Text(
                                  dietItem.totalConsumedCalories + " of " + dietItem.totalCalories + "Cal",
                                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                dietItem.dietDetails.isNotEmpty ? Image.network('https://www.rsolutions7.com/drmohan/images/merge.png') : Container(),
                                dietItem.dietDetails.isNotEmpty
                                    ? const SizedBox(
                                        width: 8,
                                      )
                                    : Container(),
                                const ClipOval(
                                  child: Material(
                                    color: Colors.blue, // Button color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: dietItem.dietDetails.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // Provide a builder function. This is where the magic happens.
                          // Convert each item into a widget based on the type of item it is.
                          itemBuilder: (context, index) {
                            final item = dietItem.dietDetails[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    item.food,
                                    style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    item.size,
                                    style: const TextStyle(color: Colors.black45, fontSize: 14),
                                  ),
                                  trailing: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        item.consumedCalories + " Cal",
                                        style: const TextStyle(color: Colors.black45, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(Icons.more_vert)
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      dietItem.dietDetails.isNotEmpty
                          ? const Divider(
                              thickness: 3,
                            )
                          : Container()
                    ]);
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              )
            ]);
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
          backgroundImage: NetworkImage(OTPVerification.appscreensdataitems![36].srntxt2 + '/images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}

class DietItem implements ListItem {
  final String heading;
  final String subHeadingLineOne;
  final String subHeadingLineTwo;
  final String consumerCalories;
  final String totalCalories;

  DietItem({required this.heading, required this.subHeadingLineOne, required this.subHeadingLineTwo, required this.consumerCalories, required this.totalCalories});

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return subHeadingLineOne.isEmpty
        ? Container()
        : Wrap(direction: Axis.vertical, children: [
            Text(
              subHeadingLineOne,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black45),
            ),
            Text(
              subHeadingLineTwo,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black45),
            ),
          ]);
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, runAlignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
      Text(
        consumerCalories + " of " + totalCalories,
        style: const TextStyle(fontSize: 12, color: Colors.black45),
      ),
      const SizedBox(
        width: 5,
      ),
      const ClipOval(
        child: Material(
          color: Colors.blue, // Button color
          child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ]);
  }
}
