import 'package:flutter/cupertino.dart' show Column, ConnectionState, Container, Image, MainAxisAlignment, SizedBox;
import 'package:flutter/material.dart' show AsyncSnapshot, BuildContext, Center, CircularProgressIndicator, Colors, Expanded, FutureBuilder, StatelessWidget, Text, Widget;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
class Mtviewer extends StatelessWidget {
  const Mtviewer({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/mt.svg',
      placeholderBuilder: (BuildContext context) => Container(
          child: const CircularProgressIndicator()),
    );
  }
}