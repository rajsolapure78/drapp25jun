import 'package:drmohan/models/model_recordlistitem.dart';

class HealthTrackerRecord{
  final List<dynamic> list;
  final String YaxisMinRange;
  final String YaxisMaxRange;
  final String YaxisInterval;
  final String Xaxis;
  final String LowerRefRange;
  final String UpperRefRange;
  final String IsRange;
  final String Status;

  const HealthTrackerRecord({
    required this.list,
    required this.YaxisMinRange,
    required this.YaxisMaxRange,
    required this.YaxisInterval,
    required this.Xaxis,
    required this.LowerRefRange,
    required this.UpperRefRange,
    required this.IsRange,
    required this.Status,
  });

  Map<String, dynamic> toMap() {
    return {
      'List': list,
      'YaxisMinRange': YaxisMinRange,
      'YaxisMaxRange': YaxisMaxRange,
      'YaxisInterval': YaxisInterval,
      'Xaxis': Xaxis,
      'LowerRefRange': LowerRefRange,
      'UpperRefRange': UpperRefRange,
      'IsRange': IsRange,
      'Status': Status,
    };
  }

  factory HealthTrackerRecord.fromMap(Map<String, dynamic> map) {
    return HealthTrackerRecord(
      list: map['List'] as List<dynamic>,
      YaxisMinRange: map['YaxisMinRange'] as String,
      YaxisMaxRange: map['YaxisMaxRange'] as String,
      YaxisInterval: map['YaxisInterval'] as String,
      Xaxis: map['Xaxis'] as String,
      LowerRefRange: map['LowerRefRange'] as String,
      UpperRefRange: map['UpperRefRange'] as String,
      IsRange: map['IsRange'] as String,
      Status: map['Status'] as String,
    );
  }
}