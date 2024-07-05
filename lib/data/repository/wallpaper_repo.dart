import 'package:myapp/data/remote/api_helper.dart';
import 'package:myapp/data/remote/urls.dart';

class WallpaperRepository {
  ApiHelper apiHelper;

  //tranding wallpapers
  WallpaperRepository({required this.apiHelper});
  Future<dynamic> getTrandingWallPaper() async {
    try {
      return await apiHelper.getApi(url: AppUrls.TRENDING_WALL_Url);
    } catch (e) {
      throw (e);
    }
  }

  //search wallpapers
    Future<dynamic> getSearchWallPaper(String mQuery,{String color = "",int page = 1}) async {
    try {
      return await apiHelper.getApi(url: "${AppUrls.SEARCH_Url}?query=$mQuery&color=$color&page=$page ");
    } catch (e) {
      throw (e);
    }
  }
}
