import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Lottie.asset('assets/anumations/runner.json'),
            ),
        ),
    );
  }
}