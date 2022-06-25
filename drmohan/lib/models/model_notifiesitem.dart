class Notifiesitem {
  final String id;
  final String Text;
  final String enDate;
  final String ReadStatus;

  Notifiesitem(
      {required this.id,
      required this.Text,
      required this.enDate,
      required this.ReadStatus});

  factory Notifiesitem.fromJson(Map<String, dynamic> json) {
    return Notifiesitem(
        id: json['id'] as String,
        Text: json['Text'] as String,
        enDate: json['enDate'] as String,
        ReadStatus: json['ReadStatus'] as String);
  }
}
