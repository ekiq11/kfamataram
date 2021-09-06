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
                'https://wisatakuapps.com/kf_api/kfonline/upload_mess/' +
                    image.toString(),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
