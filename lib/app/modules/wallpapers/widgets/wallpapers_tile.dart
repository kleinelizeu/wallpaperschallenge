import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:transparent_image/transparent_image.dart';

class WallpapersTile extends StatelessWidget {
  const WallpapersTile({
    Key key,
    @required this.wallpaper,
  }) : super(key: key);

  final wallpaper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed('/wallpapers/wallpaper-detail',
          arguments: wallpaper['src']['large']),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: wallpaper['src']['medium'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
