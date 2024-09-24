import 'package:mp/matply/matply.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

String getMtData(MatrixType mt, {int format = 2}){
  StringBuffer buffer = StringBuffer();
  buffer.writeln("[\n");
  var [row, column] = mt.shape;
  for(int r = 0;r < row;r ++){
    buffer.writeln("[");
    for(int c = 0;c < column;c ++){
      buffer.write("${mt.at(r, c).toStringAsFixed(format)}\t");
    }
    buffer.writeln("]\n");
  }
  buffer.writeln("]\n");
  return buffer.toString();
}

class MtOpBoard extends StatelessWidget {
  const MtOpBoard({super.key});

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}