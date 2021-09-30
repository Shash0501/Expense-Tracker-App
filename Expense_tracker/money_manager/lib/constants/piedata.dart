class PieData {
  List<Data> data;
  PieData({required this.data});
}

class Data {
  final String CategoryName;
  final double CategoryExpense;
  final int CategoryColor;
  Data(
      {required this.CategoryName,
      required this.CategoryExpense,
      required this.CategoryColor});
}
