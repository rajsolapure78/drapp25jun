class HealthTrackerItem {
  final String VitalID;
  final String VitalName;
  final String Units;
  final String IsRange;
  final String LowerRange;
  final String UpperRange;
  final String RefRange;



  Map<String, dynamic> toMap() {
    return {
      'VitalID': VitalID,
      'VitalName': VitalName,
      'Units': Units,
      'IsRange': IsRange,
      'LowerRange': LowerRange,
      'UpperRange': UpperRange,
      'RefRange': RefRange,
    };
  }

  factory HealthTrackerItem.fromMap(Map<String, dynamic> map) {
    return HealthTrackerItem(
      VitalID: map['VitalID'] as String,
      VitalName: map['VitalName'] as String,
      Units: map['Units'] as String,
      IsRange: map['IsRange'] as String,
      LowerRange: map['LowerRange'] as String,
      UpperRange: map['UpperRange'] as String,
      RefRange: map['RefRange'] as String,
    );
  }

  const HealthTrackerItem({
    required this.VitalID,
    required this.VitalName,
    required this.Units,
    required this.IsRange,
    required this.LowerRange,
    required this.UpperRange,
    required this.RefRange,
  });
}