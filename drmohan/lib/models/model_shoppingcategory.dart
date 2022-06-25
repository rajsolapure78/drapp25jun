class ShoppingCategoryItem {
  final String ID;
  final String Category;
  ShoppingCategoryItem({required this.ID, required this.Category});
  factory ShoppingCategoryItem.fromJson(Map<String, dynamic> json) {
    return ShoppingCategoryItem(
        ID: json['ID'] as String, Category: json['Category'] as String);
  }
}
