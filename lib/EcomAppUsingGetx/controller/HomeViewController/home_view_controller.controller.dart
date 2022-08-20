import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/banner_data_model.model.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/utils/toats_msg.utils.dart';
import 'package:get/get.dart';
import '../../models/categories_model.models.dart';

class HomeViewController extends GetxController {
  //create cloud firestore instance

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //create a list for banner data
  late List<BannerModelData> bannerData;

  //create a list for categories data
  late List<CategoriesModelData> categoriesData;

  //create a list for featured data
  late List<CategoriesModelData> featureData;
  bool isLoading = true;
  List<RxBool> isSelected = [];
  //fetch all data
  void getAllData() async {
    await Future.wait([
      getBannerData(),
      getCategoriesData(),
      getFeaturedData(),
    ]).then((value) {
      if (kDebugMode) {
        print("Data");
      }
      isLoading = false;
      update();
    });
  }

  void changeIndicator(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      if (isSelected[i].value) {
        isSelected[i].value = false;
      }
    }

    isSelected[index].value = true;
  }

  //get banner data
  Future<void> getBannerData() async {
    try {
      await firebaseFirestore.collection("banners").get().then((value) {
        //store data into list
        bannerData =
            value.docs.map((e) => BannerModelData.fromJson(e.data())).toList();
        for (var i = 0; i < bannerData.length; i++) {
          isSelected.add(false.obs);
        }
        isSelected[0].value = true;
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  //get categories data

  Future<void> getCategoriesData() async {
    try {
      await firebaseFirestore.collection("categories").get().then((value) {
        categoriesData = value.docs
            .map((e) => CategoriesModelData.fromJson(e.data()))
            .toList();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  //get featured Data
  Future<void> getFeaturedData() async {
    try {
      await firebaseFirestore.collection("features").get().then((value) {
        featureData = value.docs
            .map((e) => CategoriesModelData.fromJson(e.data()))
            .toList();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllData();
  }
}
