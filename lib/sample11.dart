import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample11 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _BouncePhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample11')),
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

  Alignment _imageAlignment = Alignment.center;
  Alignment _menuAlignment = Alignment.center;

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

  Future<void> _bounceAnimation() async {
    // 縮小アニメーション(.forward())の終了を待ってから、逆のアニメーション(.reverse())を実行する
    await _animationController.forward().whenComplete(() async {
      // 端末を小さく振動させる
      Vibrate.feedback(FeedbackType.medium);

      // 逆のアニメーション(元の大きさに戻る)
      _animationController.reverse();
    });
  }

  // タップ位置をもとに拡大画像とメニューの表示位置を算出
  void _setBigImageAlignment(TapDownDetails details) {
    final Size size = MediaQuery.of(context).size;
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;

    final double x = details.globalPosition.dx;
    final double y = details.globalPosition.dy;

    // Alignment(x,y)の(x,y)の値の範囲は、-1~1なので
    // 画面の幅や高さからタップ座標を-1~1に正規化
    // → Align(0,0)は中央
    _imageAlignment = Alignment(
      0, // <= 画像は水平方向を中央に設定
      (y - halfHeight) / halfHeight,
    );
    _menuAlignment = Alignment(
      (x - halfWidth) / halfWidth,
      (y - halfHeight) / halfHeight,
    );
  }

  void _showDetailView() async {
    await _bounceAnimation();
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, _, __) {
          return _DetailView(
            imageUrl: widget.url,
            imageAlignment: _imageAlignment,
            menuAlignment: _menuAlignment,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // タップ位置はonTapDownから取得する
      onTapDown: (TapDownDetails details) {
        _setBigImageAlignment(details);
      },
      onLongPress: _showDetailView,
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

class _DetailView extends StatefulWidget {
  _DetailView({
    @required this.imageUrl,
    this.imageAlignment = Alignment.center,
    this.menuAlignment = Alignment.center,
  });

  final String imageUrl;
  final Alignment imageAlignment;
  final Alignment menuAlignment;

  @override
  __DetailViewState createState() => __DetailViewState();
}

class __DetailViewState extends State<_DetailView>
    with SingleTickerProviderStateMixin {
  Offset currentDragPosition = Offset.zero;
  Offset beginningDragPosition = Offset.zero;

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
          CurveTween(curve: Curves.bounceOut),
        )
        .drive(
          Tween(begin: 0, end: 1),
        );
    _openMenu();
  }

  TickerFuture _openMenu() {
    return _animationController.forward();
  }

  TickerFuture _closeMenu() {
    return _animationController.reverse();
  }

  void _close() {
    _closeMenu().whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  double get photoViewScale {
    return max(1.0 - currentDragPosition.distance * 0.001, 0.8);
  }

  Matrix4 get photoViewTransform {
    // 位置
    final translationTransform = Matrix4.translationValues(
      currentDragPosition.dx,
      currentDragPosition.dy,
      0.0,
    );

    // 大きさ
    final scaleTransform = Matrix4.diagonal3Values(
      photoViewScale,
      photoViewScale,
      1.0,
    );

    return translationTransform * scaleTransform;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _close,
      onVerticalDragStart: (DragStartDetails dragStartDetails) {
        beginningDragPosition = dragStartDetails.globalPosition;
        _closeMenu();
      },
      onVerticalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        setState(() {
          currentDragPosition = Offset(
            dragUpdateDetails.globalPosition.dx - beginningDragPosition.dx,
            dragUpdateDetails.globalPosition.dy - beginningDragPosition.dy,
          );
        });
      },
      onVerticalDragEnd: (DragEndDetails dragEndDetails) {
        if (currentDragPosition.distance < 150.0) {
          setState(() {
            currentDragPosition = Offset.zero;
          });
          _openMenu();
        } else {
          _close();
        }
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Align(
          alignment: widget.imageAlignment,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 1),
                transform: photoViewTransform,
                child: _BigImage(
                    alignment: widget.imageAlignment, url: widget.imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScaleTransition(
                  scale: _scale,
                  alignment: widget.menuAlignment,
                  child: _ActionMenu(alignment: widget.menuAlignment),
                ),
              ),
            ],
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
        width: MediaQuery.of(context).size.width * 0.9,
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

class _ActionMenu extends StatelessWidget {
  _ActionMenu({
    this.alignment = Alignment.center,
  });

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('コピー'),
                trailing: Icon(Icons.copy),
                onTap: () {},
              ),
              ListTile(
                title: Text('共有'),
                trailing: Icon(Icons.share),
                onTap: () {},
              ),
              ListTile(
                title: Text('お気に入り'),
                trailing: Icon(Icons.favorite_border),
                onTap: () {},
              ),
              ListTile(
                title: Text('削除', style: TextStyle(color: Colors.redAccent)),
                trailing: Icon(Icons.delete, color: Colors.redAccent),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
