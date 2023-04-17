import 'package:flutter/material.dart';

class Download extends StatelessWidget {
  const Download({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade300,
                Colors.black45,
                Colors.black54
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
        )
    );
  }
}
