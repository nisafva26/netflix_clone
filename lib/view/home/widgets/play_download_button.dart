import 'package:flutter/material.dart';

class PlayDownloadButton extends StatelessWidget {
  final String? text;
  final IconData? data;
  const PlayDownloadButton({Key? key,this.text,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children:  [
          Icon(
            data!,
            color: Colors.black,
          ),
          Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          )
        ]),
      ),
    );
  }
}
