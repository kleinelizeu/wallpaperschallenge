import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallpapers_challenge/app/modules/wallpapers/bloc/wallpapers_bloc.dart';
import 'package:wallpapers_challenge/app/modules/wallpapers/widgets/wallpapers_tile.dart';
import 'package:wallpapers_challenge/app/shared/utils/constants.dart';

class WallpapersPage extends StatefulWidget {
  @override
  _WallpapersPageState createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;
  final _controller = Modular.get<WallpapersBloc>();

  @override
  void initState() {
    _controller.fetchWallpapers();
    _tabController = new TabController(
      vsync: this,
      initialIndex: 0,
      length: _searchController.text.isEmpty ? 3 : 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondaryBlue,
      appBar: _appBar(h, w) as PreferredSizeWidget?,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            new TabBar(
              indicatorColor: Colors.transparent,
              labelColor: gray,
              isScrollable: true,
              controller: _tabController,
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                new Tab(text: "TRENDING"),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.13,
                  ),
                  child: new Tab(text: "NEW"),
                ),
                new Tab(text: "POPULAR"),
              ],
            ),
            Expanded(
              child: _searchController.text.isNotEmpty
                  ? wallpaperGrid(_controller.searchOut)
                  : TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        wallpaperGrid(_controller.wallpaperTrendingOut),
                        wallpaperGrid(_controller.wallpaperNewOut),
                        wallpaperGrid(_controller.wallpaperPopularOut),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar(h, w) {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryBlue,
      toolbarHeight: h * 0.25,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallpaper",
                style: TextStyle(
                  color: gray,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  fontSize: w * 0.08,
                ),
              ),
              Icon(Icons.menu, color: gray),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: gray),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: secondaryBlue,
                  prefixIcon: Icon(
                    Icons.search,
                    color: gray,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: gray)),
              onSubmitted: (value) {
                if (_searchController.text.isNotEmpty) {
                  _controller.fetchWallpapers(value);
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget wallpaperGrid(var _controller) {
    return StreamBuilder(
        stream: _controller,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ocorreu um erro',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Container(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            dynamic wallpaper = snapshot.data;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  crossAxisCount: 2,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: wallpaper['photos'].length,
                itemBuilder: (context, index) {
                  return WallpapersTile(wallpaper: wallpaper['photos'][index]);
                });
          }
        });
  }
}
