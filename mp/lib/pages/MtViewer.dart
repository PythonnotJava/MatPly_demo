import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Mtviewer extends StatelessWidget {
  const Mtviewer({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfPdfViewer.file(
          File('assets/mt.pdf')
      ),
    );
  }
}