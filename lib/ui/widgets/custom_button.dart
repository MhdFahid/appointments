import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onPressed,
      required this.buttonText,
      required this.isLoading,
      this.buttonColor = const Color.fromARGB(255, 25, 98, 27),
      this.textColor});
  final void Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: buttonColor),
        child: isLoading
            ? GestureDetector(
                onTap: onPressed,
                child: Center(
                    child: Text(buttonText,
                        style: TextStyle(
                            color: textColor ?? Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              )
            : Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
