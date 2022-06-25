class TestResultItem{
  final String VisitDate;
  final String Result;
  final String RefRange;

  const TestResultItem({
    required this.VisitDate,
    required this.Result,
    required this.RefRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'VisitDate': VisitDate,
      'Result': Result,
      'RefRange': RefRange,
    };
  }

  factory TestResultItem.fromMap(Map<String, dynamic> map) {
    return TestResultItem(
      VisitDate: map['VisitDate'] as String,
      Result: map['Result'] as String,
      RefRange: map['RefRange'] as String,
    );
  }
}