import 'package:myapp/models/wallpaper_model.dart';

abstract class HomeState {}

class HomeIntialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<PhotoModel> listPhotos;
  HomeLoadedState({required this.listPhotos});
}

class HomeErrorState extends HomeState {
  String errorMessage;
  HomeErrorState({required this.errorMessage});
}
