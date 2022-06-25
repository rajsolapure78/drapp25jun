class SpotLightitem {
  final String link;
  final String enDate;
  final String linkType;
  final String priority;

  SpotLightitem(
      {required this.link,
      required this.enDate,
      required this.linkType,
      required this.priority});

  factory SpotLightitem.fromJson(Map<String, dynamic> json) {
    return SpotLightitem(
        link: json['link'] as String,
        enDate: json['enDate'] as String,
        linkType: json['linkType'] as String,
        priority: json['priority'] as String);
  }
}
