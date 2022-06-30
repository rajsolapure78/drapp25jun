import 'package:auto_size_text/auto_size_text.dart';
import 'package:drmohan/models/model_healthtrackeritem.dart';
import 'package:drmohan/models/radial_chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightTrackerTile extends StatefulWidget {
  final HealthTrackerItem weightItem;

  const WeightTrackerTile({Key? key, required this.weightItem})
      : super(key: key);

  @override
  _WeightTrackerTileState createState() => _WeightTrackerTileState();
}

class _WeightTrackerTileState extends State<WeightTrackerTile> {
  late List<RadialChartData> chartDataRadial;

  @override
  void initState() {
    chartDataRadial = <RadialChartData>[
      RadialChartData(
        x: 'Good',
        y: 11.7,
        color: Colors.blue,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints.maxWidth);
        print(constraints.maxHeight);
        return Card(
          elevation: 6,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: AutoSizeText(
                    "Body Mass Index (BMI)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth * 0.078),
                    maxLines: 1,
                  ),
                ),
                Stack(children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.65,
                    width: constraints.maxWidth * 0.65,
                    child: SfCircularChart(
                        borderWidth: 0,
                        margin: EdgeInsets.zero,
                        series: _getRadialBarSeries()),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.247,
                    left: constraints.maxWidth * 0.247,
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
                            "BMI",
                            style: TextStyle(
                                fontSize: constraints.maxWidth * 0.07),
                          ),
                        ]),
                  ),
                ]),
                Text(
                  "Underweight",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                      fontSize: constraints.maxWidth * 0.052),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: AutoSizeText(
                    "Dec 25, 2021 11:13:58 PM",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: constraints.maxWidth * 0.07),
                    maxLines: 1,
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
          maximumValue: 24,
          innerRadius: '80%',
          radius: '100%'),
    ];
  }
}
