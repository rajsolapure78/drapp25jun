class LabResultItem {
  final String ServiceName;
  final String VisitDate;
  final String URL;

  LabResultItem(
      {required this.ServiceName, required this.VisitDate, required this.URL});

  factory LabResultItem.fromJson(Map<String, dynamic> json) {
    return LabResultItem(
        ServiceName: json['ServiceName'] as String,
        VisitDate: json['VisitDate'] as String,
        URL: json['URL'] as String);
  }
}
