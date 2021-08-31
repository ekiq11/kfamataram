import 'dart:ui';

import 'package:flutter/material.dart';

class ExplanationData {
  final String subtitle;
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData(
      {this.title,
      this.description,
      this.localImageSrc,
      this.backgroundColor,
      this.subtitle});
}

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 40.0),
            child: Image.asset(data.localImageSrc,
                height: MediaQuery.of(context).size.height * 0.30,
                alignment: Alignment.center)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                data.subtitle,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
