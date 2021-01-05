import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> list = [
    Photo(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Fujitsu-Logo.svg/1200px-Fujitsu-Logo.svg.png'),
    Photo(
        'https://img-cdn.guide.travel.co.jp/article/699/20160905212623/445977319B8C4879983132E250BB21AD_LL.jpg'),
    Photo(
        'https://cdn.zekkei-japan.jp/images/areas/db284a40bc008c81929eea5101690368.jpg'),
  ];

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
                        child: Hero(
                          tag: url,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }));
        // await showDialog(
        //     context: context,
        //     builder: (context) {
        //       return Column(
        //         children: <Widget>[
        //           Hero(
        //             tag: url,
        //             child: AlertDialog(
        //               backgroundColor: Colors.transparent,
        //               title: Text("タイトル"),
        //               content: SingleChildScrollView(
        //                 child: ListBody(
        //                   children: <Widget>[
        //                     Column(
        //                       children: [
        //                         Image.network(url),
        //                         Text('AAA'),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               actions: <Widget>[
        //                 // ボタン
        //               ],
        //             ),
        //           ),
        //         ],
        //       );
        //     });
      },
    );
  }
}
