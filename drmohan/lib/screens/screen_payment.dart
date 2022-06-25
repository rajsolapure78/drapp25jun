import 'dart:developer';

import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:drmohan/widgets/menu_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../main.dart';
import '../models/model_dashboarditem.dart';
import '../services/http_service.dart';

class PaymentScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  callToSetAppBarTitle() =>
      createState().setAppBarTitle("Select Mode of Payment");
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
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: httpService.getDashboardItems(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Dashboarditem>> snapshot) {
            log('data: $snapshot.hasData');
            if (snapshot.hasData) {
              List<Dashboarditem>? dashboarditems = snapshot.data;
              return Column(
                children: [
                  Container(
                    margin: new EdgeInsets.symmetric(vertical: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(width: 5.0, color: Colors.grey),
                      ),
                    ),
                    child: Card(
                        shape: BeveledRectangleBorder(
                          side: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
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
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.all(5),
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      ProfileScreen
                                          .selectedProfile.PatientName[0],
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25),
                                    )),
                              ),
                              Container(
                                height: 50,
                                width: 0.7,
                                color: Colors.blue,
                              ),
                              Container(
                                  width: 200,
                                  margin: EdgeInsets.all(5),
                                  child: Html(
                                    data:
                                        //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                        ProfileScreen
                                                .selectedProfile.PatientName +
                                            "<br>" +
                                            ProfileScreen.selectedProfile.MrNo +
                                            " | " +
                                            ProfileScreen.selectedProfile.DOB.split(" ")[0],
                                  )),
                              Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.all(5),
                                  child: Image.network(
                                      "https://rsolutions7.com/drmohan/images/" +
                                          ProfileScreen.selectedProfile.Gender
                                              .toLowerCase() +
                                          ".png"))
                            ],
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.grey.withOpacity(0.0),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Html(data: 'Hospital Visit date:'
                                //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                //'${profiles[index].name + "<br>Dob: " + profiles[index].dob + "<br>MRN: " + profiles[index].mrn.toString()}',
                                )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Html(data: 'Home Blood collection date:'
                                //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                //'${profiles[index].name + "<br>Dob: " + profiles[index].dob + "<br>MRN: " + profiles[index].mrn.toString()}',
                                )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Html(data: 'Doctor:'
                                //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                //'${profiles[index].name + "<br>Dob: " + profiles[index].dob + "<br>MRN: " + profiles[index].mrn.toString()}',
                                )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Html(data: 'Location:'
                                //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                //'${profiles[index].name + "<br>Dob: " + profiles[index].dob + "<br>MRN: " + profiles[index].mrn.toString()}',
                                )),
                        Container(
                            height: 50,
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border(
                                bottom:
                                    BorderSide(width: 0.0, color: Colors.grey),
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.centerRight,
                                widthFactor: 100,
                                heightFactor: 50,
                                child: Html(
                                  data:
                                      'Mr. Pradeep Kumar K. 30-Dec-1983/Male, TNGPM0000002456',
                                  defaultTextStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    height: 700,
                    margin: EdgeInsets.all(5),
                    child: Column(),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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
