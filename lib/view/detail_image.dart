import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String image;
  DetailScreen(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'Pesan Gambar',
            child: Image.network(
                'http://kfonline.aksestryout.com/akses/upload_mess/' +
                    image.toString(),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
