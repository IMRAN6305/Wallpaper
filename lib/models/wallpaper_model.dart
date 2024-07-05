class SrcModel {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;
  SrcModel(
      {required this.landscape,
      required this.large,
      required this.large2x,
      required this.medium,
      required this.original,
      required this.portrait,
      required this.small,
      required this.tiny});

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
      landscape: json['landscape'],
      large: json['large'],
      large2x: json['large2x'],
      medium: json['medium'],
      original: json['original'],
      portrait: json['portrait'],
      small: json['small'],
      tiny: json['tiny'],
    );
  }
}

class PhotoModel {
  num? id;
  num? width;
  num? height;
  String? alt;
  String? avg_color;
  String? photographer;
  String? url;
  String? photographer_url;
  bool? liked;
  SrcModel? src;
  num? photographer_id;
  PhotoModel(
      {required this.id,
      required this.width,
      required this.height,
      required this.alt,
      required this.avg_color,
      required this.photographer,
      required this.url,
      required this.photographer_url,
      required this.liked,
      required this.photographer_id,
      required this.src});
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      alt: json['alt'],
      avg_color: json['avg_color'],
      photographer: json['photographer'],
      url: json['url'],
      photographer_url: json['photographer_url'],
      liked: json['liked'],
      src: SrcModel.fromJson(json['src']),
      photographer_id: json['photographer_id'],
    );
  }
}

class WallpaperDataModel {
  num? page;
  num? per_Page;
  List<PhotoModel>? photos;
  num? totalResults;
  String? nextPage;
  WallpaperDataModel({
    this.photos,
    this.page,
    this.per_Page,
    this.totalResults,
    this.nextPage,
  });

  factory WallpaperDataModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> listPhotos = [];
    for (var item in json['photos']) {
      listPhotos.add(PhotoModel.fromJson(item));
    }
    return WallpaperDataModel(
      photos: listPhotos,
      page: json['page'],
      per_Page: json['per_page'],
      totalResults: json['total_results'],
      nextPage: json['next_page'],
    );
  }
}
