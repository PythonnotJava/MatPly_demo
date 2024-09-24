import 'package:mp/matply/core.dart';
import 'package:mp/matply/matply.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';
import 'package:flutter_markdown/flutter_markdown.dart' show Markdown;


// 将一个二维可迭代对象（二维Dataframe）转为markdown表格形式
String toMarkdownTable<T>(
    MatrixType data, {
      List<Object>? rls,
      List<Object>? cls,
      String rowLack = 'row',
      String colLack = 'col'
    }) {

  int rows = data.shape[0];
  int columns = data.shape[1];

  // 使用提供的标签或默认标签，并补充缺失的标签
  rls = rls ?? List.generate(rows, (index) => index, growable: true);
  cls = cls ?? List.generate(columns, (index) => index, growable: true);

  // 如果行标签长度不足，补充缺失的标签
  if (rls.length < rows) {
    rls = List<Object>.from(rls)..addAll(List.generate(rows - rls.length, (index) => '$rowLack$index'));
  }

  // 如果列标签长度不足，补充缺失的标签
  if (cls.length < columns) {
    cls = List<Object>.from(cls)..addAll(List.generate(columns - cls.length, (index) => '$colLack$index'));
  }

  // 构建表头
  StringBuffer buffer = StringBuffer();
  buffer.write('|   |');
  for (var label in cls) {
    buffer.write(' $label |');
  }
  buffer.writeln();

  // 构建分隔行
  buffer.write('|---|');
  for (int i = 0; i < columns; i++) {
    buffer.write('---|');
  }
  buffer.writeln();

  // 构建数据行
  for (int r = 0; r < rows; r++) {
    buffer.write('| ${rls[r]} |');
    for (int c = 0; c < columns; c++) {
      buffer.write(' ${data.at(r, c).round() ?? ''} |');
    }
    buffer.writeln();
  }

  return buffer.toString();
}

class MtOpBoard extends StatelessWidget {
  MtOpBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitView(
        viewMode: SplitViewMode.Horizontal,
        children: [
           Center(
            child: SplitView(
              viewMode: SplitViewMode.Vertical,
              children: [
                Center(
                  child: Markdown(
                    data: toMarkdownTable(MatrixType.E(n: 8), rls: ['row'], cls: ['column']),
                  ),
                ),
                Center(
                  child: Markdown(
                    data: toMarkdownTable(MatrixType.linspace(start: 0, end: 1, row: 8, column: 8), rls: ['row'], cls: ['column']),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: SplitView(
              viewMode: SplitViewMode.Vertical,
              children: [
                Center(
                  child: Markdown(
                    data: toMarkdownTable(MatrixType.range(start: 0, row: 8, column: 8), rls: ['row'], cls: ['column']),
                  ),
                ),
                Center(
                  child: Markdown(
                    data: toMarkdownTable(MatrixType.triangular(row: 8, column: 8, left: 2, middle: 5, right: 6), rls: ['row'], cls: ['column']),
                  ),
                )
              ],
            )
          )
        ]
    );
  }

}