import 'package:flutter/material.dart';
import 'package:grid_view_long_tap/image_url.dart';

class Sample1 extends StatelessWidget {
  final List<Widget> photos = List.generate(
      imageUrls.length, (int index) => _HeroPhoto(url: imageUrls[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample1')),
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
              return Center(
                child: Hero(
                  tag: url,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
