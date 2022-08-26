class ItemDetailsModelData {
  late String id, title, img, deliveryDays, description;
  late List banners;
  late int sellingPrice, totalPrice;

  ItemDetailsModelData(
      {required this.id,
      required this.title,
      required this.img,
      required this.deliveryDays,
      required this.description,
      required this.banners,
      required this.sellingPrice,
      required this.totalPrice});

  ItemDetailsModelData.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map["title"];
    img = map["img"];
    deliveryDays = map["delivery_days"];
    description = map["desc"];
    banners = map["banners"];
    sellingPrice = map["sell_price"];
    totalPrice = map["total_price"];
  }
}
