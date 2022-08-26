import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/item_details_model.model.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/utils/toats_msg.utils.dart';
import 'package:get/get.dart';

class CartViewController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List productIds = [];
  List<ItemDetailsModelData> productData = [];
  bool isLoading = true;
  int totalPrice = 0, totalDiscount = 0, totalSellingPrice = 0;

  Future<void> getCartItems() async {
    productData = [];
    productIds = [];
    try {
      await firebaseFirestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("cart")
          .get()
          .then((value) {
        productIds = value.docs.map((e) => e.data()["id"]).toList();
        getProductDetails();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  Future<void> getProductDetails() async {
    for (var item in productIds) {
      try {
        //
        await firebaseFirestore
            .collection("products")
            .doc(item)
            .get()
            .then((value) {
          //
          productData.add(ItemDetailsModelData.fromJson(value.data()!));
        });
      } catch (e) {
        showAlert("Something went wrong $e");
      }
    }
    calculatePrice();
    isLoading = false;
    update();
  }

  Future<void> removeFromCart(String id) async {
    isLoading = true;
    update();
    try {
      await firebaseFirestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("cart")
          .doc(id)
          .delete()
          .then((value) {
        getCartItems();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }

  void calculatePrice() {
    for (var item in productData) {
      totalPrice = totalPrice + item.totalPrice;
      totalSellingPrice = totalSellingPrice + item.sellingPrice;
    }

    totalDiscount = totalPrice - totalSellingPrice;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartItems();
  }
}
