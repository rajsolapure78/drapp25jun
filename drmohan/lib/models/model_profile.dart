class Profile {
  final String PatientId;
  final String PatientName;
  final String DOB;
  final String Age;
  final String Gender;
  final String Phone;
  final String Email;
  final String MrNo;
  final String Address;
  final String Village;
  final String City;
  final String Pincode;
  final String LocID;
  final String LocName;

  Profile(
      {required this.PatientId,
      required this.PatientName,
      required this.DOB,
      required this.Age,
      required this.Gender,
      required this.Phone,
      required this.Email,
      required this.MrNo,
      required this.Address,
      required this.Village,
      required this.City,
      required this.Pincode,
      required this.LocID,
      required this.LocName});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      PatientId: json['PatientId'] as String,
      PatientName: json['PatientName'] as String,
      DOB: json['DOB'] as String,
      Age: json['Age'] as String,
      Gender: json['Gender'] as String,
      Phone: json['Phone'] as String,
      Email: json['Email'] as String,
      MrNo: json['MrNo'] as String,
      Address: json['Address'] as String,
      Village: json['Village'] as String,
      City: json['City'] as String,
      Pincode: json['Pincode'] as String,
      LocID: json['LocID'] as String,
      LocName: json['LocName'] as String,
    );
  }
}
