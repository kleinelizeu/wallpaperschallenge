import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallpapers_challenge/app/app_module.dart';
import 'package:wallpapers_challenge/app/pages/splash/bloc/splash_bloc.dart';
import 'package:wallpapers_challenge/app/app_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AppModule());
  SplashBloc bloc;

  // setUp(() {
  //     bloc = AppModule.to.get<SplashBloc>();
  // });

  // group('SplashBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<SplashBloc>());
  //   });
  // });
}
