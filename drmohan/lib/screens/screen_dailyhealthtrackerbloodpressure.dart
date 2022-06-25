import 'dart:developer';

import 'package:drmohan/models/model_healthtrackerrecord.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/models/range_chart_data.dart';
import 'package:drmohan/screens/date_picker_timeline.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
import '../services/http_service.dart';

class DailyHealthTrackerBloodPressureScreen extends StatefulWidget {
  final List<HealthTrackerRecordItem> bloodPressureItem;
  final HealthTrackerRecord bloodPressureVitals;
  final String vitalId;

  const DailyHealthTrackerBloodPressureScreen({Key? key, required this.bloodPressureItem, required this.vitalId, required this.bloodPressureVitals}) : super(key: key);

  @override
  _DailyHealthTrackerBloodPressureScreenState createState() => _DailyHealthTrackerBloodPressureScreenState();
}

class _DailyHealthTrackerBloodPressureScreenState extends State<DailyHealthTrackerBloodPressureScreen> {
  late FToast fToast;
  final HttpService httpService = HttpService();
  late DateTime _selectedDate;
  late DateTime _selectedTime;
  final _textEditingController1 = TextEditingController();
  final _textEditingController2 = TextEditingController();
  List<RangeChartData> chartData = [];
  List<RangeChartData> chartData1 = [];
  bool isSubmitting = false;
  bool isLoading = false;
  final _scrollControllerTimePicker = ScrollController();

  var size = 0.0;
  var offset = 0.0;

  var offsetDate = DateTime.now();

  final DateRangePickerController _controller = DateRangePickerController();

  late DateTime _displayDate;

  callToSetAppBarTitle() => createState().setAppBarTitle("Blood Pressure monitor");

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    sortData();
    _selectedDate = DateTime.now();
    _selectedTime = DateTime.now();
    _displayDate = DateTime.now().subtract(const Duration(days: 2));
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await httpService.getHealthTrackerRecord(DateFormat('MM/dd/yyyy').format(_selectedDate).toString(), int.parse(widget.vitalId)).then((value) {
      widget.bloodPressureItem.clear();
      widget.bloodPressureItem.addAll(value.list.map((e) => HealthTrackerRecordItem.fromMap(e)).toList());
      sortData();
      setState(() {
        isLoading = false;
      });
    });
  }

  void sortData() {
    for (var element in widget.bloodPressureItem) {
      print(element.Date);
      print("element.Date bp");
      if (double.parse(element.Value1) >= double.parse(widget.bloodPressureVitals.LowerRefRange) && double.parse(element.Value1) < double.parse(widget.bloodPressureVitals.UpperRefRange) && double.parse(element.Value2) <= double.parse(widget.bloodPressureVitals.UpperRefRange) && double.parse(element.Value2) > double.parse(widget.bloodPressureVitals.LowerRefRange)) {
        //chartData.add(RangeChartData(date: DateFormat("dd-MM-yyyy hh:mm:ss").parse(element.Date), low: double.parse(element.Value1), high: double.parse(element.Value2)));
        chartData.add(RangeChartData(date: element.Date, low: double.parse(element.Value1), high: double.parse(element.Value2)));
      } else {
        //chartData1.add(RangeChartData(date: DateFormat("dd-MM-yyyy hh:mm:ss").parse(element.Date), low: double.parse(element.Value1), high: double.parse(element.Value2)));
        chartData1.add(RangeChartData(date: element.Date, low: double.parse(element.Value1), high: double.parse(element.Value2)));
      }
    }
  }

  @override
  AppBarWidget createState() => AppBarWidget();

  @override
  Widget build(BuildContext context) {
    callToSetAppBarTitle();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Text(
                          "Select Date & Time",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                            _displayDate = _displayDate.subtract(const Duration(days: 5));
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
                            _displayDate = _displayDate.add(const Duration(days: 5));
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
                            offset > size ? offset = offset - size : offset = 0.0;
                            navigate();
                          },
                          icon: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Expanded(
                          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                              dateForTime: DateTime.now().add(const Duration(days: 1)),
                              timeTextStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              showDisabled: false,
                              selectedTimeTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.lightBlue, decoration: TextDecoration.underline),
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
                        'Enter Blood Pressure Value',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Sys',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Container(
                      width: 60,
                      height: 45,
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
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5.0)),
                        controller: _textEditingController1,
                      ),
                    ),
                    const Text(
                      '/',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Container(
                      width: 60,
                      height: 45,
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
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5.0)),
                        controller: _textEditingController2,
                      ),
                    ),
                    const Text(
                      'Dia',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      _onTap(int.parse(widget.vitalId), int.parse(_textEditingController1.text), int.parse(_textEditingController2.text));
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
                        'LAST FIVE READINGS',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Row(children: const [
                      Text(
                        'mmhg',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ]),
                  ),
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryYAxis: NumericAxis(minimum: widget.bloodPressureVitals.YaxisMinRange != null ? double.parse(widget.bloodPressureVitals.YaxisMinRange) : 0, maximum: widget.bloodPressureVitals.YaxisMaxRange != null ? double.parse(widget.bloodPressureVitals.YaxisMaxRange) : 300, interval: widget.bloodPressureVitals.YaxisInterval != null ? double.parse(widget.bloodPressureVitals.YaxisInterval) : 30),
                    primaryXAxis: DateTimeAxis(
                        minimum: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute, _selectedTime.second),
                        maximum: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute, _selectedTime.second).add(const Duration(minutes: 60)),
                        interval: 10,
                        dateFormat: DateFormat.Hm(),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        //Hide the gridlines of y-axis
                        majorGridLines: MajorGridLines(width: 0),
                        //Hide the axis line of y-axis
                        axisLine: AxisLine(width: 0)),
                    series: _getRageColumnSeries(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                          Container(width: 28, height: 10, decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(width: 2, color: Colors.blue)), child: Container()),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("Normal"),
                        ]),
                        Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                          Container(width: 28, height: 10, decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(width: 2, color: Colors.pink)), child: Container()),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("Abnormal"),
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
          backgroundImage: NetworkImage(OTPVerification.appscreensdataitems![36].srntxt2 + '/images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  List<RangeColumnSeries<RangeChartData, dynamic>> _getRageColumnSeries() {
    return <RangeColumnSeries<RangeChartData, dynamic>>[RangeColumnSeries(dataSource: chartData, trackBorderWidth: 28, xValueMapper: (RangeChartData d1, _) => d1.date, highValueMapper: (RangeChartData d2, _) => d2.high, lowValueMapper: (RangeChartData d3, _) => d3.low, opacity: 0.3, pointColorMapper: (RangeChartData d4, _) => Colors.blue, markerSettings: MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle, width: 28, borderWidth: 2), dataLabelSettings: DataLabelSettings(isVisible: true)), RangeColumnSeries(dataSource: chartData1, trackBorderWidth: 28, xValueMapper: (RangeChartData d1, _) => d1.date, highValueMapper: (RangeChartData d2, _) => d2.high, lowValueMapper: (RangeChartData d3, _) => d3.low, opacity: 0.3, pointColorMapper: (RangeChartData d4, _) => Colors.pink, markerSettings: MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle, width: 28, borderWidth: 2), dataLabelSettings: DataLabelSettings(isVisible: true))];
  }

  Future<void> _onTap(int vitalId, int value1, int value2) async {
    try {
      setState(() {
        isSubmitting = true;
      });
      await httpService.saveBloodPressure(vitalId, value1, value2).then((value) {
        if (value == 200) {
          fToast.showToast(
            child: showSuccessToast("Blood Glucose Value Updated"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
          fetchData();
        } else {
          fToast.showToast(child: showErrorToast("Something Went Wrong!!"), gravity: ToastGravity.BOTTOM, toastDuration: const Duration(seconds: 2));
        }
        setState(() {
          isSubmitting = false;
        });
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void navigate() {
    _scrollControllerTimePicker.jumpTo(
      offset,
    );
  }
}
