import 'dart:developer';

import 'package:drmohan/models/model_healthtrackerrecord.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/models/spline_chart_data.dart';
import 'package:drmohan/screens/date_picker_timeline.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
import '../services/http_service.dart';

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

class DailyHealthTrackerGlucoseScreen extends StatefulWidget {
  final List<HealthTrackerRecordItem> glucoseItem;
  final String vitalId;
  final HealthTrackerRecord glucoseVitals;

  const DailyHealthTrackerGlucoseScreen(
      {Key? key,
      required this.glucoseItem,
      required this.vitalId,
      required this.glucoseVitals})
      : super(key: key);

  @override
  _DailyHealthTrackerGlucoseScreenState createState() =>
      _DailyHealthTrackerGlucoseScreenState();
}

class _DailyHealthTrackerGlucoseScreenState
    extends State<DailyHealthTrackerGlucoseScreen> {
  late FToast fToast;
  final HttpService httpService = HttpService();
  final _textEditingController = TextEditingController();
  late DateTime _selectedDate;
  late DateTime _selectedTime;
  List<SplineCharData> chartData = [];
  List<SplineCharData> chartData1 = [];
  List<SplineCharData> chartData2 = [];
  bool isSubmitting = false;
  bool isLoading = false;
  final DateRangePickerController _controller = DateRangePickerController();
  late DateTime _displayDate;

  final _scrollControllerTimePicker = ScrollController();
  var size = 0.0;
  var offset = 0.0;
  var offsetDate = DateTime.now();

  callToSetAppBarTitle() =>
      createState().setAppBarTitle("Blood Glucose Monitor");

  @override
  AppBarWidget createState() => AppBarWidget();

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await httpService
        .getHealthTrackerRecord(
            DateFormat('MM/dd/yyyy').format(_selectedDate).toString(),
            int.parse(widget.vitalId))
        .then((value) {
      if (value.list != null && value.list.isNotEmpty) {
        widget.glucoseItem.clear();
        widget.glucoseItem.addAll(
            value.list.map((e) => HealthTrackerRecordItem.fromMap(e)).toList());
        sortData();
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void sortData() {
    for (var element in widget.glucoseItem) {
      if (double.parse(element.Value1) <= 100) {
        chartData.add(SplineCharData(
            x: DateFormat("dd-MM-yyyy hh:mm:ss").parse(element.Date),
            y: double.parse(element.Value1)));
      } else if (double.parse(element.Value1) >= 100 &&
          double.parse(element.Value1) <= 140) {
        chartData1.add(SplineCharData(
            x: DateFormat("dd-MM-yyyy hh:mm:ss").parse(element.Date),
            y: double.parse(element.Value1)));
      } else {
        chartData2.add(SplineCharData(
            x: DateFormat("dd-MM-yyyy hh:mm:ss").parse(element.Date),
            y: double.parse(element.Value1)));
      }
    }
  }

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _selectedDate = DateTime.now();
    _selectedTime = DateTime.now();
    _displayDate = DateTime.now().subtract(const Duration(days: 2));
    sortData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      appBar: AppBarWidget(),
      body: !isLoading
          ? Stack(children: [
              isSubmitting
                  ? AbsorbPointer(
                      child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ))
                  : Container(),
              SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
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
                            margin: const EdgeInsets.only(left: 3),
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  ProfileScreen.selectedProfile.PatientName[0],
                                  style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(0),
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                              margin: const EdgeInsets.only(left: 2),
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
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Text(
                          "Select Date & Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white),
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            _displayDate =
                                _displayDate.subtract(const Duration(days: 5));
                            _controller.displayDate = _displayDate;
                          },
                          icon: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Expanded(
                            child: DatePickerTimeline(
                          controller: _controller,
                          onSelected: (dateTime) {
                            setState(() {
                              _selectedDate = dateTime;
                            });
                          },
                        )),
                        IconButton(
                          onPressed: () {
                            _displayDate =
                                _displayDate.add(const Duration(days: 5));
                            _controller.displayDate = _displayDate;
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white),
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            offset = _scrollControllerTimePicker.offset;
                            offset > size
                                ? offset = offset - size
                                : offset = 0.0;
                            navigate();
                          },
                          icon: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Expanded(
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            print(constraints.maxWidth);
                            size = constraints.maxWidth;
                            return HorizontalTimePicker(
                              onTimeSelected: (dateTime) {
                                setState(() {
                                  _selectedTime = dateTime;
                                });
                              },
                              scrollController: _scrollControllerTimePicker,
                              height: 50,
                              startTimeInHour: 0,
                              endTimeInHour: 24,
                              timeIntervalInMinutes: 60,
                              dateForTime:
                                  DateTime.now().add(const Duration(days: 1)),
                              timeTextStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              showDisabled: false,
                              selectedTimeTextStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
                                  decoration: TextDecoration.underline),
                            );
                          }),
                        ),
                        IconButton(
                          onPressed: () {
                            offset = _scrollControllerTimePicker.offset;
                            offset = offset + size;
                            navigate();
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: Text(
                          'Enter Blood Glucose Value',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 100,
                    height: 45,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(5.0)),
                        controller: _textEditingController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      _onTap(
                        int.parse(widget.vitalId),
                        int.parse(_textEditingController.text),
                      );
                    },
                    child: Container(
                      width: 125,
                      height: 45,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.lightBlueAccent,
                            Colors.blue,
                          ],
                        ),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'SUBMIT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(children: const [
                      Text(
                        'LAST SEVEN READINGS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Row(children: const [
                      Text(
                        'mg/dl',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ]),
                  ),
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryYAxis: NumericAxis(
                        minimum: widget.glucoseVitals.YaxisMinRange != null
                            ? double.parse(widget.glucoseVitals.YaxisMinRange)
                            : 0,
                        maximum: widget.glucoseVitals.YaxisMaxRange != null
                            ? double.parse(widget.glucoseVitals.YaxisMaxRange)
                            : 300,
                        interval: widget.glucoseVitals.YaxisInterval != null
                            ? double.parse(widget.glucoseVitals.YaxisInterval)
                            : 30),
                    primaryXAxis: DateTimeAxis(
                        minimum: DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                            _selectedTime.second),
                        maximum: DateTime(
                                _selectedDate.year,
                                _selectedDate.month,
                                _selectedDate.day,
                                _selectedTime.hour,
                                _selectedTime.minute,
                                _selectedTime.second)
                            .add(const Duration(minutes: 60)),
                        interval: 10,
                        dateFormat: DateFormat.Hm(),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        //Hide the gridlines of y-axis
                        majorGridLines: MajorGridLines(width: 0),
                        //Hide the axis line of y-axis
                        axisLine: AxisLine(width: 0)),
                    series: _getSplineAreaSeries(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(children: [
                          const Text("Low"),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 3, color: Colors.pink)),
                              child: Container()),
                        ]),
                        Wrap(children: [
                          const Text("Normal"),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 3, color: Colors.blue)),
                              child: Container()),
                        ]),
                        Wrap(children: [
                          const Text("High"),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3, color: Colors.yellow)),
                              child: Container()),
                        ]),
                      ],
                    ),
                  ),
                ]),
              ),
            ])
          : Center(child: CircularProgressIndicator()),
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

  Future<void> _onTap(int vitalId, int value1) async {
    try {
      setState(() {
        isSubmitting = true;
      });
      await httpService.saveBloodGlucose(vitalId, value1).then((value) {
        if (value == 200) {
          fToast.showToast(
            child: showSuccessToast("Blood Glucose Value Updated"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
        } else {
          fToast.showToast(
            child: showErrorToast("Something Went Wrong!!"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
        }
        setState(() {
          isSubmitting = false;
        });
        _textEditingController.clear();
        fetchData();
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  List<SplineAreaSeries<SplineCharData, dynamic>> _getSplineAreaSeries() {
    return <SplineAreaSeries<SplineCharData, dynamic>>[
      SplineAreaSeries<SplineCharData, dynamic>(
          dataSource: chartData,
          splineType: SplineType.cardinal,
          color: Colors.blue.shade100,
          xValueMapper: (SplineCharData d1, _) => d1.x,
          yValueMapper: (SplineCharData d2, _) => d2.y,
          dashArray: <double>[5, 5],
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.average),
          markerSettings:
              MarkerSettings(isVisible: true, borderColor: Colors.pink),
          dataLabelSettings: DataLabelSettings(isVisible: true)),
      SplineAreaSeries<SplineCharData, dynamic>(
          dataSource: chartData1,
          splineType: SplineType.cardinal,
          color: Colors.blue.shade100,
          xValueMapper: (SplineCharData d1, _) => d1.x,
          yValueMapper: (SplineCharData d2, _) => d2.y,
          dashArray: <double>[5, 5],
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.average),
          markerSettings:
              MarkerSettings(isVisible: true, borderColor: Colors.blue),
          dataLabelSettings: DataLabelSettings(isVisible: true)),
      SplineAreaSeries<SplineCharData, dynamic>(
          dataSource: chartData2,
          splineType: SplineType.cardinal,
          color: Colors.blue.shade100,
          xValueMapper: (SplineCharData d1, _) => d1.x,
          yValueMapper: (SplineCharData d2, _) => d2.y,
          dashArray: <double>[5, 5],
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.average),
          markerSettings:
              MarkerSettings(isVisible: true, borderColor: Colors.yellow),
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }

  void navigate() {
    _scrollControllerTimePicker.jumpTo(
      offset,
    );
  }
}
