import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample3 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _HeroPhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample3')),
      body: GridView.count(
        crossAxisCount: 2,
        children: photos,
      ),
    );
  }
}

class _HeroPhoto extends StatelessWidget {
  _HeroPhoto({@required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: url + 'rect',
            child: Align(
              child: Container(
                width: 40,
                height: 40,
                color: Colors.red.withOpacity(0.3),
              ),
            ),
          ),
          Hero(
            tag: url,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ],
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
              return _PhotoView(url: url);
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
    return Listener(
      onPointerMove: (PointerMoveEvent event) {
        print(event.localPosition);
      },
      child: Dismissible(
        key: Key(widget.url),
        direction: DismissDirection.vertical,
        child: GestureDetector(
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
                  Hero(
                    tag: widget.url + 'rect',
                    child: Align(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
