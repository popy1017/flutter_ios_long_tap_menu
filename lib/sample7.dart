import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample7 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _BouncePhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample7')),
      body: GridView.count(
        crossAxisCount: 2,
        children: photos,
      ),
    );
  }
}

class _BouncePhoto extends StatefulWidget {
  _BouncePhoto({@required this.url});

  final String url;

  @override
  __BouncePhotoState createState() => __BouncePhotoState();
}

class __BouncePhotoState extends State<_BouncePhoto>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  Alignment _alignment = Alignment.center;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scale = _animationController
        .drive(
          CurveTween(curve: Curves.bounceIn),
        )
        .drive(
          Tween(begin: 1, end: 0.8),
        );
  }

  Future<void> _forwardAnimation() async {
    await _animationController.forward().whenComplete(() async {
      Vibrate.feedback(FeedbackType.medium);
      _animationController.reverse();
    });
  }

  void _setBigImageAlignment(TapDownDetails details) {
    final Size size = MediaQuery.of(context).size;
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;

    final double x = details.globalPosition.dx;
    final double y = details.globalPosition.dy;

    // Alignment(x,y)の(x,y)の値の範囲は、-1~1なので
    // 画面の幅や高さからタップ座標を-1~1に正規化
    _alignment = Alignment(
      (x - halfWidth) / halfWidth,
      (y - halfHeight) / halfHeight,
    );
  }

  void _showBigImage() async {
    await _forwardAnimation();
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, _, __) {
          return _BigImage(alignment: _alignment, url: widget.url);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _setBigImageAlignment(details);
      },
      onLongPress: _showBigImage,
      child: ScaleTransition(
        scale: _scale,
        child: Hero(
          tag: widget.url,
          child: Image.network(
            widget.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _BigImage extends StatelessWidget {
  const _BigImage({
    @required this.alignment,
    @required this.url,
  });

  final Alignment alignment;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Hero(
          tag: url,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
