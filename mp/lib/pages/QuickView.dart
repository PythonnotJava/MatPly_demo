import 'dart:math';

import 'package:flutter/material.dart';

import '../matply/src/core.dart';

class QuickView extends StatefulWidget {
  const QuickView({super.key});

  @override
  State<QuickView> createState() => _QuickViewState();
}

class _QuickViewState extends State<QuickView> {
  String text = 'Hello';
  Color color = Colors.black;

  void _onPressed() {
    setState(() {
      // 生成随机数字
      final random = Random();
      text = testOut().toString();

      // 生成随机颜色
      color = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuickView Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _onPressed,
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
