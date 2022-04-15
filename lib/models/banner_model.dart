class BannerModel{

  String id;
  String urlImage;

  BannerModel(
      this.id,
      this.urlImage
      );

  BannerModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    urlImage=json['image'];
  }
}