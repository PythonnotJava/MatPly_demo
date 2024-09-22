import 'dart:collection' show SplayTreeMap;
import 'dart:math' show sqrt, exp;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mp/matply/matply.dart';

class GraphSelector extends StatefulWidget {
  const GraphSelector({super.key});

  @override
  GraphSelectorState createState() => GraphSelectorState();
}

class GraphSelectorState extends State<GraphSelector> {
  final numInput = TextEditingController(text: '100');

  final startInput = TextEditingController(text: '0.0');
  final endInput = TextEditingController(text: '1.0');
  List<List<double>> _datauniform = [];

  final munormal = TextEditingController(text: '0');
  final sigmanormal = TextEditingController(text: '1.0');
  List<ScatterSpot> _datanormal = [];

  final pbinomial = TextEditingController(text: '0.5');
  final numbinomial = TextEditingController(text: '10');
  List<BarChartGroupData> _databinomial = [];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    startInput.dispose();
    endInput.dispose();
    numInput.dispose();
    munormal.dispose();
    sigmanormal.dispose();
    pbinomial.dispose();
    numbinomial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('均匀分布'),),
              Tab(child: Text('正态分布'),),
              Tab(child: Text('二项分布'),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            uniformBuild(),
            normalBuild(),
            binomialBuild()
          ],
        ),
      ),
    );
  }

  Widget uniformBuild() {
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
              const Text('起点'),
              Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: startInput,
                    keyboardType: TextInputType.number,
                  )
              ),
              const Text('终点'),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: endInput,
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    double start = double.parse(startInput.text);
                    double end = double.parse(endInput.text);
                    int num = int.parse(numInput.text);
                    num = num >= 50 && num <= 2000 ? num : 100;

                    setState(() {
                      MatrixType mtx = MatrixType.uniform(row: 1, column: num, start: start, end: end);
                      MatrixType mty = MatrixType.uniform(row: 1, column: num, start: start, end: end);
                      _datauniform = [mtx.toDoubleVector(), mty.toDoubleVector()];
                    });
                  },
                  child: const Text('Run')
              ),
            ],
          ),
          _datauniform.isNotEmpty ? SizedBox(
            height: 300,
            child: ScatterChart(
              ScatterChartData(
                scatterSpots: List<ScatterSpot>.generate(_datauniform[0].length, (e) {
                  return ScatterSpot(_datauniform[0][e], _datauniform[1][e]);
                }),
              ),
            ),
          ) : Container(),
        ],
      );
    }

    Widget normalBuild(){
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
              const Text('均值'),
              Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: munormal,
                    keyboardType: TextInputType.number,
                  )
              ),
              const Text('方差'),
              Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: sigmanormal,
                    keyboardType: TextInputType.number,
                  )
              ),
              ElevatedButton(
                  onPressed: () {
                    double mu = double.parse(munormal.text);
                    double sigma = double.parse(sigmanormal.text);
                    int num = int.parse(numInput.text);
                    num = num >= 50 && num <= 2000 ? num : 100;

                    setState(() {
                      MatrixType mtx = MatrixType.normal(row: 1, column: num, mu: mu, sigma: sigma);
                      fx(double x) => (1 / (sqrt(2 * Pi) * sigma)) * exp(-(x - mu) * (x - mu) / (2 * sigma * sigma));
                      MatrixType mty = mtx.customize(fx);
                      _datanormal = List.generate(num, (e){
                        return ScatterSpot(mtx.at(0, e), mty.at(0, e));
                      });
                    });
                  },
                  child: const Text('Run')
              ),z
            ],
          ),
          _datanormal.isNotEmpty ? SizedBox(
            height: 300,
            child: ScatterChart(
                ScatterChartData(
                  scatterSpots: _datanormal
                )
            ),
          ) : Container(),
        ],
      );
    }

    Widget binomialBuild() {
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
              const Text('概率'),
              Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: pbinomial,
                    keyboardType: TextInputType.number,
                  )
              ),
              const Text('次数'),
              Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: numbinomial,
                    keyboardType: TextInputType.number,
                  )
              ),
              ElevatedButton(
                  onPressed: () {
                    double p = double.parse(pbinomial.text);
                    int n = int.parse(numbinomial.text);
                    int num = int.parse(numInput.text);
                    num = num >= 50 && num <= 2000 ? num : 100;
                    p = p >=0 && p <= 1 ? p : .5;
                    n = n >= 1 && n <= 100? n:10;
                    setState(() {
                      MatrixType mtx = MatrixType.binomial(row: 1, column: num, n: n, p: p);
                      Map<int, int> convertedMap = (mtx.Hist(dim: -1) as Map<double, int>).map((key, value) {
                        return MapEntry(key.toInt(), value); // 将 double 键转换为 int
                      });
                      SplayTreeMap<int, int> sortedMap = SplayTreeMap.from(convertedMap);
                      convertedMap = Map.from(sortedMap);
                      _databinomial = List.generate(convertedMap.length, (i) {
                        return BarChartGroupData(
                          x: convertedMap.keys.elementAt(i),
                          barRods: [
                            BarChartRodData(
                              width: 16, toY: convertedMap.values.elementAt(i).toDouble(),
                            ),
                          ],
                        );
                      });
                    });
                  },
                  child: const Text('Run')
              )
            ],
          ),
          _databinomial.isNotEmpty ? SizedBox(
            height: 300,
            child: BarChart(
                BarChartData(
                    barGroups: _databinomial
                )
            ),
          ) : Container(),
        ],
      );
    }
}