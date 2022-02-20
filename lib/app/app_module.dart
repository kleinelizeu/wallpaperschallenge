import 'package:wallpapers_challenge/app/pages/splash/splash_page.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers_challenge/app/app_widget.dart';

import 'modules/wallpapers/wallpapers_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SplashPage()),
        ModuleRoute('/wallpapers/', module: WallpapersModule()),
      ];
}
