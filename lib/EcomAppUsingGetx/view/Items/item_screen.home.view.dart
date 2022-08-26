import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/ItemViewController/item_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/models/items_model.model.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/Items/items_details_screen.items.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/search/search_view.search.view.dart';
import 'package:get/get.dart';

class ItemView extends StatelessWidget {
  ItemView({Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);
  String categoryId, categoryName;
  final itemController = Get.put(ItemViewController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    itemController.categoryId = categoryId;
    itemController.categoryCollectionName = categoryName;

    itemController.getPaginedData();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        elevation: 1.0,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: size.height / 40),
            searchBar(size, context),
            Expanded(
              child: SizedBox(
                child: GetBuilder<ItemViewController>(
                  init: ItemViewController(),
                  builder: (value) {
                    if (!value.isLoading) {
                      return ListView.builder(
                        controller: itemController.scrollController,
                        itemCount: value.itemsData.length,
                        itemBuilder: (context, index) {
                          return listViewBuilderItems(
                              size, value.itemsData[index]);
                          // return Text("data");
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Obx(() {
              if (itemController.isLoading1.value) {
                return Container(
                  height: size.height / 10,
                  width: size.width,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }

  Widget listViewBuilderItems(Size size, ItemsModelData model) {
    int discount =
        itemController.calculateDiscount(model.totalPrice, model.sellingPrice);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () => Get.to(() => ItemsDetailsView(id: model.detailsId)),
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

  Widget searchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchView());
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        child: Container(
          height: size.height / 14,
          width: size.width / 1.1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Search Here...",
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.search,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
