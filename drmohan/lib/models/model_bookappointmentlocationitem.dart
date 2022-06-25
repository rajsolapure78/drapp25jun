class Locationitem {
  final String LocID;
  final String Code;
  final String LocName;
  final String Address;
  final String City;
  final String State;
  final String Phone;
  final String Lattitude;
  final String Longitude;
  final String GoogleID;
  final String ProfileID;
  final String ImgUrl;

  Locationitem(
      {required this.LocID,
      required this.Code,
      required this.LocName,
      required this.Address,
      required this.City,
      required this.State,
      required this.Phone,
      required this.Lattitude,
      required this.Longitude,
      required this.GoogleID,
      required this.ProfileID,
      required this.ImgUrl});

  factory Locationitem.fromJson(Map<String, dynamic> json) {
    return Locationitem(
        LocID: json['LocID'] as String,
        Code: json['Code'] as String,
        LocName: json['LocName'] as String,
        Address: json['Address'] as String,
        City: json['City'] as String,
        State: json['State'] as String,
        Phone: json['Phone'] as String,
        Lattitude: json['Lattitude'] as String,
        Longitude: json['Longitude'] as String,
        GoogleID: json['GoogleID'] as String,
        ProfileID: json['ProfileID'] as String,
        ImgUrl: json['ImgUrl'] as String);
  }
}
