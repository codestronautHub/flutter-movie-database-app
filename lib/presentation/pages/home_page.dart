import 'package:about/about.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/main_movie_page.dart';
import 'package:ditonton/presentation/pages/main_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _drawerAnimationController;
  late Animation _drawerTween;

  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _drawerTween = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOutCirc,
      ),
    );

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 0),
    );
    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withOpacity(0.7),
    ).animate(_colorAnimationController);
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  void toggle() => _drawerAnimationController.isDismissed
      ? _drawerAnimationController.forward()
      : _drawerAnimationController.reverse();

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSpaceGrey,
      child: AnimatedBuilder(
        animation: _drawerTween,
        builder: (context, child) {
          double slide = 300.0 * _drawerTween.value;
          double scale = 1.0 - (_drawerTween.value * 0.25);
          double radius = _drawerTween.value * 30.0;
          double rotate = _drawerTween.value * -0.139626;
          double toolbarOpacity = 1.0 - _drawerTween.value;

          return Stack(
            children: [
              Container(
                width: 220.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        key: Key('closeDrawerButton'),
                        onTap: toggle,
                        child: CircleAvatar(
                          child: Icon(Icons.close, color: kRichBlack),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 128.0),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: AssetImage('assets/user.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aditya',
                                  style: kHeading6.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  'aditya@mail.co',
                                  style: kBodyText.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Consumer<HomeNotifier>(builder: (context, data, child) {
                        return Column(
                          children: [
                            ListTile(
                              key: Key('movieListTile'),
                              onTap: () {
                                Provider.of<HomeNotifier>(context,
                                        listen: false)
                                    .setState(MdbContentType.Movie);
                                toggle();
                              },
                              leading: Icon(Icons.movie),
                              title: Text('Movies'),
                              selected: data.state == MdbContentType.Movie,
                              style: ListTileStyle.drawer,
                              iconColor: Colors.white70,
                              textColor: Colors.white70,
                              selectedColor: Colors.white,
                              selectedTileColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            ListTile(
                              key: Key('tvListTile'),
                              onTap: () {
                                Provider.of<HomeNotifier>(context,
                                        listen: false)
                                    .setState(MdbContentType.Tv);
                                toggle();
                              },
                              leading: Icon(Icons.tv),
                              title: Text('Tv Show'),
                              selected: data.state == MdbContentType.Tv,
                              style: ListTileStyle.drawer,
                              iconColor: Colors.white70,
                              textColor: Colors.white70,
                              selectedColor: Colors.white,
                              selectedTileColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        );
                      }),
                      ListTile(
                        key: Key('watchlistListTile'),
                        onTap: () {
                          Navigator.pushNamed(
                              context, WatchlistPage.ROUTE_NAME);
                        },
                        leading: Icon(Icons.save_alt),
                        title: Text('Watchlist'),
                        iconColor: Colors.white70,
                        textColor: Colors.white70,
                      ),
                      ListTile(
                        key: Key('aboutListTile'),
                        onTap: () {
                          Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                        },
                        leading: Icon(Icons.info_outline),
                        title: Text('About'),
                        iconColor: Colors.white70,
                        textColor: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale)
                  ..rotateZ(rotate),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: AnimatedBuilder(
                    animation: _colorAnimationController,
                    builder: (context, child) {
                      return Scaffold(
                        extendBodyBehindAppBar: true,
                        appBar: AppBar(
                          toolbarOpacity: toolbarOpacity,
                          leading: IconButton(
                            key: Key('drawerButton'),
                            icon: Icon(Icons.menu),
                            splashRadius: 20.0,
                            onPressed: toggle,
                          ),
                          title: Text(
                            'MDB',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          actions: [
                            IconButton(
                              key: Key('searchButton'),
                              icon: Icon(Icons.search),
                              splashRadius: 20.0,
                              onPressed: () => Navigator.pushNamed(
                                context,
                                SearchPage.ROUTE_NAME,
                              ),
                            )
                          ],
                          backgroundColor: _colorTween.value,
                          elevation: 0.0,
                        ),
                        body: NotificationListener<ScrollNotification>(
                          onNotification: _scrollListener,
                          child: Consumer<HomeNotifier>(
                              builder: (context, data, child) {
                            final state = data.state;
                            if (state == MdbContentType.Movie) {
                              return MainMoviePage();
                            } else {
                              return MainTvPage();
                            }
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
