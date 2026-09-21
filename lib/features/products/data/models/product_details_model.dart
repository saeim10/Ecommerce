class ProductDetailsModel {
  final int? id;
  final String? img1;
  final String? img2;
  final String? img3;
  final String? img4;
  final String? des;
  final List<String> color;
  final List<String> size;
  final int? productId;
  final Product? product;

  ProductDetailsModel({
    this.id,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.des,
    this.color = const [],
    this.size = const [],
    this.productId,
    this.product,
  });

  factory ProductDetailsModel.fromJson(
      Map<String, dynamic> json) {

    final String colorString =
        json['color']?.toString() ?? '';

    final String sizeString =
        json['size']?.toString() ?? '';

    return ProductDetailsModel(
      id: json['id'],
      img1: json['img1'],
      img2: json['img2'],
      img3: json['img3'],
      img4: json['img4'],
      des: json['des'],

      color: colorString.isNotEmpty
          ? colorString
          .split(',')
          .map((e) => e.trim())
          .toList()
          : [],

      size: sizeString.isNotEmpty
          ? sizeString
          .split(',')
          .map((e) => e.trim())
          .toList()
          : [],

      productId: json['product_id'],

      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }
}


class Product {
  final int? id;
  final String? title;
  final String? shortDes;
  final String? price;
  final int? discount;
  final String? discountPrice;
  final String? image;
  final int? stock;
  final int? star;
  final String? remark;
  final int? categoryId;
  final int? brandId;

  Product({
    this.id,
    this.title,
    this.shortDes,
    this.price,
    this.discount,
    this.discountPrice,
    this.image,
    this.stock,
    this.star,
    this.remark,
    this.categoryId,
    this.brandId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
    );
  }
}