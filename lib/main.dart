import 'package:flutter/material.dart';
import 'package:nyus_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  runApp(TabBarExample());
}

class MyApp extends StatelessWidget {
  static const list = [
    Locale('en'),
    Locale('ar'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Zoom Drawer Demo',
      onGenerateTitle: (context) => "app_name",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // ignore: deprecated_member_use
        accentColor: Colors.orange,
      ),
      home: ChangeNotifierProvider(
        create: (_) => MenuProvider(),
        child: HomeScreen(),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final int index;

  const MenuItem(this.title, this.icon, this.index);
}

class TabBarExample extends StatefulWidget {
  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}


class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin {
  static List<MenuItem> mainMenu = [
    MenuItem("Home", Icons.home, 0),
    MenuItem("Search", Icons.search, 1),
    MenuItem("Headline", Icons.map_outlined, 2),
    MenuItem("Profile", Icons.person, 3),
  ];

  late TabController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: mainMenu.length, vsync: this);
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            title: Text(
              'Nyus App.',
              style: TextStyle(
                color: Color(0xFF1C2447),
                fontWeight: FontWeight.bold
              ),
            ),
            bottom: TabBar(
              // isScrollable: true,
              tabs: mainMenu.map(
                (item) => Tab(icon: Icon(item.icon)),
              ).toList(),
              labelColor: Color(0xFF1C2447),
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              NewPage(_index),
              HotelsPage(_index),
              FoodPage(_index),
              FunPage(_index),
            ]
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false, 
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(color: Colors.black,),
            unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: _index,
            items: mainMenu.map(
              (item) => BottomNavigationBarItem(
                label: item.title,
                icon: Icon(
                  item.icon,
                ),
              ),
            ).toList(),
            onTap: (int _index) {
              setState(() => this._index = _index);
            },
          ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final int index;

  NewPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('NewPage, index: $index'),
    );
  }
}

class HotelsPage extends StatelessWidget {
  final int index;

  HotelsPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('HotelsPage, index: $index'),
    );
  }
}

class FoodPage extends StatelessWidget {
  final int index;

  FoodPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('FoodPage, index: $index'),
    );
  }
}

class FunPage extends StatelessWidget {
  final int index;

  FunPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('FunPage, index: $index'),
    );
  }
}