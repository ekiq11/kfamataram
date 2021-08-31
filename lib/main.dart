import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_online/view/app.dart';

void main() {
  runApp(App());
  // hide status bar
  SystemChrome.setEnabledSystemUIOverlays([]);
}
