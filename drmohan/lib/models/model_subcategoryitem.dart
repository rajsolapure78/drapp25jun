class SubCategoryItem {
  final String SubCatID;
  final String subCategory;
  final String ImageUrl;

  SubCategoryItem(
      {required this.SubCatID,
      required this.subCategory,
      required this.ImageUrl});

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
        SubCatID: json['SubCatID'] as String,
        subCategory: json['subCategory'] as String,
        ImageUrl: json['ImageUrl'] as String);
  }
}
