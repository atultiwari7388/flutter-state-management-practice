import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/Cart/cart_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/HomeViewController/home_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/cart/cart_view.cart.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/home/category_and_featured.home.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/Items/item_screen.home.view.dart';
import 'package:get/get.dart';

import '../../models/categories_model.models.dart';

class EcomHomeView extends StatelessWidget {
  const EcomHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final homeViewController = Get.put(HomeViewController());

    return GetBuilder<HomeViewController>(builder: (value) {
      if (!value.isLoading) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ecommerce App"),
            centerTitle: true,
            elevation: 1.0,
            actions: [
              IconButton(
                  onPressed: () => Get.to(() => CartView()),
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          ),
          drawer: const CustomDrawerWidget(),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //banner section
                  SizedBox(
                    height: size.height / 3.5,
                    width: size.width,
                    child: PageView.builder(
                      onPageChanged: homeViewController.changeIndicator,
                      itemCount: homeViewController.bannerData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  homeViewController.bannerData[index].image),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //indicator
                  SizedBox(
                      height: size.height / 25,
                      width: size.width,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < homeViewController.isSelected.length;
                                i++)
                              indicator(
                                  size, homeViewController.isSelected[i].value),
                          ],
                        ),
                      )),

                  //categories
                  categoriesTile(
                    size,
                    "All Categories",
                    () => Get.to(
                      () => CategoryAndFeaturedView(
                          model: homeViewController.categoriesData),
                      transition: Transition.circularReveal,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  ),
                  listViewBuilder(size, homeViewController.categoriesData),
                  SizedBox(height: size.height / 25),
                  categoriesTile(
                    size,
                    "Featured",
                    () => Get.to(
                      () => CategoryAndFeaturedView(
                          model: homeViewController.featureData),
                      transition: Transition.circularReveal,
                      duration: const Duration(seconds: 2),
                    ),
                  ),
                  listViewBuilder(size, homeViewController.featureData),
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
    });
  }

  Widget listViewBuilder(Size size, List<CategoriesModelData> data) {
    return SizedBox(
      height: size.height / 7,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, data[index]);
        },
      ),
    );
  }

  Widget listViewBuilderItems(Size size, CategoriesModelData categories) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ItemView(
          categoryId: categories.id,
          categoryName: categories.title,
        ),
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
                height: size.height / 16,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categories.image),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Text(
                    categories.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
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

  Widget categoriesTile(Size size, String title, Function function) {
    return SizedBox(
      height: size.height / 17,
      width: size.width / 1.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () => function(),
            child: const Text("View More"),
          )
        ],
      ),
    );
  }

  Widget indicator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.height / 80 : size.height / 100,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      ),
    );
  }
}

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Name"),
            accountEmail: Text("email@gmail.com"),
            currentAccountPicture: Icon(
              Icons.account_circle,
              size: 75,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
