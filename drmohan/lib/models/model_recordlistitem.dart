class HealthTrackerRecordItem{
  final String MrNo;
  final String VitalID;
  final String VitalName;
  final String Value1;
  final String Value2;
  final String Date;

  const HealthTrackerRecordItem({
    required this.MrNo,
    required this.VitalID,
    required this.VitalName,
    required this.Value1,
    required this.Value2,
    required this.Date,
  });

  Map<String, dynamic> toMap() {
    return {
      'MrNo': MrNo,
      'VitalID': VitalID,
      'VitalName': VitalName,
      'Value1': Value1,
      'Value2': Value2,
      'Date': Date,
    };
  }

  factory HealthTrackerRecordItem.fromMap(Map<String, dynamic> map) {
    return HealthTrackerRecordItem(
      MrNo: map['MrNo'] as String,
      VitalID: map['VitalID'] as String,
      VitalName: map['VitalName'] as String,
      Value1: map['Value1'] as String,
      Value2: map['Value2'] as String,
      Date: map['Date'] as String,
    );
  }
}