import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../details_screen.dart';

class CustomSliverToolBar extends StatelessWidget {
  final String? text;
 final String? tag;
  const CustomSliverToolBar({Key? key,this.text,this.tag}) : super(key: key);

  @override


  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            BackButton(),
            Text(text!,style: const TextStyle(fontWeight: FontWeight.w900),),
            const Spacer(),
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const Icon(
              Icons.cast,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: tag.toString(),
              // flightShuttleBuilder: _flightShuttleBuilder,
              child: Material(
                type: MaterialType.transparency,
                child: ToolBartext(text!),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row ToolBartext(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w900),
        ),
        const Icon(Icons.keyboard_arrow_down,color: Colors.white,)
      ],
    );
  }
}
