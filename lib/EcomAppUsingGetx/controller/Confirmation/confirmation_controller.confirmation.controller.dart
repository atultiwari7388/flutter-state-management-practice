import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/Address/address_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/Cart/cart_view_controller.controller.dart';
import 'package:get/get.dart';

class ConfirmationViewController extends GetxController {
  final addressScreenController = Get.find<AddressViewController>();
  final cartScreenController = Get.find<CartViewController>();

  String name = "", address = "", pinCode = "";
  int totalPrice = 0, totalDiscountPrice = 0, payablePrice = 0;

  void initializedData() {
    name = addressScreenController.fullName;
    address = addressScreenController.address;
    pinCode = addressScreenController.pinCode;

    totalPrice = cartScreenController.totalPrice;
    totalDiscountPrice = cartScreenController.totalDiscount;
    payablePrice = cartScreenController.totalSellingPrice;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializedData();
  }
}
