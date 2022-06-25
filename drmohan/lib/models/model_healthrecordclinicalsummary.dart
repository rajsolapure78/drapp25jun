class ClinicalSummayItem {
  final String TestShName;
  final String TestName;
  ClinicalSummayItem({required this.TestShName, required this.TestName});
  factory ClinicalSummayItem.fromJson(Map<String, dynamic> json) {
    return ClinicalSummayItem(
        TestShName: json['TestShName'] as String,
        TestName: json['TestName'] as String);
  }
}
