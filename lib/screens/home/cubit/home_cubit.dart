import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repository/wallpaper_repo.dart';
import 'package:myapp/models/wallpaper_model.dart';
import 'package:myapp/screens/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  WallpaperRepository wallpaperRepository;
  HomeCubit({required this.wallpaperRepository}) : super(HomeIntialState());

  void getTrandingWallpapers() async {
    emit(HomeLoadingState());
    try {
      var data = await wallpaperRepository.getTrandingWallPaper();
      var wallpaperModel = WallpaperDataModel.fromJson(data);
      emit(HomeLoadedState(listPhotos: wallpaperModel.photos!));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
