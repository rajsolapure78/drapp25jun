class FoodDetailItem {
  final int Food_Id;
  final String Food_Desc;

  const FoodDetailItem({
    required this.Food_Id,
    required this.Food_Desc,
  });

  Map<String, dynamic> toMap() {
    return {
      'Food_Id': Food_Id,
      'Food_Desc': Food_Desc,
    };
  }

  factory FoodDetailItem.fromMap(Map<String, dynamic> map) {
    return FoodDetailItem(
      Food_Id: map['Food_Id'] as int,
      Food_Desc: map['Food_Desc'] as String,
    );
  }
}