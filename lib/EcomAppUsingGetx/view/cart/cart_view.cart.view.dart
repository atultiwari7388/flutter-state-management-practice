import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/Cart/cart_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/item_details_model.model.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/address/adress_view.address.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  final cartController = Get.put(CartViewController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: GetBuilder<CartViewController>(
            init: CartViewController(),
            builder: (value) {
              if (!cartController.isLoading) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("My Cart"),
                    elevation: 1.0,
                    backgroundColor: Colors.blueAccent,
                  ),
                  body: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: ListView.builder(
                      itemCount: cartController.productData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return cartItems(
                            size, cartController.productData[index]);
                      },
                    ),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: size.height / 12,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${value.totalPrice}",
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => AddressView()),
                            child: Container(
                              height: size.height / 18,
                              width: size.width / 2.8,
                              alignment: Alignment.center,
                              color: Colors.blueAccent,
                              child: const Text(
                                "Checkout",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget cartItems(Size size, ItemDetailsModelData model) {
    int discount =
        cartController.calculateDiscount(model.totalPrice, model.sellingPrice);

    return GestureDetector(
      onTap: () {
        // Get.to(() => ItemScreenDetails(id: model.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: Container(
          height: size.height / 3.8,
          width: size.width / 1.05,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: size.height / 8,
                  width: size.width / 1.1,
                  child: Row(
                    children: [
                      Container(
                        height: size.height / 8,
                        width: size.width / 4.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(model.img),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 22,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: RichText(
                            text: TextSpan(
                              text: "${model.title}\n",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "${model.totalPrice}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${model.sellingPrice}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: " $discount% off",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Will be Delivered in ${model.deliveryDays} days",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              ListTile(
                onTap: () {
                  cartController.removeFromCart(model.id);
                },
                title: const Text("Remove From Cart"),
                trailing: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
