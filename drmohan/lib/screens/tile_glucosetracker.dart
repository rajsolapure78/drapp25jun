import 'package:auto_size_text/auto_size_text.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/models/pie_chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GluscoseTrackerTile extends StatefulWidget {
  final List<HealthTrackerRecordItem> glucoseItem;

  const GluscoseTrackerTile({Key? key, required this.glucoseItem}) : super(key: key);

  @override
  _GluscoseTrackerTileState createState() => _GluscoseTrackerTileState();
}

class _GluscoseTrackerTileState extends State<GluscoseTrackerTile> {
  late List<PieChartData> chartDataPie;

  @override
  void initState() {
    chartDataPie = <PieChartData>[
      PieChartData(x: 'Low', y: 3, color: Colors.blue),
      PieChartData(x: 'High', y: 2, color: Colors.blue.shade600),
      PieChartData(x: 'Good', y: 7, color: Colors.blue.shade400),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 6,
          child: Column(children: [
            Expanded(
              flex: 5,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: AutoSizeText(
                    'My Glucose Value',
                    style: TextStyle(fontSize: constraints.maxWidth * 0.078, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),
                Text("Last 3 Readings", style: TextStyle(fontSize: constraints.maxWidth * 0.043)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Column(children: [
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.22,
                        width: constraints.maxWidth * 0.28,
                        child: Image.network('https://www.rsolutions7.com/drmohan/images/onetouch.png'),
                      ),
                      Positioned(
                        left: constraints.maxWidth * 0.090,
                        top: constraints.maxHeight * 0.039,
                        child: Text(
                          widget.glucoseItem != null && widget.glucoseItem.length > 0 ? num.parse(widget.glucoseItem.first.Value1).round().toString() : "-",
                          style: TextStyle(fontSize: constraints.maxWidth * 0.052, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    Text(widget.glucoseItem != null && widget.glucoseItem.length > 0 ? widget.glucoseItem.first.Date.split(" ")[1] : "-", style: TextStyle(fontSize: constraints.maxWidth * 0.0435)),
                  ]),
                  Column(children: [
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.22,
                        width: constraints.maxWidth * 0.28,
                        child: Image.network('https://www.rsolutions7.com/drmohan/images/onetouch.png'),
                      ),
                      Positioned(
                        left: constraints.maxWidth * 0.090,
                        top: constraints.maxHeight * 0.039,
                        child: Text(widget.glucoseItem != null && widget.glucoseItem.length > 1 ? num.parse(widget.glucoseItem[1].Value1).round().toString() : "-", style: TextStyle(fontSize: constraints.maxWidth * 0.052, fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    Text(widget.glucoseItem != null && widget.glucoseItem.length > 1 ? widget.glucoseItem[1].Date.split(" ")[1] : "-", style: TextStyle(fontSize: constraints.maxWidth * 0.0435)),
                  ]),
                  Column(children: [
                    Stack(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.22,
                        width: constraints.maxWidth * 0.28,
                        child: Image.network('https://www.rsolutions7.com/drmohan/images/onetouch.png'),
                      ),
                      Positioned(
                        left: constraints.maxWidth * 0.090,
                        top: constraints.maxHeight * 0.039,
                        child: Text(
                          widget.glucoseItem != null && widget.glucoseItem.length > 2 ? num.parse(widget.glucoseItem[2].Value1).round().toString() : "-",
                          style: TextStyle(fontSize: constraints.maxWidth * 0.052, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    Text(widget.glucoseItem != null && widget.glucoseItem.length > 2 ? widget.glucoseItem[2].Date.split(" ")[1] : "-", style: TextStyle(fontSize: constraints.maxWidth * 0.0435)),
                  ]),
                ]),
                Text(
                  "mmHg",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth * 0.0435),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            Expanded(
              flex: 4,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(children: const [
                    Text(
                      "Monthly Distribution",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
                    ),
                  ]),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Wrap(direction: Axis.vertical, children: [
                          Text("Low: 3", style: TextStyle(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth * 0.052)),
                          Text("High: 2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth * 0.052)),
                          Text("Good: 7", style: TextStyle(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth * 0.052)),
                        ]),
                      ]),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.31,
                        width: constraints.maxWidth * 0.38,
                        child: SfCircularChart(
                          series: _getPieSeries(),
                        ),
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

  List<PieSeries<PieChartData, String>> _getPieSeries() {
    return <PieSeries<PieChartData, String>>[
      PieSeries<PieChartData, String>(dataSource: chartDataPie, radius: '125%', xValueMapper: (PieChartData d1, _) => d1.x, yValueMapper: (PieChartData d2, _) => d2.y, pointColorMapper: (PieChartData d3, _) => d3.color, dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }
}
