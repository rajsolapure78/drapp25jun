import 'package:drmohan/models/model_recordlistitem.dart';
import 'package:flutter/material.dart';

class VitalsTrackerTile extends StatefulWidget {
  final List<HealthTrackerRecordItem> bloodPressureItem;

  const VitalsTrackerTile({Key? key, required this.bloodPressureItem}) : super(key: key);

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
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                ListTile(
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
                        "70 ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.078),
                      ),
                      Text(
                        "kg",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.043),
                      ),
                    ],
                  ),
                ),
                ListTile(
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
                        "80/120 ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.078),
                      ),
                      Text(
                        "mmHg",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth * 0.043),
                      ),
                    ],
                  ),
                ),
              ]);
        }),
      ),
    );
  }
}
