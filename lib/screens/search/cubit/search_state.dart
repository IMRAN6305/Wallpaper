import 'package:myapp/models/wallpaper_model.dart';

abstract class SearchState {}

class SeaerchIntialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  List<PhotoModel> listPhotos;
  num totalWallpapers;
  SearchLoadedState({required this.listPhotos,required this.totalWallpapers});
}

class SearchErrorState extends SearchState {
  String errorMessage;
  SearchErrorState({required this.errorMessage});
}
