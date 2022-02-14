import 'package:dio/dio.dart';
import 'package:wallpapers_challenge/app/modules/wallpapers/pages/wallpapers_detail_screen.dart';
import 'package:wallpapers_challenge/app/repository/repository_wallpaper.dart';

import 'bloc/wallpapers_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/wallpapers_page.dart';

class WallpapersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => WallpapersBloc(repository: i.get<RepositoryWallpaper>())),
        Bind((i) => RepositoryWallpaper(dio: i.get<Dio>())),
        Bind((i) => Dio()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => WallpapersPage()),
        ModularRouter('/wallpaper-detail',
            child: (_, args) => WallpaperDetailScreen(wallpaper: args.data)),
      ];

  static Inject get to => Inject<WallpapersModule>.of();
}
