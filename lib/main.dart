import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/sample1/sample1.dart';
import 'package:grid_view_long_tap/sample2/sample2.dart';
import 'package:grid_view_long_tap/sample3/sample3.dart';
import 'package:grid_view_long_tap/sample4/sample4.dart';
import 'package:grid_view_long_tap/sample5/sample5.dart';
import 'package:grid_view_long_tap/sample6/sample6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/sample1': (BuildContext context) => Sample1(),
        '/sample2': (BuildContext context) => Sample2(),
        '/sample3': (BuildContext context) => Sample3(),
        '/sample4': (BuildContext context) => Sample4(),
        '/sample5': (BuildContext context) => Sample5(),
        '/sample6': (BuildContext context) => Sample6(),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ホーム')),
      body: ListView(
        children: [
          ListTile(
            title: Text('画像を長押しすると、画像が前面に出てくる(GridView x Hero)。'),
            leading: Text('1'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample1');
            },
          ),
          ListTile(
            title: Text('よくわからないサンプル'),
            leading: Text('2'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample2');
            },
          ),
          ListTile(
            title: Text('よくわからないサンプル'),
            leading: Text('3'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample3');
            },
          ),
          ListTile(
            title: Text('四角を長押しすると大きい四角が前面に出る。(バウンスアニメーション＋Hero)'),
            leading: Text('4'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample4');
            },
          ),
          ListTile(
            title: Text('画像を長押しすると大きい画像が前面に出る。(バウンスアニメーション＋Hero)'),
            leading: Text('5'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample5');
            },
          ),
          ListTile(
            title: Text('1と5の組み合わせ(GridView x Hero x バウンスアニメーション)'),
            leading: Text('6'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample6');
            },
          ),
        ],
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: list,
      ),
    );
  }
}

class Photo extends StatelessWidget {
  Photo(this.url);

  final String url;

  TapDownDetails details;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
        tag: url,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
      onTapDown: (TapDownDetails tapDownDetails) {
        print('1: onTapDown');
        print(tapDownDetails.globalPosition.dx);
        details = tapDownDetails;
      },
      onLongPress: () async {
        await Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            fullscreenDialog: true,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (BuildContext context, _, __) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: url,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ActionMenu(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ActionMenu extends StatefulWidget {
  ActionMenu(this.open);

  bool open = true;

  @override
  _ActionMenuState createState() => _ActionMenuState();
}

class _ActionMenuState extends State<ActionMenu> {
  double _width = 100;
  double _height = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _width = 100;
        _height = 300;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: _width,
      height: _height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () {},
              child: Text('Hello'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Hello'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Hello'),
            )
          ],
        ),
      ),
    );
  }
}
*/
