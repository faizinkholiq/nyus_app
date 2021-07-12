import 'dart:io';
import 'dart:math' show pi;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nyus_app/home_screen.dart';
import 'package:provider/provider.dart';

import './content_view.dart';
import './extensions.dart';
import 'package:flutter/widgets.dart';

class PageStructure extends StatelessWidget {
  final String? title;
  final Widget? child;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const PageStructure({
    Key? key,
    this.title,
    this.child,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final _currentPage =
        context.select<MenuProvider, int>((provider) => provider.currentPage);
    final container = Container(
      alignment: Alignment.center,
      color: Colors.white,
      child:
          Text("y"),
    );

    // final tabs = [
    //   ContentView(
    //     0,
    //     widget.platform,
    //     key: ValueKey('key0'),
    //   ),
    //   ContentView(
    //     1,
    //     widget.platform,
    //     key: ValueKey('key1'),
    //   )
    // ];
    
    // return PlatformTabScaffold(
    //   iosContentPadding: true,
    //   tabController: PlatformTabController(
    //     initialIndex: 1,
    //   ),
    //   appBarBuilder: (_, index) => PlatformAppBar(
    //     title: Text('${widget.platform.text} Page Title'),
    //     trailingActions: <Widget>[
    //       PlatformIconButton(
    //         padding: EdgeInsets.zero,
    //         icon: Icon(context.platformIcons.share),
    //         onPressed: () {},
    //       ),
    //     ],
    //     cupertino: (_, __) => CupertinoNavigationBarData(
    //       title: Text('${titles[index]}'),
    //     ),
    //   ),
    //   bodyBuilder: (context, index) => IndexedStack(
    //     index: index,
    //     children: tabs,
    //   ),
    //   items: items(context),
    // );

    return PlatformScaffold(
      backgroundColor: Colors.transparent,
      appBar: PlatformAppBar(
        automaticallyImplyLeading: false,
        material: (_, __) => MaterialAppBarData(elevation: elevation),
        title: PlatformText(
          HomeScreen.mainMenu[_currentPage].title,
        ),
        leading: PlatformIconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            print("click the menu");
            ZoomDrawer.of(context)!.toggle();
          },
        ),
        trailingActions: actions,
      ),
      bottomNavBar: PlatformNavBar(
        material: (_, __) => MaterialNavBarData(
          backgroundColor: Colors.white,
          showSelectedLabels: false, 
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(color: Colors.black,),
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        currentIndex: _currentPage,
        itemChanged: (index) => Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index),
        items: HomeScreen.mainMenu
            .map(
              (item) => BottomNavigationBarItem(
            label: item.title,
            icon: Icon(
              item.icon,
            ),
          ),
        ).toList(),
      ),
      body: kIsWeb
          ? container
          : Platform.isAndroid
          ? container
          : SafeArea(
        child: container,
      ),
    );
  }
}