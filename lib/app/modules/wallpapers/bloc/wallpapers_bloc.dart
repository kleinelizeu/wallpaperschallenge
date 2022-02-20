import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wallpapers_challenge/app/repository/repository_wallpaper.dart';

class WallpapersBloc {
  final _controllerWallpaperUrl = BehaviorSubject();
  final _controllerWallpaperTrending = BehaviorSubject();
  final _controllerWallpaperNew = BehaviorSubject();
  final _controllerWallpaperPopular = BehaviorSubject();
  final _controllerSearch = BehaviorSubject();
  final RepositoryWallpaper? repository;
  WallpapersBloc({this.repository});

  Sink get wallpaperTrending => _controllerWallpaperTrending.sink;
  Sink get wallpaperNew => _controllerWallpaperNew.sink;
  Sink get wallpaperPopular => _controllerWallpaperPopular.sink;
  Sink get wallpaperSearch => _controllerSearch.sink;

  Stream get wallpaperOut => _controllerWallpaperUrl.stream;
  Stream get wallpaperTrendingOut => _controllerWallpaperTrending.stream;
  Stream get wallpaperNewOut => _controllerWallpaperNew.stream;
  Stream get wallpaperPopularOut => _controllerWallpaperPopular.stream;
  Stream get searchOut => _controllerSearch.stream;

  void fetchWallpapers([query]) async {
    repository!.getWallpapers("Trending").then(wallpaperTrending.add);
    repository!.getWallpapers("New").then(wallpaperNew.add);
    repository!.getWallpapers("Popular").then(wallpaperPopular.add);
    repository!.getWallpapers(query).then(wallpaperSearch.add);
  }

  void download(wallpaper) async {
    repository!.wallpaperDownload(wallpaper);
  }

  void dispose() {
    _controllerWallpaperUrl.close();
    _controllerWallpaperTrending.close();
    _controllerWallpaperNew.close();
    _controllerWallpaperPopular.close();
    _controllerSearch.close();
  }
}
