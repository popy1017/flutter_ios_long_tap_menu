import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample12 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _HeroPhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample12')),
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
    return CupertinoContextMenu(
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
      actions: [
        CupertinoContextMenuAction(
          child: Text('コピー'),
          trailingIcon: Icons.copy,
        ),
        CupertinoContextMenuAction(
          child: Text('共有'),
          trailingIcon: Icons.share,
        ),
        CupertinoContextMenuAction(
          child: Text('お気に入り'),
          trailingIcon: Icons.favorite,
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          child: Text('削除'),
          trailingIcon: Icons.delete,
        ),
      ],
    );
  }
}
