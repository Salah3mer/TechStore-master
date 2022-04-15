class ProductModel {
  String id;
  String name;
  String urlImage;
  dynamic price;
  String catId;
  String desc;
  bool isFavorite;
  int quantity;

  ProductModel(
    this.id,
    this.name,
    this.urlImage,
    this.price,
    this.catId,
    this.desc,
    this.isFavorite,
    this.quantity,
  );

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlImage = json['image'];
    price = json['price'];
    catId = json['cat id'];
    desc = json['desc'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': urlImage,
      'price': price,
      'quantity': quantity,
    };
  }
}
