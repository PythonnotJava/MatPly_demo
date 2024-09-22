import 'dart:math' show Point;

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
  bool isEdge = true;
  List<ScatterSpot> dataheart = [];

  final aInput = TextEditingController(text: '4.0');
  final bInput = TextEditingController(text: '3.0');
  List<ScatterSpot> dataep = [];

  @override
  void initState() {
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
    super.dispose();
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
            const Text('区域/边缘'),
            Switch(
                value: isEdge,
                onChanged: (v){
                  setState(() {
                    isEdge = v;
                  });
                }),
            ElevatedButton(
                onPressed: (){
                  int num = int.parse(numInput.text);
                  num = num >= 50 && num <= 2000?num :100;
                  setState(() {
                    MatrixType mt = isEdge ? GeometryGenerator.ellipse_edge(
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
            const Text('区域/边缘'),
            Switch(
                value: isEdge,
                onChanged: (v){
                  setState(() {
                    isEdge = v;
                  });
                }),
            ElevatedButton(
                onPressed: (){
                  int num = int.parse(numInput.text);
                  num = num >= 50 && num <= 2000?num :100;
                  setState(() {
                    MatrixType mt = isEdge ? GeometryGenerator.heart_edge(
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('贝塞尔函数'),),
              Tab(child: Text('心形'),),
              Tab(child: Text('椭圆'),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            bezierBuild(),
            heartBuild(),
            epBuild(),
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