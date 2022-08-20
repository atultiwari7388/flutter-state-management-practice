class BannerModelData {
  late String image;
  BannerModelData({required this.image});
  BannerModelData.fromJson(Map<String, dynamic> map) {
    image = map["img"];
  }
}
