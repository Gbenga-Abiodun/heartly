import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;

  final String? fontFamily;

  final FontWeight? fontWeight;

  final TextAlign? textAlign;

  double size;

  BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF000000),
    this.fontWeight = FontWeight.w200,
    this.size = 0,
    this.fontFamily = "blackBerry", this.textAlign ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      // maxLines: 1,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontSize: size == 0 ? Dimensions.font18 : size,
      ),
    );
  }
}
