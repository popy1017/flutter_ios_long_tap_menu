import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample5 extends StatefulWidget {
  @override
  _Sample5State createState() => _Sample5State();
}

class _Sample5State extends State<Sample5> with SingleTickerProviderStateMixin {
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
                    child: Container(
                      width: 400,
                      height: 200,
                      child: Hero(
                        tag: 'rect',
                        child: Image.network(
                          imageUrls.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          child: Container(
            width: 100,
            height: 100,
            child: ScaleTransition(
              scale: _scale,
              child: Hero(
                tag: 'rect',
                child: Image.network(
                  imageUrls.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
