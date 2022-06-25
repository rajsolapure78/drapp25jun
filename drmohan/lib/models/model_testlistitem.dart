class TestListItem {
  final String TestID;
  final String TestName;
  final String Rate;
  TestListItem(
      {required this.TestID, required this.TestName, required this.Rate});
  factory TestListItem.fromJson(Map<String, dynamic> json) {
    return TestListItem(
        TestID: json['TestID'] as String,
        TestName: json['TestName'] as String,
        Rate: json['Rate'] as String);
  }
}
