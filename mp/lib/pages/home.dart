import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfPdfViewer.file(
          File('assets/README.pdf')
      ),
    );
  }
}