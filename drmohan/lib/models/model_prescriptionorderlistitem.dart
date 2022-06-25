class PrescriptionOrderListItem {
  String Code;
  String Name;
  String Rate;
  String Type;
  String Qty;
  String Amount;
  String TotalAmount;

  PrescriptionOrderListItem({required this.Code, required this.Name, required this.Rate, required this.Type, required this.Qty, required this.Amount, required this.TotalAmount});

  factory PrescriptionOrderListItem.fromJson(Map<String, dynamic> json) {
    return PrescriptionOrderListItem(Code: json['Code'] as String, Name: json['Name'] as String, Rate: json['Rate'] as String, Type: json['Type'] as String, Qty: json['Qty'] as String, Amount: json['Amount'] as String, TotalAmount: json['TotalAmount'] as String);
  }
}
