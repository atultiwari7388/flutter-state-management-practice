import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/Items/item_screen.home.view.dart';
import 'package:get/get.dart';

import '../../models/categories_model.models.dart';

class CategoryAndFeaturedView extends StatelessWidget {
  CategoryAndFeaturedView({Key? key, required this.model}) : super(key: key);

  List<CategoriesModelData> model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Categories"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: model.length,
              itemBuilder: (context, index) {
                return gridViewBuilderItems(Get.size, model[index]);
              }),
        ),
      ),
    );
  }

  Widget gridViewBuilderItems(Size size, CategoriesModelData categories) {
    return GestureDetector(
      onTap: () => Get.to(
        () =>
            ItemView(categoryId: categories.id, categoryName: categories.title),
        transition: Transition.circularReveal,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: size.height / 7,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categories.image),
                  ),
                ),
              ),
              SizedBox(height: size.height / 30),
              Expanded(
                child: SizedBox(
                  child: Text(
                    categories.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
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
