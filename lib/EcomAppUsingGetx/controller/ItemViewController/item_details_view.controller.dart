import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/item_details_model.model.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/utils/toats_msg.utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ItemDetailsViewController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ItemDetailsModelData modelData;
  bool isLoading = true, isAlreadyAvailabel = false;
  int discount = 0;

  Future<void> getItemDetails(String id) async {
    try {
      await firebaseFirestore
          .collection("products")
          .doc(id)
          .get()
          .then((value) {
        modelData = ItemDetailsModelData.fromJson(value.data()!);
        discount =
            calculateDiscount(modelData.totalPrice, modelData.sellingPrice);
        checkIfAlreadyInCart();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  Future<void> checkIfAlreadyInCart() async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("cart")
          .where("id", isEqualTo: modelData.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isAlreadyAvailabel = true;
        }
        isLoading = false;
        update();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  Future<void> addItemsToCart() async {
    isLoading = true;
    update();
    try {
      await firebaseFirestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("cart")
          .doc(modelData.id)
          .set(({
            "id": modelData.id,
          }))
          .then((value) {
        checkIfAlreadyInCart();
      });
    } catch (e) {
      showAlert("Something went wrong $e");
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }
}
