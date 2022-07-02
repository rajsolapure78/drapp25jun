import 'package:drmohan/models/model_healthtrackerrecord.dart';
import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackerbloodpressure.dart';
import 'package:drmohan/screens/screen_dailyhealthtrackerweight.dart';
import 'package:flutter/material.dart';

class VitalsTrackerTile extends StatefulWidget {
  final List<HealthTrackerRecordItem> bloodPressureItem;
  final String bloodPressureVitalId;
  final HealthTrackerRecord bloodPressureVitals;
  final String bloodPressureRef;

  final List<HealthTrackerRecordItem> weightItem;
  final String weightVitalId;
  final String weightRef;

  const VitalsTrackerTile(
      {Key? key,
      required this.bloodPressureItem,
      required this.bloodPressureVitalId,
      required this.bloodPressureVitals,
      required this.weightItem,
      required this.weightVitalId,
      required this.bloodPressureRef,
      required this.weightRef})
      : super(key: key);

  @override
  _VitalsTrackerTileState createState() => _VitalsTrackerTileState();
}

class _VitalsTrackerTileState extends State<VitalsTrackerTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
      child: Card(
        elevation: 6,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Vitals",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth * 0.078),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyHealthTrackerWeightScreen(
                            weightItem: widget.weightItem,
                            vitalId: widget.weightVitalId,
                          ),
                        ));
                  },
                  child: ListTile(
                    visualDensity: const VisualDensity(vertical: -1),
                    dense: true,
                    leading: SizedBox(
                      height: constraints.maxHeight * 0.154,
                      width: constraints.maxWidth * 0.174,
                      child: Image.network(
                          'https://www.rsolutions7.com/drmohan/images/weight.png'),
                    ),
                    title: Text(
                      "Weight",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth * 0.061),
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          widget.weightRef,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxWidth * 0.078),
                        ),
                        // Text(
                        //   "kg",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: constraints.maxWidth * 0.043),
                        // ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DailyHealthTrackerBloodPressureScreen(
                            bloodPressureItem: widget.bloodPressureItem,
                            vitalId: widget.bloodPressureVitalId,
                            bloodPressureVitals: widget.bloodPressureVitals,
                          ),
                        ));
                  },
                  child: ListTile(
                    visualDensity: const VisualDensity(vertical: -1),
                    dense: true,
                    leading: SizedBox(
                      height: constraints.maxHeight * 0.154,
                      width: constraints.maxWidth * 0.174,
                      child: Image.network(
                          'https://www.rsolutions7.com/drmohan/images/bloodpressure.png'),
                    ),
                    title: Text(
                      "Blood Pressure",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth * 0.061),
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          widget.bloodPressureRef.split(" ").first.padRight(7),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxWidth * 0.078),
                        ),
                        Text(
                          widget.bloodPressureRef.split(" ").last,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxWidth * 0.043),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
        }),
      ),
    );
  }
}
