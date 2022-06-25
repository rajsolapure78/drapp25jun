import 'package:drmohan/models/model_dietdetailitem.dart';

class MyDietItem {
  final String diet;
  String totalConsumedCalories;
  final String totalCalories;
  List<DietDetailItem> dietDetails;

  MyDietItem({
    required this.diet,
    required this.totalConsumedCalories,
    required this.totalCalories,
    required this.dietDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'diet': diet,
      'totalConsumedCalories': totalConsumedCalories,
      'totalCalories': totalCalories,
      'dietDetails': dietDetails,
    };
  }

  factory MyDietItem.fromMap(Map<String, dynamic> map) {
    return MyDietItem(
      diet: map['diet'] as String,
      totalConsumedCalories: map['totalConsumedCalories'] as String,
      totalCalories: map['totalCalories'] as String,
      dietDetails: map['dietDetails'] as List<DietDetailItem>,
    );
  }
}
