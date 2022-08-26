class ItemsModelData {
  late String id, title, image, detailsId;
  late int totalPrice, sellingPrice;

  ItemsModelData({
    required this.id,
    required this.title,
    required this.image,
    required this.totalPrice,
    required this.sellingPrice,
    required this.detailsId,
  });

  ItemsModelData.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    detailsId = map["details_id"];
    title = map["title"];
    image = map["img"];
    totalPrice = map["total_price"];
    sellingPrice = map["sell_price"];
  }
}
