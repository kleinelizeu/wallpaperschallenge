import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpapers_challenge/app/modules/wallpapers/exceptions/dio_exceptions.dart';
import 'package:wallpapers_challenge/app/modules/wallpapers/widgets/wallpapers_error_dialog.dart';
import 'package:wallpapers_challenge/app/shared/utils/constants.dart';

class RepositoryWallpaper {
  final Dio? dio;

  RepositoryWallpaper({this.dio});

  Future getWallpapers(query, [BuildContext? ctx]) async {
    try {
      var response = await dio!.get(URL + '$query',
          options: Options(
            headers: {'Authorization': API_KEY},
          ));

      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // wallpapersErrorDialog(ctx, errorMessage);
      print(errorMessage);
    }
  }

  Future wallpaperDownload(String wallpaper) async {
    try {
      var response = await dio!.get(
        wallpaper,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {'Authorization': API_KEY},
        ),
      );

      await [Permission.storage].request();
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: Random().nextInt(300).toString(),
      );
      print(result);
    } catch (e) {
      print(e);
      throw Exception("Erro ao tentar salvar img");
    }
  }
}
