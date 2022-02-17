import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ResultPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const ResultPieChart(this.seriesList, {Key key, this.animate})
      : super(key: key);

  factory ResultPieChart.withSampleData() {
    return ResultPieChart(
      _createSampleData(),
      animate: false,
    );
  }

  factory ResultPieChart.withGivenData(List<int> givendata) {
    return ResultPieChart(
      _createGivenData(givendata),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [
              charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside)
            ]));
  }

  static List<charts.Series<PieSegment, String>> _createGivenData(
      List<int> data) {
    final data_list = [
      PieSegment('Pass', data[0]),
      PieSegment('Defection', data[1])
    ];
    return [
      charts.Series<PieSegment, String>(
        id: 'Success-Fail Ratio',
        domainFn: (PieSegment segments, _) => segments.name,
        measureFn: (PieSegment segments, _) => segments.size,
        data: data_list,
        labelAccessorFn: (PieSegment segments, _) => segments.name.toString(),
      )
    ];
  }

  static List<charts.Series<PieSegment, String>> _createSampleData() {
    final data = [PieSegment('', 1), PieSegment('', 0)];

    return [
      charts.Series<PieSegment, String>(
        id: 'Success-Fail Ratio',
        domainFn: (PieSegment segments, _) => segments.name,
        measureFn: (PieSegment segments, _) => segments.size,
        data: data,
      )
    ];
  }
}

class PieSegment {
  final String name;
  final int size;

  PieSegment(this.name, this.size);
}
