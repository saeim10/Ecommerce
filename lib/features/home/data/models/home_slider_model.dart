class HomeSliderModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final String image;

  HomeSliderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });
  factory HomeSliderModel.fromJson(Map<String, dynamic> jsonData) {
    return HomeSliderModel(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['short_des'],
      price: jsonData['price'],
      image: jsonData['image'],
    );
  }
}
