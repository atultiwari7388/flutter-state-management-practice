import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/items_model.model.dart';
import 'package:get/get.dart';
import '../../utils/toats_msg.utils.dart';

class ItemViewController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();

  String categoryId = "";
  String categoryCollectionName = "";
  List<ItemsModelData> itemsData = [];
  List<ItemsModelData> searchResults = [];
  bool isLoading = true;
  bool isSearchLoading = false;
  bool hasMoreData = true;
  var isLoading1 = false.obs;

  DocumentSnapshot? lastDocument;
  int documentLimit = 7;

  Future<void> getSubCategoryData() async {
    try {
      await firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryCollectionName)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsModelData.fromJson(e.data())).toList();
        isLoading = false;
        update();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  void getPaginedData() async {
    if (hasMoreData) {
      if (!isLoading1.value) {
        await getSubCategoryDataInParts();
      }
    } else {
      showAlert("No more data");
    }
  }

  Future<void> getSubCategoryDataInParts() async {
    if (lastDocument == null) {
      await firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryCollectionName)
          .orderBy("title")
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(
          value.docs.map(
            (e) => ItemsModelData.fromJson(e.data()),
          ),
        );
        isLoading = false;
        update();
        lastDocument = value.docs.last;

        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
    } else {
      isLoading1.value = true;
      await firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryCollectionName)
          .orderBy("title")
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData
            .addAll(value.docs.map((e) => ItemsModelData.fromJson(e.data())));
        isLoading1.value = false;
        update();
        lastDocument = value.docs.last;

        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }

  Future<void> searchProducts(String query) async {
    isSearchLoading = true;
    Future.delayed(Duration.zero, () {
      update();
    });
    try {
      await firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryCollectionName)
          .where("title", isGreaterThanOrEqualTo: query)
          .get()
          .then((value) {
        searchResults =
            value.docs.map((e) => ItemsModelData.fromJson(e.data())).toList();
        isSearchLoading = false;
        update();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double currentPosition = scrollController.position.pixels;
      double height20 = Get.size.height * 0.20;

      if (maxScrollExtent - currentPosition <= height20) {
        getPaginedData();
      }
    });
  }
}
