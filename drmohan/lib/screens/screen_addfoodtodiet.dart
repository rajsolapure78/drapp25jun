import 'dart:developer';

import 'package:drmohan/models/model_dashboarditem.dart';
import 'package:drmohan/screens/tile_wheel.dart';
import 'package:drmohan/services/http_service.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class AddFoodToDietScreen extends StatefulWidget {
  final String food;
  final String diet;

  const AddFoodToDietScreen({Key? key, required this.food, required this.diet})
      : super(key: key);

  @override
  _AddFoodToDietScreenState createState() => _AddFoodToDietScreenState();
}

class _AddFoodToDietScreenState extends State<AddFoodToDietScreen> {
  final HttpService httpService = HttpService();
  final quantity = ["0.75", "1.5", "3"];
  final size = ["small", "medium", "large"];
  var selectedQuantity = "0.75";
  var selectedSize = "small";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      appBar: AppBarWidget(),
      body: FutureBuilder(
        future: httpService.getDashboardItems(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Dashboarditem>> snapshot) {
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
                              style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.055),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen
                                            .selectedProfile.PatientName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DrMohanApp.appinfoitems![0].srntxt4
                                                .split(',')[0] +
                                            ":",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen.selectedProfile.MrNo,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DrMohanApp.appinfoitems![0].srntxt4
                                                .split(',')[1] +
                                            ": ",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen.selectedProfile.DOB
                                            .split(" ")[0],
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
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
                      Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          margin: EdgeInsets.only(left: 2),
                          child: Image.network(
                              DrMohanApp.appinfoitems![0].srntxt2 +
                                  "/images/" +
                                  ProfileScreen.selectedProfile.Gender
                                      .toLowerCase() +
                                  ".png"))
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text("50.0g - 100cal", style: TextStyle(fontSize: 14),),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(children: const [
                        Text(
                          "Pick the quantity of food",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.black, // Button color
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.question,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 250,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 60,
                                    width: 200,
                                    child: Center(
                                      child: Container(
                                        height: 65,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Column(
                                          children: const [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Divider(
                                                  thickness: 2,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Divider(
                                                thickness: 2,
                                                color: Colors.black87,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ListWheelScrollView.useDelegate(
                                  itemExtent: 50,
                                  perspective: 0.001,
                                  diameterRatio: 1.6,
                                  physics: FixedExtentScrollPhysics(),
                                  squeeze: 1.0,
                                  useMagnifier: true,
                                  magnification: 1.1,
                                  //* selected state is magnified
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      selectedQuantity = quantity[index];
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: quantity.length,
                                    builder: (context, index) {
                                      return WheelTile(
                                          selectedQuantity == quantity[index]
                                              ? Colors.black
                                              : Colors.black45,
                                          quantity[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 250,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 60,
                                    width: 200,
                                    child: Center(
                                      child: Container(
                                        height: 65,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        decoration: const BoxDecoration(
                                          color: Colors.white10,
                                        ),
                                        child: Column(
                                          children: const [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Divider(
                                                  thickness: 2,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Divider(
                                                thickness: 2,
                                                color: Colors.black87,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ListWheelScrollView.useDelegate(
                                  itemExtent: 50,
                                  perspective: 0.001,
                                  diameterRatio: 1.6,
                                  physics: FixedExtentScrollPhysics(),
                                  squeeze: 1.0,
                                  useMagnifier: true,
                                  magnification: 1.1,
                                  //* selected state is magnified
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      selectedSize = size[index];
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: size.length,
                                    builder: (context, index) {
                                      return WheelTile(
                                          selectedSize == size[index]
                                              ? Colors.black
                                              : Colors.black45,
                                          size[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, [
                                widget.food,
                                selectedQuantity,
                                selectedSize,
                                (double.parse(selectedQuantity) * 100)
                                    .round()
                                    .toString()
                              ]);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 45,
                              margin: const EdgeInsets.all(5),
                              color: Colors.lightBlue,
                              child: Center(
                                child: Text(
                                  'ADD TO ' + widget.diet.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
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
          backgroundImage: NetworkImage(
              OTPVerification.appscreensdataitems![36].srntxt2 +
                  '/images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
