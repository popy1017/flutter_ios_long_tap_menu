import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample6 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _BouncePhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample6')),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await _forwardAnimation();
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            fullscreenDialog: true,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (BuildContext context, _, __) {
              return Center(
                child: Hero(
                  tag: widget.url,
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
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
