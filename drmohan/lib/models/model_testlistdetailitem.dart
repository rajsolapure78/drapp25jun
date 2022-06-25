class TestListDetailItem{
  final String TestShName;
  final int TestID;
  final String TestName;
  final String YAxisStartValue;
  final String YAxisEndValue;
  final String YAxisRange;
  final String StartReferenceRange;
  final String EndReferenceRange;

  const TestListDetailItem({
    required this.TestShName,
    required this.TestID,
    required this.TestName,
    required this.YAxisStartValue,
    required this.YAxisEndValue,
    required this.YAxisRange,
    required this.StartReferenceRange,
    required this.EndReferenceRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'TestShName': TestShName,
      'TestID': TestID,
      'TestName': TestName,
      'YAxisStartValue': YAxisStartValue,
      'YAxisEndValue': YAxisEndValue,
      'YAxisRange': YAxisRange,
      'StartReferenceRange': StartReferenceRange,
      'EndReferenceRange': EndReferenceRange,
    };
  }

  factory TestListDetailItem.fromMap(Map<String, dynamic> map) {
    return TestListDetailItem(
      TestShName: map['TestShName'] as String,
      TestID: map['TestID'] as int,
      TestName: map['TestName'] as String,
      YAxisStartValue: map['YAxisStartValue'] as String,
      YAxisEndValue: map['YAxisEndValue'] as String,
      YAxisRange: map['YAxisRange'] as String,
      StartReferenceRange: map['StartReferenceRange'] as String,
      EndReferenceRange: map['EndReferenceRange'] as String,
    );
  }
}