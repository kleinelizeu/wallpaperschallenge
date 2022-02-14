import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wallpapers_challenge/app/modules/wallpapers/bloc/wallpapers_bloc.dart';
import 'package:wallpapers_challenge/app/shared/utils/constants.dart';

class WallpaperDetailScreen extends StatelessWidget {
  final _homeController = Modular.get<WallpapersBloc>();
  final wallpaper;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  WallpaperDetailScreen({
    Key key,
    @required this.wallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              wallpaper,
              fit: BoxFit.cover,
            ),
          ),
          _appBar(context),
          _bottomWidget(h, w),
        ],
      ),
    );
  }

  Widget _appBar(context) {
    return Container(
      margin: EdgeInsets.only(top: 60, left: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: gray,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget(h, w) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h * 0.13,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  try {
                    _homeController.download(wallpaper);
                    _onSucess();
                  } catch (e) {}
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: h * 0.07,
                  width: w * 0.6,
                  child: Center(
                    child: Text(
                      "DOWNLOAD",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: gray,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.favorite,
                color: gray,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Imagem salva na galeria!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
      ),
    );
  }
}
