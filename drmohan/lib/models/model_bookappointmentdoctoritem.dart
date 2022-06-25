class Doctoritem {
  final String DrID;
  final String DrName;
  final String Email;
  final String LocID;
  final String Code;
  final String ReviewFees;
  final String TeleConsultFees;
  final String Qualification;
  final String Experience;
  final String ImgURL;
  final String Display;

  Doctoritem({required this.DrID, required this.DrName, required this.Email, required this.LocID, required this.Code, required this.ReviewFees, required this.TeleConsultFees, required this.Qualification, required this.Experience, required this.ImgURL, required this.Display});

  factory Doctoritem.fromJson(Map<String, dynamic> json) {
    return Doctoritem(DrID: json['DrID'] as String, DrName: json['DrName'] as String, Email: json['Email'] as String, LocID: json['LocID'] as String, Code: json['Code'] as String, ReviewFees: json['ReviewFees'] as String, TeleConsultFees: json['TeleConsultFees'] as String, Qualification: json['Qualification'] as String, Experience: json['Experience'] as String, ImgURL: json['ImgURL'] as String, Display: json['Display'] as String);
  }
}
