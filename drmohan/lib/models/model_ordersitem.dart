class Ordersitem {
  final String OrderID;
  final String Code;
  final String Name;
  final String Rate;
  final String Qty;
  final String Amount;
  final String Category;
  final String ImgURL;

  Ordersitem({
    required this.OrderID,
    required this.Code,
    required this.Name,
    required this.Rate,
    required this.Qty,
    required this.Amount,
    required this.Category,
    required this.ImgURL,
  });

  factory Ordersitem.fromJson(Map<String, dynamic> json) {
    return Ordersitem(
        OrderID: json['OrderID'] as String,
        Code: json['Code'] as String,
        Name: json['Name'] as String,
        Rate: json['Rate'] as String,
        Qty: json['Qty'] as String,
        Amount: json['Amount'] as String,
        Category: json['Category'] as String,
        ImgURL: json['ImgURL'] as String);
  }
}
