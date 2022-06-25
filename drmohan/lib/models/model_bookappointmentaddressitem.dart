class Addressitem {
  final String AddressID;
  final String MrNo;
  final String LocName;
  final String Address;
  final String Pincode;
  final String Category;
  final String Lat;
  final String Long;

  Addressitem({
    required this.AddressID,
    required this.MrNo,
    required this.LocName,
    required this.Address,
    required this.Pincode,
    required this.Category,
    required this.Lat,
    required this.Long,
  });

  factory Addressitem.fromJson(Map<String, dynamic> json) {
    return Addressitem(
        AddressID: json['AddressID'] as String,
        MrNo: json['MrNo'] as String,
        LocName: json['LocName'] as String,
        Address: json['Address'] as String,
        Pincode: json['Pincode'] as String,
        Category: json['Category'] as String,
        Lat: json['Lat'] as String,
        Long: json['Long'] as String);
  }
}
