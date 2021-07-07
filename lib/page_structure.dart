import 'dart:io';
import 'dart:math' show pi;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nyus_app/home_screen.dart';
import 'package:provider/provider.dart';

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
    final color = Theme.of(context).accentColor;
    final angle = ZoomDrawer.isRTL() ? 180 * pi / 180 : 0.0;
    final _currentPage =
        context.select<MenuProvider, int>((provider) => provider.currentPage);
    final container = Container(
      alignment: Alignment.center,
      color: Colors.white,
      child:
          Text("Test aja si"),
    );

    return PlatformScaffold(
      backgroundColor: Colors.transparent,
      appBar: PlatformAppBar(
        automaticallyImplyLeading: false,
        material: (_, __) => MaterialAppBarData(elevation: elevation),
        title: PlatformText(
          HomeScreen.mainMenu[_currentPage].title,
        ),
        leading: Transform.rotate(
          angle: angle,
          child: PlatformIconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ),
        trailingActions: actions,
      ),
      bottomNavBar: PlatformNavBar(
        material: (_, __) => MaterialNavBarData(
          selectedLabelStyle: TextStyle(color: color),
        ),
        currentIndex: _currentPage,
        itemChanged: (index) => Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index),
        items: HomeScreen.mainMenu
            .map(
              (item) => BottomNavigationBarItem(
            label: item.title,
            icon: Icon(
              item.icon,
              color: color,
            ),
          ),
        )
            .toList(),
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