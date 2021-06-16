import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: Center(
        child: SpinKitFoldingCube(
          color: Color(0xFF227A73),
          size: 50,
        ),
      ),
    );
  }
}
