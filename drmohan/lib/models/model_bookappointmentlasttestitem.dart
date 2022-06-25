class LastTestitem {
  final String TestID;
  final String TestName;
  final String Rate;
  LastTestitem(
      {required this.TestID, required this.TestName, required this.Rate});
  factory LastTestitem.fromJson(Map<String, dynamic> json) {
    return LastTestitem(
        TestID: json['TestID'] as String,
        TestName: json['TestName'] as String,
        Rate: json['Rate'] as String);
  }
}
