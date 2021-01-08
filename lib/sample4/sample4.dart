import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class Sample4 extends StatefulWidget {
  @override
  _Sample4State createState() => _Sample4State();
}

class _Sample4State extends State<Sample4> with SingleTickerProviderStateMixin {
  double width = 100;
  double height = 100;

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
          Tween(begin: 1, end: 0.9),
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
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
                      tag: 'rect',
                      child: _Rect(),
                    ),
                  );
                },
              ),
            );
          },
          child: ScaleTransition(
            scale: _scale,
            child: Hero(
              tag: 'rect',
              child: Container(
                width: width,
                height: height,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Rect extends StatelessWidget {
  _Rect({this.width = 200, this.height = 200});

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      color: Colors.green,
      duration: Duration(seconds: 1),
    );
  }
}
