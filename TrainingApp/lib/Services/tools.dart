import 'package:flutter/material.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class Tools {
  Tools();

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  Future<bool> canLaunchURL(url) async {
    if (await canLaunch(url)) {
      return true;
    } else
      return false;
  }

  int generateRandomColor() {
    Random random = new Random();
    int randomNumber = random.nextInt(8);
    return colors[randomNumber];
  }

  //Color list
  List<int> colors = [
    0xFF227A73,
    0xFF0F52BA,
    0xFF8F00FF,
    0xFFFD6A02,
    0xFF960019,
    0xFFFF0090,
    0xFFB80F0A,
    0xFF3BB143
  ];
}
