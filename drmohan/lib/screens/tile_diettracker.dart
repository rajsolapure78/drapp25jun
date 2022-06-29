import 'package:auto_size_text/auto_size_text.dart';
import 'package:drmohan/models/bar_chart_data.dart';
import 'package:drmohan/models/radial_chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DietTrackerTile extends StatefulWidget {
  const DietTrackerTile({Key? key}) : super(key: key);

  @override
  _DietTrackerTileState createState() => _DietTrackerTileState();
}

class _DietTrackerTileState extends State<DietTrackerTile> {
  late List<RadialChartData> chartDataRadial;
  late List<BarChartData> chartDataBar;

  @override
  void initState() {
    chartDataRadial = <RadialChartData>[
      RadialChartData(
        x: 'Good',
        y: 1850,
        color: Colors.blue,
      ),
    ];

    chartDataBar = <BarChartData>[
      BarChartData(x: "Fat", y: 43.70, color: Colors.blue.shade400),
      BarChartData(x: "Protein", y: 54.60, color: Colors.blue.shade600),
      BarChartData(x: "Carb", y: 271.40, color: Colors.blue),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[200]!);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 6,
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: AutoSizeText(
                        "Calorie Intake(per day)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.078),
                        maxLines: 1,
                      ),
                    ),
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.45,
                        width: constraints.maxHeight * 0.45,
                        child: SfCircularChart(
                            borderWidth: 0,
                            margin: EdgeInsets.zero,
                            series: _getRadialBarSeries()),
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.15,
                        left: constraints.maxHeight * 0.225 - 28,
                        child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                chartDataRadial.first.y.toString(),
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.078,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Calories",
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.07),
                              ),
                            ]),
                      ),
                    ]),
                    Text(
                      "1200(+/-100)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth * 0.061),
                    )
                  ]),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        "Per Day To Reach 70 kgs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                            fontSize: constraints.maxWidth * 0.061),
                        maxLines: 1,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Fat :",
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.061),
                                )),
                            Expanded(
                              flex: 2,
                              child: LinearPercentIndicator(
                                width: constraints.maxWidth * 0.55,
                                lineHeight: constraints.maxWidth * 0.063,
                                percent: 43.7 / 100,
                                progressColor: Colors.blue.shade200,
                                center: Text(
                                  "43.7",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth * 0.061),
                                ),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Protein :",
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.061),
                                )),
                            Expanded(
                              flex: 2,
                              child: LinearPercentIndicator(
                                width: constraints.maxWidth * 0.55,
                                lineHeight: constraints.maxWidth * 0.063,
                                percent: 54.6 / 100,
                                progressColor: Colors.blue.shade400,
                                center: Text(
                                  "54.6",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth * 0.061),
                                ),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Carb :",
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.061),
                                )),
                            Expanded(
                              flex: 2,
                              child: LinearPercentIndicator(
                                width: constraints.maxWidth * 0.55,
                                lineHeight: constraints.maxWidth * 0.063,
                                percent: 271.4 / 300,
                                progressColor: Colors.blue,
                                center: Text(
                                  "271.4",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth * 0.061),
                                ),
                              ),
                            ),
                          ])
                    ]),
              ),
            ),
          ]),
        );
      }),
    );
  }

  List<RadialBarSeries<RadialChartData, String>> _getRadialBarSeries() {
    return <RadialBarSeries<RadialChartData, String>>[
      RadialBarSeries<RadialChartData, String>(
          trackColor: Colors.blue,
          trackOpacity: 0.3,
          dataSource: chartDataRadial,
          xValueMapper: (RadialChartData d1, _) => d1.x,
          yValueMapper: (RadialChartData d2, _) => d2.y,
          pointColorMapper: (RadialChartData d3, _) => d3.color,
          cornerStyle: CornerStyle.bothCurve,
          maximumValue: 1200,
          innerRadius: '80%',
          radius: '100%'),
    ];
  }

  List<BarSeries<BarChartData, String>> _getBarSeries() {
    return <BarSeries<BarChartData, String>>[
      BarSeries<BarChartData, String>(
        dataSource: chartDataBar,
        xValueMapper: (BarChartData d1, _) => d1.x,
        yValueMapper: (BarChartData d2, _) => d2.y,
        pointColorMapper: (BarChartData d3, _) => d3.color,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }
}
