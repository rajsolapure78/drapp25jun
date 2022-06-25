class AppInfoItem {
  final String srntxt1;
  final String srntxt2;
  final String srntxt3;
  final String srntxt4;
  final String srntxt5;
  final String srntxt6;
  final String srntxt7;
  final String srntxt8;
  final String srntxt9;
  final String srntxt10;

  AppInfoItem(
      {required this.srntxt1,
      required this.srntxt2,
      required this.srntxt3,
      required this.srntxt4,
      required this.srntxt5,
      required this.srntxt6,
      required this.srntxt7,
      required this.srntxt8,
      required this.srntxt9,
      required this.srntxt10});

  factory AppInfoItem.fromJson(Map<String, dynamic> json) {
    return AppInfoItem(
      srntxt1: json['srntxt1'] as String,
      srntxt2: json['srntxt2'] as String,
      srntxt3: json['srntxt3'] as String,
      srntxt4: json['srntxt4'] as String,
      srntxt5: json['srntxt5'] as String,
      srntxt6: json['srntxt6'] as String,
      srntxt7: json['srntxt7'] as String,
      srntxt8: json['srntxt8'] as String,
      srntxt9: json['srntxt9'] as String,
      srntxt10: json['srntxt10'] as String,
    );
  }
}
