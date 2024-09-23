 import 'dart:math' show Point, sin, pow, cos, exp;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mp/matply/matply.dart';

class GeometryView extends StatefulWidget {
  const GeometryView({super.key});

  @override
  GeometryViewState createState() => GeometryViewState();
}

class GeometryViewState extends State<GeometryView> {
  final biasInput = TextEditingController(text: '0.0');
  final numInput = TextEditingController(text: '100');

  final startXInput = TextEditingController(text: '0.0');
  final startYInput = TextEditingController(text: '0.0');
  final endXInput = TextEditingController(text: '2.0');
  final endYInput = TextEditingController(text: '2.0');
  final ctrlXInput = TextEditingController(text: '1.0');
  final ctrlYInput = TextEditingController(text: '0.0');
  List<ScatterSpot> databezier = [];

  final xInput = TextEditingController(text: '0.0');
  bool isEdge1 = true;
  List<ScatterSpot> dataheart = [];

  final aInput = TextEditingController(text: '4.0');
  final bInput = TextEditingController(text: '3.0');
  bool isEdge2 = true;
  List<ScatterSpot> dataep = [];

  final pointInput = TextEditingController(text: '1.0');
  final mm = GeometryGenerator.curve((double x) => sin(x) + cos(x) + exp(pow(x, 0.4)), x1: 0, x2: 10.5, size: 100);
  late LineChartBarData defcurve;
  List<FlSpot> tangent = [];
  List<FlSpot> points = [];

  @override
  void initState() {
    defcurve = LineChartBarData(
      isCurved: true,
      dotData: const FlDotData(show: false,),
      belowBarData: BarAreaData(show: false),
      barWidth: 4,
      spots: List.generate(100, (e)=>FlSpot(mm.at(e, 0), mm.at(e, 1))),
    );
    super.initState();
  }

  @override
  void dispose() {
    startXInput.dispose();
    startYInput.dispose();
    biasInput.dispose();
    numInput.dispose();
    endYInput.dispose();
    endXInput.dispose();
    ctrlYInput.dispose();
    ctrlXInput.dispose();
    aInput.dispose();
    bInput.dispose();
    xInput.dispose();
    pointInput.dispose();
    super.dispose();
  }

  Widget gradBuild(){
    fn(double x) => pow(x, 2.0) as double;
    MatrixType mtx = MatrixType.linspace(start: -10, end: 10, row: 1, column: 500);
    MatrixType mty = mtx.customize(fn);
    MatrixType grady = mtx.diff_center(fn);
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
              color: Colors.black87,
              isCurved: true,
              dotData: const FlDotData(show: false,),
              belowBarData: BarAreaData(show: false),
              barWidth: 4,
              spots: List.generate(500, (e) => FlSpot(mtx.at(0, e), mty.at(0, e)))
          ),
          LineChartBarData(
              color: Colors.red,
              isCurved: true,
              dotData: const FlDotData(show: false,),
              belowBarData: BarAreaData(show: false),
              spots: List.generate(500, (e) => FlSpot(mtx.at(0, e), grady.at(0, e)))
          )
        ],
      ),
    );
  }

  Widget curveBuild(){
    return Column(
      children: [
        Row(
          children: [
            const Text('数量'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: numInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('切点'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: pointInput,
                  keyboardType: TextInputType.number,
                )
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    double x = double.parse(pointInput.text);
                    x = x > 0 && x <= 10? x:1.0;
                    fn(double x) => -sin(x) + cos(x) + 0.4 * pow(x, -0.6) * exp(pow(x, 0.4));
                    double k = fn(x);
                    double y = sin(x) + cos(x) + exp(pow(x, 0.4));
                    double b = y - k * x;
                    MatrixType mt = GeometryGenerator.linewb(start: 0.0, end: 10.0, w: k, b: b, size: 300);
                    tangent = List.generate(300, (e) =>FlSpot(mt.at(e, 0), mt.at(e, 1)));
                    points = [FlSpot(x, y)];
                  });
                },
                child: const Text('Run')
            )
          ],
        ),
        tangent.isNotEmpty? SizedBox(
            height: 400,
            child:LineChart(
              LineChartData(
                lineBarsData: [
                  defcurve,
                  LineChartBarData(
                    color: Colors.black87,
                    isCurved: true,
                    dotData: const FlDotData(show: false,),
                    belowBarData: BarAreaData(show: false),
                    barWidth: 4,
                    spots: tangent
                  ),
                  LineChartBarData(
                      color: Colors.red,
                      isCurved: true,
                      dotData: const FlDotData(show: true,),
                      belowBarData: BarAreaData(show: false),
                      spots: points
                  )
                ],
              ),
            )
        ):SizedBox(
            height: 400,
            child:LineChart(
              LineChartData(
                lineBarsData: [
                  defcurve
                ],
              ),
            )
        )
      ],
    );
  }

  Widget epBuild(){
    return Column(
      children: [
        Row(
          children: [
            const Text('数量'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: numInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('半长轴'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: aInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('半短轴'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: bInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('偏移'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: biasInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('边缘/区域'),
            Switch(
                value: isEdge2,
                onChanged: (v){
                  setState(() {
                    isEdge2 = v;
                  });
                }),
            ElevatedButton(
                onPressed: (){
                  int num = int.parse(numInput.text);
                  num = num >= 50 && num <= 2000?num :100;
                  setState(() {
                    MatrixType mt = isEdge2 ? GeometryGenerator.ellipse_edge(
                        size: num,
                        bias: double.parse(biasInput.text),
                        a: double.parse(aInput.text),
                        b: double.parse(bInput.text)
                    ):GeometryGenerator.ellipse_area(
                        size: num,
                        bias: double.parse(biasInput.text),
                        a: double.parse(aInput.text),
                        b: double.parse(bInput.text)
                    );
                    dataep = List.generate(num, (e)=>ScatterSpot(mt.at(e, 0), mt.at(e, 1)));
                  });
                },
                child: const Text('Run')
            )
          ],
        ),
        dataep.isNotEmpty?SizedBox(
          height: 400,
          child: ScatterChart(
              ScatterChartData(
                  scatterSpots: dataep
              )
          ),
        ):Container()
      ],
    );
  }

  Widget heartBuild(){
    return Column(
      children: [
        Row(
          children: [
            const Text('数量'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: numInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('中心轴'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: xInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('偏移'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: biasInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('边缘/区域'),
            Switch(
                value: isEdge1,
                onChanged: (v){
                  setState(() {
                    isEdge1 = v;
                  });
                }),
            ElevatedButton(
                onPressed: (){
                  int num = int.parse(numInput.text);
                  num = num >= 50 && num <= 2000?num :100;
                  setState(() {
                    MatrixType mt = isEdge1 ? GeometryGenerator.heart_edge(
                      size: num,
                      bias: double.parse(biasInput.text),
                      x_center: double.parse(xInput.text)
                    ):GeometryGenerator.heart_area(
                        size: num,
                        bias: double.parse(biasInput.text),
                        x_center: double.parse(xInput.text)
                    );
                    dataheart = List.generate(num, (e)=>ScatterSpot(mt.at(e, 0), mt.at(e, 1)));
                  });
                },
                child: const Text('Run')
            )
          ],
        ),
        dataheart.isNotEmpty?SizedBox(
          height: 400,
            child: ScatterChart(
                ScatterChartData(
                  scatterSpots: dataheart
                )
            ),
        ):Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('贝塞尔函数'),),
              Tab(child: Text('心形'),),
              Tab(child: Text('椭圆'),),
              Tab(child: Text('曲线与切线'),),
              Tab(child: Text('梯度（导数）测试'),)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            bezierBuild(),
            heartBuild(),
            epBuild(),
            curveBuild(),
            gradBuild()
          ],
        ),
      ),
    );
  }

  Widget bezierBuild(){
    return Column(
      children: [
        Row(
          children: [
            const Text('数量'),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                controller: numInput,
                keyboardType: TextInputType.number,
              )
            ),
            const Text('起点X'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: startXInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('起点Y'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: startYInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('控制X'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: ctrlXInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('控制Y'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: ctrlYInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('终点X'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: endXInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('终点Y'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: endYInput,
                  keyboardType: TextInputType.number,
                )
            ),
            const Text('偏移'),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: biasInput,
                  keyboardType: TextInputType.number,
                )
            ),
            ElevatedButton(
                onPressed: (){
                  int num = int.parse(numInput.text);
                  num = num >= 50 && num <= 2000? num : 100;
                  setState(() {
                    MatrixType mt = GeometryGenerator.bezier(
                        start: Point(double.parse(startXInput.text), double.parse(startYInput.text)),
                        end: Point(double.parse(endXInput.text), double.parse(endYInput.text)),
                        ctrl: Point(double.parse(ctrlXInput.text), double.parse(ctrlYInput.text)),
                        size: num,
                        bias: double.parse(biasInput.text)
                    );
                    databezier = List.generate(num, (e){
                      return ScatterSpot(
                          mt.at(e, 0),
                          mt.at(e, 1)
                      );
                    });
                  });
                },
                child: const Text('Run')
            )
          ],
        ),
        databezier.isNotEmpty? SizedBox(
          height: 450,
          width: 600,
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: databezier
            )
          ),
        ) : Container(),
      ],
    );
  }

}