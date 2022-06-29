import 'package:auto_size_text/auto_size_text.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/models/radial_chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityTrackerTile extends StatefulWidget {
  final List<HealthTrackerRecordItem> weightItem;

  const ActivityTrackerTile({Key? key, required this.weightItem})
      : super(key: key);

  @override
  _ActivityTrackerTileState createState() => _ActivityTrackerTileState();
}

class _ActivityTrackerTileState extends State<ActivityTrackerTile> {
  late List<RadialChartData> chartDataRadial1;
  late List<RadialChartData> chartDataRadial2;

  @override
  void initState() {
    chartDataRadial1 = <RadialChartData>[
      RadialChartData(
        x: 'Steps',
        y: 8056,
        color: Colors.blue,
      ),
    ];

    chartDataRadial2 = <RadialChartData>[
      RadialChartData(
        x: 'Calories Burned',
        y: 500,
        color: Colors.deepOrangeAccent,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints.maxHeight);
        return Card(
          elevation: 6,
          child: Column(children: [
            Expanded(
              flex: 10,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: AutoSizeText(
                        "Physical Activity (per day)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.078),
                        maxLines: 1,
                      ),
                    ),
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.35,
                        width: constraints.maxHeight * 0.35,
                        child: SfCircularChart(
                          borderWidth: 0,
                          margin: EdgeInsets.zero,
                          series: _getRadialBarSeries(
                              chartDataRadial1, 10000, Colors.blue),
                        ),
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.105,
                        left: constraints.maxHeight * 0.175 - 20,
                        child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                chartDataRadial1.first.y.toString(),
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.078,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Steps",
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.07),
                              ),
                            ]),
                      ),
                    ]),
                    const Text(
                      "Goal - 10000",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            Expanded(
              flex: 9,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Calories Burned",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth * 0.07),
                    ),
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.35,
                        width: constraints.maxHeight * 0.35,
                        child: SfCircularChart(
                            borderWidth: 0,
                            margin: EdgeInsets.zero,
                            series: _getRadialBarSeries(chartDataRadial2, 1000,
                                Colors.deepOrangeAccent)),
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.1,
                        left: constraints.maxHeight * 0.175 - 20,
                        child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight * 0.128,
                                width: constraints.maxHeight * 0.128,
                                child: Image.network(
                                    'https://www.rsolutions7.com/drmohan/images/calorieburntfire.png'),
                              ),
                              Text(
                                chartDataRadial2.first.y.toString(),
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.07),
                              ),
                            ]),
                      ),
                    ]),
                  ]),
            ),
          ]),
        );
      }),
    );
  }

  List<RadialBarSeries<RadialChartData, String>> _getRadialBarSeries(
      List<RadialChartData> data, double maxValue, Color trackColor) {
    return <RadialBarSeries<RadialChartData, String>>[
      RadialBarSeries<RadialChartData, String>(
        dataSource: data,
        trackOpacity: 0.3,
        trackColor: trackColor,
        xValueMapper: (RadialChartData d1, _) => d1.x,
        yValueMapper: (RadialChartData d2, _) => d2.y,
        pointColorMapper: (RadialChartData d3, _) => d3.color,
        innerRadius: '80%',
        radius: '100%',
        cornerStyle: CornerStyle.bothCurve,
        maximumValue: maxValue,
      ),
    ];
  }
}
