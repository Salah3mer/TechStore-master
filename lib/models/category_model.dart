class CategoryModel{
  String id;
  String name;
  String urlImage;

  CategoryModel(
      this.id,
      this.name,
      this.urlImage
      );

  CategoryModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    urlImage=json['image'];
  }
}