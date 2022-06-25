class DietDetailItem{
  final String food;
  final String size;
  final String consumedCalories;

  const DietDetailItem({
    required this.food,
    required this.size,
    required this.consumedCalories,
  });

  Map<String, dynamic> toMap() {
    return {
      'food': food,
      'size': size,
      'consumedCalories': consumedCalories,
    };
  }

  factory DietDetailItem.fromMap(Map<String, dynamic> map) {
    return DietDetailItem(
      food: map['food'] as String,
      size: map['size'] as String,
      consumedCalories: map['consumedCalories'] as String,
    );
  }
}