import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample2 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _HeroPhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample2')),
      body: GridView.count(
        crossAxisCount: 2,
        children: photos,
      ),
    );
  }
}

class _HeroPhoto extends StatefulWidget {
  _HeroPhoto({@required this.url});

  final String url;

  @override
  __HeroPhotoState createState() => __HeroPhotoState();
}

class __HeroPhotoState extends State<_HeroPhoto> {
  TapDownDetails _details;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
        tag: widget.url,
        child: Image.network(
          widget.url,
          fit: BoxFit.cover,
        ),
      ),
      onTapDown: (TapDownDetails tapDownDetails) {
        print('1: onTapDown');
        print(tapDownDetails.globalPosition.dx);
        _details = tapDownDetails;
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
              return _PhotoView(url: widget.url);
            },
          ),
        );
      },
    );
  }
}

class _PhotoView extends StatefulWidget {
  const _PhotoView({
    Key key,
    @required this.url,
    this.details,
  }) : super(key: key);

  final String url;
  final TapDownDetails details;

  @override
  __PhotoViewState createState() => __PhotoViewState();
}

class __PhotoViewState extends State<_PhotoView> {
  Alignment _alignment = Alignment.topLeft;

  @override
  void initState() {
    super.initState();
    initAlignment();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _alignment = Alignment.center;
      });
    });
  }

  void initAlignment() {
    // ※ initStateが終わる前に MediaQuery呼ぶとエラー出る?
    // final Size size = MediaQuery.of(context).size;

    // if (widget.details.globalPosition.dx < size.width / 2 &&
    //     widget.details.globalPosition.dy < size.height / 2) {
    //   _alignment = Alignment.topLeft;
    // }

    _alignment = Alignment.topRight;
  }

  @override
  Widget build(BuildContext context) {
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
                tag: widget.url,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedContainer(
                alignment: _alignment,
                duration: Duration(seconds: 1),
                color: Colors.blue,
                width: 100,
                height: 100,
              ),
              AnimatedAlign(
                alignment: _alignment,
                duration: Duration(milliseconds: 100),
                child: Container(color: Colors.red, width: 100, height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
