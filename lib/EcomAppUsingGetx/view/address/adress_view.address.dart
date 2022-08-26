import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/Address/address_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/Confirmation/confirmation_view.confirmation.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressViewController>(
      init: AddressViewController(),
      builder: (value) {
        if (value.isAddressAvailabel) {
          return EditAddressView();
        } else {
          return AddAddressView();
        }
      },
    );
  }
}

class AddAddressView extends StatelessWidget {
  AddAddressView({Key? key}) : super(key: key);

  final addAddressController = Get.find<AddressViewController>();

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Text("Address"),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 30,
                ),
                SizedBox(
                  height: size.height / 10,
                  width: size.width / 1.1,
                  child: TextField(
                    controller: addAddressController.nameController,
                    maxLength: 15,
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                SizedBox(
                  height: size.height / 5,
                  width: size.width / 1.1,
                  child: TextField(
                    controller: addAddressController.addressController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                SizedBox(
                  height: size.height / 10,
                  width: size.width / 1.1,
                  child: TextField(
                    controller: addAddressController.pinCodeController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      hintText: "PinCode",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              addAddressController.onTap();
            },
            child: Container(
              height: size.height / 12,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditAddressView extends StatelessWidget {
  EditAddressView({Key? key}) : super(key: key);

  final editViewController = Get.find<AddressViewController>();

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Text("Address"),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 30,
                ),
                addressCard(size),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              Get.to(() => ConfirmationView());
            },
            child: Container(
              height: size.height / 12,
              width: size.width / 1.2,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: const Text(
                "Proceed",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressCard(Size size) {
    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        width: size.width / 1.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editViewController.fullName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                editViewController.address,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              editViewController.pinCode,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            GestureDetector(
              onTap: () {
                editViewController.onEdit();
              },
              child: Container(
                height: size.height / 18,
                width: size.width / 1.2,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
