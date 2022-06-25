class HealthRecorditem {
  final String title;
  final String imgurl;
  final String screentoload;

  HealthRecorditem(
      {required this.title, required this.imgurl, required this.screentoload});

  factory HealthRecorditem.fromJson(Map<String, dynamic> json) {
    return HealthRecorditem(
        title: json['title'] as String,
        imgurl: json['imgurl'] as String,
        screentoload: json['screentoload'] as String);
  }
}
