class CartListModel {
  final String userId;
  final int productId;
  final String color;
  final String size;
  final int qty;
  final int price;
  final String updatedAt;
  final String createdAt;
  final int id;
  final Product product;

  CartListModel({
    required this.userId,
    required this.productId,
    required this.color,
    required this.size,
    required this.qty,
    required this.price,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.product,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) {
    return CartListModel(
      userId: json['user_id'].toString(),
      productId: json['product_id'],
      color: json['color'] ?? '',
      size: json['size'] ?? '',
      qty: int.tryParse(json['qty'].toString()) ?? 0,
      price: int.tryParse(json['price'].toString()) ?? 0,
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}
class Product {
  final int id;
  final String title;
  final String shortDes;
  final int price;
  final int discount;
  final String discountPrice;
  final String image;
  final int stock;
  final int star;
  final String remark;
  final int categoryId;
  final int brandId;

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      shortDes: json['short_des'] ?? '',
      price: int.tryParse(json['price'].toString()) ?? 0,
      discount: json['discount'] ?? 0,
      discountPrice: json['discount_price'] ?? '0',
      image: json['image'] ?? '',
      stock: json['stock'] ?? 0,
      star: json['star'] ?? 0,
      remark: json['remark'] ?? '',
      categoryId: json['category_id'],
      brandId: json['brand_id'],
    );
  }
}