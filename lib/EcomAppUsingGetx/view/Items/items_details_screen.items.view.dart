import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/ItemViewController/item_details_view.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/cart/cart_view.cart.view.dart';
import 'package:get/get.dart';

class ItemsDetailsView extends StatelessWidget {
  String id;
  ItemsDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(ItemDetailsViewController());
    controller.getItemDetails(id);

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: GetBuilder<ItemDetailsViewController>(
            init: ItemDetailsViewController(),
            builder: (value) {
              if (!controller.isLoading) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 1.0,
                    backgroundColor: Colors.blueAccent,
                    actions: [
                      IconButton(
                        onPressed: () => Get.to(() => CartView()),
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),
                    ],
                  ),
                  body: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 3.5,
                            width: size.width,
                            child: PageView.builder(
                              itemCount: controller.modelData.banners.length,
                              //onPageChanged: controller.changeIndicator,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(controller
                                            .modelData.banners[index]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // indicator

                          SizedBox(
                            height: size.height / 25,
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < controller.modelData.banners.length;
                                    i++)
                                  indicator(size, false)
                              ],
                            ),
                          ),

                          SizedBox(
                            height: size.height / 25,
                          ),

                          SizedBox(
                            width: size.width / 1.1,
                            child: Text(
                              controller.modelData.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height / 35,
                          ),

                          SizedBox(
                            width: size.width / 1.1,
                            child: RichText(
                              text: TextSpan(
                                text: "${controller.modelData.totalPrice}",
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough),
                                children: [
                                  TextSpan(
                                    text:
                                        " ${controller.modelData.sellingPrice}",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.grey[800],
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${controller.discount}% off",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.green,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height / 25,
                          ),

                          SizedBox(
                            width: size.width / 1.1,
                            child: const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height / 50,
                          ),

                          SizedBox(
                            width: size.width / 1.1,
                            child: Text(
                              controller.modelData.description,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height / 25,
                          ),

                          ListTile(
                            onTap: () {},
                            title: const Text("See Reviews"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            leading: const Icon(Icons.star),
                          ),

                          SizedBox(
                            height: size.height / 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: size.height / 14,
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: customButtom(
                            size,
                            () {
                              if (controller.isAlreadyAvailabel) {
                                Get.to(() => CartView());
                              } else {
                                controller.addItemsToCart();
                              }
                            },
                            Colors.redAccent,
                            controller.isAlreadyAvailabel
                                ? "Go to cart"
                                : "Add to cart",
                          ),
                        ),
                        Expanded(
                            child: customButtom(
                                size, () {}, Colors.white, "Buy now")),
                      ],
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

  Widget customButtom(Size size, Function function, Color color, String title) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: color == Colors.redAccent ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget indicator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.height / 80 : size.height / 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
