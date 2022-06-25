class PrescriptionItem {
  final String ItemName;
  final String generic;
  final String duration;
  final String rate;
  final String qty;
  final String uom;
  final String DrName;
  final String Morning;
  final String Afternoon;
  final String Night;

  PrescriptionItem({required this.ItemName, required this.generic, required this.duration, required this.rate, required this.qty, required this.uom, required this.DrName, required this.Morning, required this.Afternoon, required this.Night});

  factory PrescriptionItem.fromJson(Map<String, dynamic> json) {
    return PrescriptionItem(ItemName: json['ItemName'] as String, generic: json['generic'] as String, duration: json['duration'] as String, rate: json['rate'] as String, qty: json['qty'] as String, uom: json['uom'] as String, DrName: json['DrName'] as String, Morning: json['Morning'] as String, Afternoon: json['Afternoon'] as String, Night: json['Night'] as String);
  }
}
