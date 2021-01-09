import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/sample1.dart';
import 'package:grid_view_long_tap/sample2.dart';
import 'package:grid_view_long_tap/sample3.dart';
import 'package:grid_view_long_tap/sample4.dart';
import 'package:grid_view_long_tap/sample5.dart';
import 'package:grid_view_long_tap/sample6.dart';
import 'package:grid_view_long_tap/sample7.dart';
import 'package:grid_view_long_tap/sample8.dart';

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
        '/sample7': (BuildContext context) => Sample7(),
        '/sample8': (BuildContext context) => Sample8(),
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
          ListTile(
            title:
                Text('6＋タップ位置に応じて拡大画像の位置を変える(GridView x Hero x バウンスアニメーション)'),
            leading: Text('7'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample7');
            },
          ),
          ListTile(
            title: Text('Sample7の背景ぼかしバージョン'),
            leading: Text('8'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/sample8');
            },
          ),
        ],
      ),
    );
  }
}
