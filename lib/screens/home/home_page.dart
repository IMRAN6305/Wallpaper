import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_widgets/wallpaper_bg_widget.dart';
import 'package:myapp/constants/app_constants.dart';
import 'package:myapp/data/remote/api_helper.dart';
import 'package:myapp/data/repository/wallpaper_repo.dart';
import 'package:myapp/screens/detail_wallpaper_page.dart';
import 'package:myapp/screens/home/cubit/home_cubit.dart';
import 'package:myapp/screens/home/cubit/home_state.dart';
import 'package:myapp/screens/search/cubit/search_cubit.dart';
import 'package:myapp/screens/search/searched_wallpaper_page.dart';
import 'package:myapp/utils/utils_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchContoller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).getTrandingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ///1
          const SizedBox(
            height: 40,
          ),

          ///2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchContoller,
              style: mTextStyle12(),
              decoration: InputDecoration(
                  filled: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      if (searchContoller.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => SearchCubit(
                                          wallPaperRepository:
                                              WallpaperRepository(
                                                  apiHelper: ApiHelper())),
                                      child: SearchedWallpaperPage(
                                        query: searchContoller.text,
                                      ),
                                    )));
                      }
                    },
                    child: Icon(
                      Icons.search_sharp,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  hintText: 'Find Wallpaper',
                  hintStyle: mTextStyle12(mColor: Colors.grey.shade400),
                  fillColor: AppColors.secondaryLightColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0))),
            ),
          ),
          const SizedBox(
            height: 11,
          ),

          ///3
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Best of Month",
              style: mTextStyle16(mFontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          SizedBox(
              height: 200,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeErrorState) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else if (state is HomeLoadedState)
                    // ignore: curly_braces_in_flow_control_structures
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listPhotos.length,
                      itemBuilder: (_, index) {
                        var eachPhoto = state.listPhotos[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 11.0,
                              right: index == state.listPhotos.length - 1
                                  ? 11
                                  : 0),
                          child: InkWell(
                            onTap: (){
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailWallpaperPage(imgModel :eachPhoto.src! )));
                            },
                            child: WallpaperBgWidget(
                              imgUrl: eachPhoto.src!.portrait!,
                            ),
                          ),
                        );
                      },
                    );
                  return Container();
                },
              )),

          ///4
          const SizedBox(
            height: 7.0,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Color Tone",
              style: mTextStyle16(mFontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.mColors.length,
              itemBuilder: (_, index) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: 11.0,
                        right:
                            index == AppConstants.mColors.length - 1 ? 11 : 0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => SearchCubit(
                                            wallPaperRepository:
                                                WallpaperRepository(
                                                    apiHelper: ApiHelper())),
                                        child: SearchedWallpaperPage(
                                            query:
                                                searchContoller.text.isNotEmpty
                                                    ? searchContoller.text
                                                    : "Nature",
                                            mcolor: AppConstants.mColors[index]
                                                ['code']),
                                      )));
                        },
                        child: getColorTOneWidget(
                            AppConstants.mColors[index]['color'])));
              },
            ),
          ),

          ///5
          const SizedBox(
            height: 7.0,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Categories",
              style: mTextStyle16(mFontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 11,
                  childAspectRatio: 9 / 4),
              itemCount: AppConstants.mCategories.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => SearchCubit(
                                      wallPaperRepository: WallpaperRepository(
                                          apiHelper: ApiHelper())),
                                  child: SearchedWallpaperPage(
                                    query: AppConstants.mCategories[index]
                                        ['title'],
                                  ),
                                )));
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 11.0, right: 11.0),
                      child: getCategoryWidget(
                          AppConstants.mCategories[index]['image'],
                          AppConstants.mCategories[index]['title'])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getColorTOneWidget(Color mColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: mColor,
        borderRadius: BorderRadius.circular(11),
      ),
    );
  }

  Widget getCategoryWidget(String ImgUrl, String title) {
    return Container(
      width: 200,
      height: 50,
      child: Center(
        child: Text(
          title,
          style: mTextStyle14(mColor: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          image:
              DecorationImage(image: NetworkImage(ImgUrl), fit: BoxFit.fill)),
    );
  }
}
