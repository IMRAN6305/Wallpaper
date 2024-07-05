import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:myapp/models/wallpaper_model.dart';
import 'package:myapp/utils/utils_helper.dart';
import 'package:wallpaper/wallpaper.dart';

class DetailWallpaperPage extends StatelessWidget {
  SrcModel imgModel;

  DetailWallpaperPage({required this.imgModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                imgModel.portrait!,
                fit: BoxFit.cover,
              )),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getAction(
                        onTap: () {}, Title: "Info", icon: Icons.info_outline),
                    SizedBox(
                      width: 25,
                    ),
                    getAction(
                        onTap: () {
                          saveWallpaper(context);
                        },
                        Title: "Save",
                        icon: Icons.download),
                    SizedBox(
                      width: 25,
                    ),
                    getAction(
                        onTap: () {
                          applyWallpaper(context);
                        },
                        Title: "Apply",
                        icon: Icons.format_paint,
                        bgColor: Colors.blue),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getAction(
      {required VoidCallback onTap,
      required String Title,
      required IconData icon,
      Color? bgColor}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: bgColor != null
                  ? Colors.blueAccent
                  : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Center(
                child: Icon(
              icon,
              color: Colors.white,
              size: 16.0,
            )),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Text(Title, style: mTextStyle12(mColor: Colors.white))
      ],
    );
  }

  void applyWallpaper(BuildContext context) {
    Wallpaper.imageDownloadProgress(imgModel.portrait!).listen((event) {
      print(event);
    }, onDone: () {
      Wallpaper.homeScreen(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              options: RequestSizeOptions.RESIZE_FIT)
          .then(
        (value) {
          print(value);
          return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Wallpaper Applied on Home Screen")));
        },
      );
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Download Error ${error}, Error while setting the wallpaper')));
    });
  }

  void saveWallpaper(BuildContext context) {
    GallerySaver.saveImage(imgModel.portrait!).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wallpaper Saved into gallary")));
    });
  }
}
