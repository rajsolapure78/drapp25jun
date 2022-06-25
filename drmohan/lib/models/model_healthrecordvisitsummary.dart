class VisitSummayItem {
  final String Doctor;
  final String Dpt;
  final String VisitDate;

  VisitSummayItem(
      {required this.Doctor, required this.Dpt, required this.VisitDate});

  factory VisitSummayItem.fromJson(Map<String, dynamic> json) {
    return VisitSummayItem(
        Doctor: json['Doctor'] as String,
        Dpt: json['Dpt'] as String,
        VisitDate: json['VisitDate'] as String);
  }
}
