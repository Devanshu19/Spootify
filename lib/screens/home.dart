import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          child: Column(
            children: const [
              HomeAppBar()
            ],
          ),
        )
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(top:20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            "Good Morning", 
            style: TextStyle(
              fontFamily: "MontserratBold",
              fontSize: 30,
            )
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(Icons.settings)
            )
          ],
        ),
      ),
    );
  }
}
