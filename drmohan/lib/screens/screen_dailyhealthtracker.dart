import 'dart:developer';

import 'package:drmohan/models/model_healthtrackerrecord.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackerbloodpressure.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackerglucose.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackermydiet.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackerweight.dart';
import 'package:drmohan/screens/tile_activitytracker.dart';
import 'package:drmohan/screens/tile_diettracker.dart';
import 'package:drmohan/screens/tile_glucosetracker.dart';
import 'package:drmohan/screens/tile_vitalstracker.dart';
import 'package:drmohan/screens/tile_weighttracker.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:drmohan/widgets/menu_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../services/http_service.dart';

class DailyHealthTrackerScreen extends StatefulWidget {
  const DailyHealthTrackerScreen({Key? key}) : super(key: key);

  @override
  _DailyHealthTrackerScreenState createState() =>
      _DailyHealthTrackerScreenState();
}

class _DailyHealthTrackerScreenState extends State<DailyHealthTrackerScreen> {
  final HttpService httpService = HttpService();
  List<HealthTrackerRecordItem> heightVitalsList = [];
  List<HealthTrackerRecordItem> weightVitalsList = [];
  List<HealthTrackerRecordItem> bloodGlucoseVitalsList = [];
  List<HealthTrackerRecordItem> bloodPressureVitalsList = [];
  List<HealthTrackerRecordItem> foodVitalsList = [];
  HealthTrackerRecord bloodGlucoseVitals = HealthTrackerRecord.fromMap({});
  HealthTrackerRecord bloodPressureVitals = HealthTrackerRecord.fromMap({});
  late String heightVitalId;
  late String weightVitalId;
  late String bloodGlucoseVitalId;
  late String bloodPressureVitalId;
  late String foodVitalId;
  bool _isLoading = false;

  callToSetAppBarTitle() => createState()
      .setAppBarTitle(OTPVerification.appscreensdataitems![14].srntxt1);

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await httpService.getHealthTrackerList().then((value) async {
      var futures = <Future>[];
      for (var element in value) {
        if (element.VitalName == "BLOOD GLUCOSE") {
          bloodGlucoseVitalId = element.VitalID;
          futures.add(httpService.getHealthTrackerRecord(
              DateFormat('MM/dd/yyyy').format((DateTime.now())).toString(),
              int.parse(element.VitalID)));
        } else if (element.VitalName == "BLOOD PRESSURE") {
          bloodPressureVitalId = element.VitalID;
          futures.add(httpService.getHealthTrackerRecord(
              DateFormat('MM/dd/yyyy').format((DateTime.now())).toString(),
              int.parse(element.VitalID)));
        } else if (element.VitalName == "HEIGHT") {
          heightVitalId = element.VitalID;
        } else if (element.VitalName == "WEIGHT") {
          weightVitalId = element.VitalID;
        } else if (element.VitalName == "FOOD") {
          foodVitalId = element.VitalID;
        }
      }
      await Future.wait(futures).then((value1) {
        HealthTrackerRecord healthRecord = value1[0];
        HealthTrackerRecord healthRecord1 = value1[1];
        if (healthRecord.list != null && healthRecord.list.isNotEmpty) {
          final healthTrackerRecordListItem = healthRecord.list
              .map((e) => HealthTrackerRecordItem.fromMap(e))
              .toList();
          if (healthTrackerRecordListItem[0].VitalName == "BLOOD GLUCOSE") {
            bloodGlucoseVitals = healthRecord;
            bloodGlucoseVitalsList.addAll(healthTrackerRecordListItem);
          } else {
            bloodPressureVitals = healthRecord;
            bloodPressureVitalsList.addAll(healthTrackerRecordListItem);
          }
        }

        if (healthRecord1.list != null && healthRecord1.list.isNotEmpty) {
          final healthTrackerRecordListItem = healthRecord1.list
              .map((e) => HealthTrackerRecordItem.fromMap(e))
              .toList();
          if (healthTrackerRecordListItem[0].VitalName == "BLOOD GLUCOSE") {
            bloodGlucoseVitals = healthRecord1;
            bloodGlucoseVitalsList.addAll(healthTrackerRecordListItem);
          } else {
            bloodPressureVitals = healthRecord1;
            bloodPressureVitalsList.addAll(healthTrackerRecordListItem);
          }
        }

        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      drawer: MenuDrawerWidget(),
      appBar: AppBarWidget(),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Column(children: [
                StaggeredGrid.count(
                    crossAxisCount: 18,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 9,
                        mainAxisCellCount: 10,
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DailyHealthTrackerGlucoseScreen(
                                    glucoseItem: bloodGlucoseVitalsList,
                                    vitalId: bloodGlucoseVitalId,
                                    glucoseVitals: bloodGlucoseVitals,
                                  ),
                                )).then((_) => fetchData());
                          },
                          child: GluscoseTrackerTile(
                            glucoseItem: bloodGlucoseVitalsList,
                          ),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 9,
                        mainAxisCellCount: 12,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DailyHealthTrackerMyDietScreen(),
                                  ));
                            },
                            child: const DietTrackerTile()),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 9,
                        mainAxisCellCount: 7,
                        child: VitalsTrackerTile(
                          bloodPressureItem: bloodPressureVitalsList,
                          bloodPressureVitalId: bloodPressureVitalId,
                          bloodPressureVitals: bloodPressureVitals,
                          weightItem: weightVitalsList,
                          weightVitalId: weightVitalId,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 9,
                        mainAxisCellCount: 12,
                        child: InkWell(
                            onTap: () {},
                            child: ActivityTrackerTile(
                                weightItem: weightVitalsList)),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 9,
                        mainAxisCellCount: 10,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DailyHealthTrackerWeightScreen(
                                    weightItem: weightVitalsList,
                                    vitalId: weightVitalId,
                                  ),
                                ),
                              );
                            },
                            child: WeightTrackerTile(
                                weightItem: weightVitalsList)),
                      ),
                    ]),
                const SizedBox(
                  height: 80,
                )
              ]),
            )
          : const Center(child: CircularProgressIndicator()),
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
