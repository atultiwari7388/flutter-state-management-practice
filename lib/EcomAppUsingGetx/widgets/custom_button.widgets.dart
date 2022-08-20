import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.borderRadius,
    required this.function,
    required this.buttonWidth,
  }) : super(key: key);

  final String text;
  final BorderRadius? borderRadius;
  final Function function;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => function(),
      child: Material(
        elevation: 5,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: const Color.fromRGBO(30, 62, 160, 1),
        child: SizedBox(
          height: size.height / 17,
          width: size.width / buttonWidth,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
