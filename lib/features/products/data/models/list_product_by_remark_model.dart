class ListProductByRemarkModel {
  final int id;
  final String title;
  final String shortDes;
  final String price;
  final int discount;
  final String discountPrice;
  final String image;
  final int stock;
  final int star;
  final String remark;
  final int categoryId;
  final int brandId;
  final String createdAt;
  final String updatedAt;

  ListProductByRemarkModel({
    required this.id,
    required this.title,
    required this.shortDes,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.image,
    required this.stock,
    required this.star,
    required this.remark,
    required this.categoryId,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListProductByRemarkModel.fromJson(Map<String, dynamic> json) {
    return ListProductByRemarkModel(
      id: json['id'],
      title: json['title'],
      shortDes: json['short_des'],
      price: json['price'],
      discount: json['discount'],
      discountPrice: json['discount_price'],
      image: json['image'],
      stock: json['stock'],
      star: json['star'],
      remark: json['remark'],
      categoryId: json['category_id'],
      brandId: json['brand_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

}