class CategoryListModel {
  final int id;
  final String categoryName;
  final String categoryImg;

  CategoryListModel({
    required this.id,
    required this.categoryName,
    required this.categoryImg,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryListModel(
      id: jsonData['id'],
      categoryName: jsonData['categoryName'],
      categoryImg: jsonData['categoryImg'],
    );
  }
}
