import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/controller/AuthViewController/login_view_controller.controller.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/widgets/custom_button.widgets.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final loginController = Get.put(LoginViewController());

    return Scaffold(
      body: GetBuilder<LoginViewController>(
          init: LoginViewController(),
          builder: (value) {
            if (!value.isLoading) {
              return SafeArea(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //top section
                        Material(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(120),
                          ),
                          color: const Color.fromRGBO(230, 233, 250, 1),
                          child: SizedBox(
                            height: size.height / 2,
                            width: size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height / 10,
                                ),
                                Text(
                                  "E-commerce",
                                  style: TextStyle(
                                    letterSpacing: 1.2,
                                    fontSize: size.width / 10,
                                    color: const Color.fromRGBO(9, 32, 132, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: size.height / 60),
                                Text(
                                  "It's all easy when it's at home",
                                  style: TextStyle(
                                    fontSize: size.width / 21,
                                    color:
                                        const Color.fromRGBO(90, 106, 165, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: size.height / 9),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: size.height / 10,
                                        width: size.width / 150,
                                        color:
                                            const Color.fromRGBO(9, 32, 196, 1),
                                      ),
                                      SizedBox(width: size.width / 40),
                                      RichText(
                                        text: TextSpan(
                                          text: "Welcome\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: size.width / 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Enter the details to login / Signup.",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    138, 132, 134, 1),
                                                fontSize: size.width / 22,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //phone number field
                        SizedBox(height: size.height / 15),
                        Container(
                          height: size.height / 15,
                          width: size.width / 1.2,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(9, 32, 196, 1),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: loginController.phoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              counterText: "",
                            ),
                          ),
                        ),
                        SizedBox(height: size.height / 10),
                        CustomButton(
                          text: "Login/Signup",
                          borderRadius: BorderRadius.circular(10),
                          function: () {
                            loginController.verifyPhoneNumber();
                          },
                          buttonWidth: 2,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
