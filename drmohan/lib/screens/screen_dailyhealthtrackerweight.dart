import 'dart:developer';

import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/models/weight_data.dart';
import 'package:drmohan/screens/date_picker_timeline.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
import '../models/model_dashboarditem.dart';
import '../services/http_service.dart';

class DailyHealthTrackerWeightScreen extends StatefulWidget {
  final List<HealthTrackerRecordItem> weightItem;
  final String vitalId;

  const DailyHealthTrackerWeightScreen({Key? key, required this.weightItem, required this.vitalId}) : super(key: key);

  @override
  _DailyHealthTrackerWeightScreenState createState() => _DailyHealthTrackerWeightScreenState();
}

class _DailyHealthTrackerWeightScreenState extends State<DailyHealthTrackerWeightScreen> {
  final HttpService httpService = HttpService();
  static bool showHide = true;
  final _textEditingController = TextEditingController();
  final _calendarController = CalendarController();
  TrackballBehavior? _trackballBehavior;
  var _selectedDate = DateTime.now();
  List<WeightData>? chartData;
  late FToast fToast;
  late DateTime _displayDate;

  final DateRangePickerController _controller = DateRangePickerController();
  late DateTime _selectedValue;
  bool isSubmitting = false;
  var rebuild = 0;

  var offsetDate = DateTime.now();

  callToSetAppBarTitle() => createState().setAppBarTitle("Body Weight Monitor");

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _displayDate = DateTime.now().subtract(const Duration(days: 2));
    _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
    chartData = <WeightData>[
      WeightData(
        date: '12/09',
        weightReading: 55,
      ),
      WeightData(
        date: '13/09',
        weightReading: 32,
      ),
      WeightData(
        date: '14/09',
        weightReading: 63,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            return Stack(children: [
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
                            margin: const EdgeInsets.only(left: 10),
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
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Text(
                          "Select Date",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
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
                            _displayDate = _displayDate.subtract(const Duration(days: 5));
                            _controller.displayDate = _displayDate;
                          },
                          icon: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Expanded(
                            child: DatePickerTimeline(
                          controller: _controller,
                          onSelected: (dateTime) {
                            _selectedDate = dateTime;
                          },
                        )),
                        IconButton(
                          onPressed: () {
                            _displayDate = _displayDate.add(const Duration(days: 5));
                            _controller.displayDate = _displayDate;
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
                        'Enter Body Weight',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ))
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
                        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5.0)),
                        controller: _textEditingController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 125,
                    height: 45,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                        Colors.lightBlueAccent,
                        Colors.blue,
                      ]),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        _onTap(
                          int.parse(widget.vitalId),
                          int.parse(_textEditingController.text),
                        );
                      },
                      child: const Text(
                        'SUBMIT',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
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
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Row(children: const [
                      Text(
                        'Kg',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ]),
                  ),
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        //Hide the axis line of y-axis
                        axisLine: AxisLine(width: 0)),
                    series: _getStackedLineSeries(),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ]),
              ),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
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
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// Returns the list of chart seris which need to render
  /// on the stacked line chart.
  List<StackedLineSeries<WeightData, String>> _getStackedLineSeries() {
    return <StackedLineSeries<WeightData, String>>[
      StackedLineSeries<WeightData, String>(dataSource: chartData!, xValueMapper: (WeightData d1, _) => d1.date, yValueMapper: (WeightData d2, _) => d2.weightReading, pointColorMapper: (WeightData d3, _) => Colors.pink, markerSettings: MarkerSettings(isVisible: true, color: Colors.pink), dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }
}
