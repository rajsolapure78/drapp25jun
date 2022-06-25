class Productsitem {
  final String ID;
  final String Code;
  final String Name;
  final String Category;
  String Rate;
  String Qty;
  final String ImgURL;
  bool itemSelected;

  Productsitem({required this.ID, required this.Code, required this.Name, required this.Category, required this.Rate, required this.Qty, required this.ImgURL, required this.itemSelected});

  factory Productsitem.fromJson(Map<String, dynamic> json) {
    return Productsitem(
      ID: json['ID'] as String,
      Code: json['Code'] as String,
      Name: json['Name'] as String,
      Category: json['Category'] as String,
      Rate: json['Rate'] as String,
      Qty: json['Qty'] as String,
      ImgURL: json['ImgURL'] as String,
      itemSelected: json['itemSelected'] as bool,
    );
  }
}
