import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receptari/styles/app_styles.dart';

class CookingTimer extends StatefulWidget {
  const CookingTimer({super.key, required this.minutes});

  final int minutes;

  @override
  State<CookingTimer> createState() => _CookingTimerState();
}

class _CookingTimerState extends State<CookingTimer> {
  late int secondsLeft;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    secondsLeft = widget.minutes * 60;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      secondsLeft--;
      if (secondsLeft == 0) {
        timer.cancel();
      }
      debugPrint("$secondsLeft");
      setState(() {});
    });
  }

  @override
  void dispose() {
    debugPrint("dispose");
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsLeft ~/ 60).toString().padLeft(2, "0");
    final seconds = (secondsLeft % 60).toString().padLeft(2, "0");

    return Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.alarm, size: 32, color: AppStyles.primary),
        AppStyles.smallSeparator,
        Text(
          "$minutes:$seconds",
          style: TextStyle(
            fontSize: 32,
            color: AppStyles.primary,
            fontWeight: .bold,
          ),
        ),
      ],
    );
  }
}
