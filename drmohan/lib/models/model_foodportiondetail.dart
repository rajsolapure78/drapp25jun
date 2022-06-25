class FoodPortionDetail{
  final int foodID;
  final String foodDesc;
  final String portionTool;
  final String portionSize;
  final String foodImage;
  final num Protein;
  final num Carbohydrates;
  final num Energy;
  final num Fat;
  final num Dietary_Fibre;

  const FoodPortionDetail({
    required this.foodID,
    required this.foodDesc,
    required this.portionTool,
    required this.portionSize,
    required this.foodImage,
    required this.Protein,
    required this.Carbohydrates,
    required this.Energy,
    required this.Fat,
    required this.Dietary_Fibre,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodID': foodID,
      'foodDesc': foodDesc,
      'portionTool': portionTool,
      'portionSize': portionSize,
      'foodImage': foodImage,
      'Protein': Protein,
      'Carbohydrates': Carbohydrates,
      'Energy': Energy,
      'Fat': Fat,
      'Dietary_Fibre': Dietary_Fibre,
    };
  }

  factory FoodPortionDetail.fromMap(Map<String, dynamic> map) {
    return FoodPortionDetail(
      foodID: map['foodID'] as int,
      foodDesc: map['foodDesc'] as String,
      portionTool: map['portionTool'] as String,
      portionSize: map['portionSize'] as String,
      foodImage: map['foodImage'] as String,
      Protein: map['Protein'] as num,
      Carbohydrates: map['Carbohydrates'] as num,
      Energy: map['Energy'] as num,
      Fat: map['Fat'] as num,
      Dietary_Fibre: map['Dietary_Fibre'] as num,
    );
  }
}