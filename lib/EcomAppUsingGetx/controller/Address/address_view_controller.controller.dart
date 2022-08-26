import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressViewController extends GetxController {
  late SharedPreferences sharedPreferences;
  String fullName = "", address = "", pinCode = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool isAddressAvailabel = false;

  Future<void> getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String addressName = getStringKey("address");

    if (addressName.isNotEmpty) {
      isAddressAvailabel = true;
    } else {
      isAddressAvailabel = false;
    }
    initializeInfo();
    update();
  }

  //edit address
  void onEdit() async {
    isAddressAvailabel = false;
    update();

    await sharedPreferences.clear();
  }

  //save user address to sharedPref
  void onTap() async {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty) {
      await saveStringKey("name", nameController.text);
      await saveStringKey("address", addressController.text);
      await saveStringKey("pinCode", pinCodeController.text);
      getInstance();
    } else {
      Get.snackbar(
        "Ohh No !",
        "All fields are required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> saveStringKey(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  //get user data using sharedPref
  String getStringKey(String key) => sharedPreferences.getString(key) ?? "";

  //get userData using sharedPref key
  void initializeInfo() {
    fullName = getStringKey("name");
    address = getStringKey("address");
    pinCode = getStringKey("pinCode");
  }

  //initialize getInstance func
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInstance();
  }
}
