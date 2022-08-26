import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/MyOrders/my_orders_controller.controller.dart';
import 'package:get/get.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    final controller = Get.put(MyOrdersViewController());

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: GetBuilder<MyOrdersViewController>(builder: (value) {
          if (!value.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("My Orders"),
                backgroundColor: Colors.blueAccent,
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: ListView.builder(
                  itemCount: value.model.length,
                  itemBuilder: (context, index) {
                    return listViewBuilderItems(size, value.model[index]);
                  },
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

  Widget listViewBuilderItems(Size size, MyOrdersModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(() => MyOrderDetailsScreen(
                model: model,
              ));
        },
        child: Container(
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
                      text: "${model.name}\n",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: model.status == 0
                              ? "Status : Pending"
                              : "Status : Delivered",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                model.status == 0 ? Colors.grey : Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
