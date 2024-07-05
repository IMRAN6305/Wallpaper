import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repository/wallpaper_repo.dart';
import 'package:myapp/models/wallpaper_model.dart';
import 'package:myapp/screens/search/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  WallpaperRepository wallPaperRepository;

  SearchCubit({required this.wallPaperRepository})
      : super(SeaerchIntialState());

  void getSearchWallPaper({required String query,String color= "",int page = 1}) async {
    emit(SearchLoadingState());
    try {
      var mdata = await wallPaperRepository.getSearchWallPaper(query,color: color,page : page);
      WallpaperDataModel wallpaperDataModel =
          WallpaperDataModel.fromJson(mdata);

      emit(SearchLoadedState(listPhotos: wallpaperDataModel.photos!,totalWallpapers: wallpaperDataModel.totalResults!));
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
