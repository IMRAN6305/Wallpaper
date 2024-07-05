import 'package:flutter/material.dart';

class WallpaperBgWidget extends StatelessWidget {
  String imgUrl;
  double mWidth;
    double mHeight;

  WallpaperBgWidget({required this.imgUrl,this.mHeight=200,this.mWidth=150});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mWidth,
      height: mHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          image:
              DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover)),
    );
  }
}
