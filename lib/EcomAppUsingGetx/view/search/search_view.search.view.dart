import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/HomeViewController/home_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/ItemViewController/item_view_controller.controller.dart';
import 'package:get/get.dart';

import '../../models/items_model.model.dart';

class SearchView extends SearchDelegate {
  ItemViewController itemViewController = Get.find();
  final Size size = Get.size;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    itemViewController.searchProducts(query);

    return GetBuilder<ItemViewController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.itemsData.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(size, value.itemsData[index]);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    itemViewController.searchProducts(query);
    return ListView.builder(
      itemCount: itemViewController.itemsData.length,
      itemBuilder: (context, index) {
        return listViewBuilderItems(size, itemViewController.itemsData[index]);
        // return Text("data");
      },
    );
  }

  Widget listViewBuilderItems(Size size, ItemsModelData model) {
    int discount = itemViewController.calculateDiscount(
        model.totalPrice, model.sellingPrice);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () {},
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
                    image: NetworkImage(model.image),
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
                          text: "  $discount % off",
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
    );
  }
}
