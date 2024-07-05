import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_widgets/wallpaper_bg_widget.dart';
import 'package:myapp/models/wallpaper_model.dart';
import 'package:myapp/screens/detail_wallpaper_page.dart';
import 'package:myapp/screens/search/cubit/search_cubit.dart';
import 'package:myapp/screens/search/cubit/search_state.dart';
import 'package:myapp/utils/utils_helper.dart';

class SearchedWallpaperPage extends StatefulWidget {
  String query;
  String mcolor;
  SearchedWallpaperPage({required this.query, this.mcolor = ""});

  @override
  State<SearchedWallpaperPage> createState() => _SearchedWallpaperPageState();
}

class _SearchedWallpaperPageState extends State<SearchedWallpaperPage> {
  ScrollController? scrollController;
  num totalWallpapersCount = 0;
  int totalNoPages = 1;
  int pageCount = 1;
  List<PhotoModel> allWallpapers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(
      () {
        if (scrollController!.position.pixels ==
            scrollController!.position.maxScrollExtent) {
          totalNoPages = totalWallpapersCount ~/ 15 + 1;
          if (totalNoPages > pageCount) {
            print("End of the scrool");

            pageCount++;
            BlocProvider.of<SearchCubit>(context).getSearchWallPaper(
              query: widget.query,
              color: widget.mcolor,
              page: pageCount,
            );
          } else {
            print("You are reached the end of this category wallpapers!!");
          }
        }
      },
    );
    BlocProvider.of<SearchCubit>(context)
        .getSearchWallPaper(query: widget.query, color: widget.mcolor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        body: BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      pageCount != 1 ? "Next page loading" : "Loading....")));
            } else if (state is SearchErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is SearchLoadedState) {
              totalWallpapersCount = state.totalWallpapers;
              allWallpapers.addAll(state.listPhotos);
              setState(() {});
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  widget.query,
                  style: mTextStyle34(
                    mFontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "${totalWallpapersCount} wallpaper available",
                  style: mTextStyle14(),
                ),
                SizedBox(
                  height: 21.0,
                ),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 11,
                            mainAxisSpacing: 11,
                            childAspectRatio: 3 / 4),
                    itemCount: allWallpapers.length,
                    itemBuilder: (_, index) {
                      var eachPhoto = allWallpapers[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                index == allWallpapers.length - 1 ? 11.0 : 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailWallpaperPage(imgModel :eachPhoto.src! )));
                            },
                            child: WallpaperBgWidget(
                                imgUrl: eachPhoto.src!.portrait!)),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}



// NotificationListener<ScrollNotification>(
//                     onNotification:(ScrollNotification notification){
//                       if(notification.metrics.pixels == notification.metrics.maxScrollExtent){}
// it is scrool the max 
//                       if(notification.metrics.pixels == notification.metrics.extenBefore){}
// it is scrool tell almost end
//                       if(notification.metrics.pixels == notification.metrics.extentAfter){}
// it is scrol end of the scrool
// if(notification is ScrollStartNotification){}
//is scrool end of start scrool
// if(notification is ScrollEndNotification){}
//is scrool end of the scrool
// return false;
//                     }
//                     child:  Container()






//  BlocBuilder<SearchCubit, SearchState>(
//           builder: (context, state) {
//             if (state is SearchLoadingState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is SearchErrorState) {
//               return Center(
//                 child: Text(state.errorMessage),
//               );
//             } else if (state is SearchLoadedState) {
//               totalWallpapersCount = state.totalWallpapers;
//               allWallpapers.addAll(state.listPhotos);
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 27.0),
//                 child: ListView(
//                   controller: scrollController,
//                   children: [
//                     const SizedBox(
//                       height: 24,
//                     ),
//                     Text(
//                       widget.query,
//                       style: mTextStyle34(
//                         mFontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     Text(
//                       "${state.totalWallpapers} wallpaper available",
//                       style: mTextStyle14(),
//                     ),
//                     SizedBox(
//                       height: 21.0,
//                     ),
//                     Container(
//                       // padding: EdgeInsets.symmetric(horizontal: 5.0),
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 11,
//                                 mainAxisSpacing: 11,
//                                 childAspectRatio: 3 / 4),
//                         itemCount:allWallpapers.length,
//                         itemBuilder: (_, index) {
//                           var eachPhoto =allWallpapers[index];
//                           return Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: index == allWallpapers.length - 1
//                                     ? 11.0
//                                     : 0),
//                             child: WallpaperBgWidget(
//                                 imgUrl: eachPhoto.src!.portrait!),
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             }
//             return Container();
//           },
//         ));