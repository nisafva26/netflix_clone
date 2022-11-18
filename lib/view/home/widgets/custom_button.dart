import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? text;
  IconData? icon;

  CustomButton({Key? key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,color: Colors.white,), 
        Text(text!,style: const TextStyle(color: Colors.white),)],
    );
  }
}
