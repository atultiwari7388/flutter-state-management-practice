class CategoriesModelData {
  late String image, id, title;

  CategoriesModelData(
      {required this.image, required this.id, required this.title});

  CategoriesModelData.fromJson(Map<String, dynamic> map) {
    image = map["img"];
    id = map["id"];
    title = map["title"];
  }
}
