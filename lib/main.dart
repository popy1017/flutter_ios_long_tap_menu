import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/sample1.dart';
import 'package:grid_view_long_tap/sample2.dart';
import 'package:grid_view_long_tap/sample3.dart';
import 'package:grid_view_long_tap/sample4.dart';
import 'package:grid_view_long_tap/sample5.dart';
import 'package:grid_view_long_tap/sample6.dart';
import 'package:grid_view_long_tap/sample7.dart';
import 'package:grid_view_long_tap/sample8.dart';
import 'package:grid_view_long_tap/sample9.dart';
import 'package:grid_view_long_tap/sample10.dart';

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
        '/sample9': (BuildContext context) => Sample9(),
        '/sample10': (BuildContext context) => Sample10(),
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
          SampleListTile(1, '画像を長押しすると、画像が前面に出てくる(GridView x Hero)。'),
          SampleListTile(2, 'よくわからないサンプル'),
          SampleListTile(3, 'よくわからないサンプル'),
          SampleListTile(4, '四角を長押しすると大きい四角が前面に出る。(バウンスアニメーション＋Hero)'),
          SampleListTile(5, '画像を長押しすると大きい画像が前面に出る。(バウンスアニメーション＋Hero'),
          SampleListTile(6, 'Sample1と5の組み合わせ(GridView x Hero x バウンスアニメーション)'),
          SampleListTile(
              7, 'Sample6＋タップ位置に応じて拡大画像の位置を変える(GridView x Hero x バウンスアニメーション)'),
          SampleListTile(8, 'Sample7の背景ぼかしバージョン'),
          SampleListTile(9, 'Sample8＋写真の下にアクションメニューを表示'),
          SampleListTile(10, 'Sample9のメニューにアニメーションをつける'),
        ],
      ),
    );
  }
}

class SampleListTile extends StatelessWidget {
  SampleListTile(this.index, this.title);

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Text('$index'),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.pushNamed(context, '/sample$index');
      },
    );
  }
}
