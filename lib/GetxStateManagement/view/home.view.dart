import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/GetxStateManagement/controller/counter_controller.controller.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countController = Get.put(IncrementCounter());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Getx Controller and GetxBuilder"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnotherWidget(),
            const Text("You have pushed  the button this many times"),
            const SizedBox(height: 30),

            MixinBuilder<IncrementCounter>(
                init: IncrementCounter(),
                builder: (value) {
                  return Text(
                      "${value.counterOne.value}  AND ${value.counterTwo}");
                }),

            //using getBuilder
            // GetBuilder<IncrementCounter>(
            //     id: "firstCounter",
            //     init: IncrementCounter(),
            //     builder: (value) {
            //       return Text(
            //         "${value.counter}",
            //         style: const TextStyle(color: Colors.black),
            //       );
            //     }),
            //
            // //using Getx
            //
            // GetX<IncrementCounter>(builder: (value) {
            //   return Text(
            //     "${value.secondCounter.value}",
            //     style: const TextStyle(color: Colors.black),
            //   );
            // }),
            //
            // //using obx
            //
            // Obx(() => Text(
            //       "${countController.secondCounter.value}",
            //       style: const TextStyle(color: Colors.black),
            //     )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // countController.incrementCounter;
          // countController.secondIncrementCounter;
          countController.incrementBoth();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnotherWidget extends StatelessWidget {
  const AnotherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IncrementCounter countController = Get.find();
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Obx(() => Text(
            "${countController.counterOne.value}",
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
