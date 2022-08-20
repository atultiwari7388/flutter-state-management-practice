import 'package:get/get.dart';

class IncrementCounter extends GetxController {
  var counterOne = 0.obs;
  int counterTwo = 0;

  void incrementCounterOne() {
    counterOne.value++;
  }

  void incrementCounterTwo() {
    counterTwo++;
    update();
  }

  void incrementBoth() {
    incrementCounterOne();
    incrementCounterTwo();
  }
}
//   int _counter = 0;
//
//   int get counter => _counter;
//   void get incrementCounter => _incrementCounter();
//
//   void _incrementCounter() {
//     _counter++;
//     update(["firstCounter"]);
//   }
//
//   //streams infinaltx obx
//
//   var secondCounter = 0.obs;
//
//   void secondIncrementCounter() {
//     secondCounter.value++;
//   }
//
//   void incrementBoth() {
//     _incrementCounter;
//     secondIncrementCounter();
//   }
// }
