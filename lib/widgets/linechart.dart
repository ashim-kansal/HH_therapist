import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withData(List<Result> data) {
    return new SimpleLineChart(
      _createSampleData(data),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate,defaultRenderer: new charts.LineRendererConfig(includePoints: true, radiusPx: 5,stacked: false));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Result, int>> _createSampleData(List<Result> data) {
    return [
      new charts.Series<Result, int>(
        id: 'Goals',
        colorFn: (_, __) => charts.Color.fromHex(code: '#777CEA'),
        domainFn: (Result sales, _) => sales.date.day,
        measureFn: (Result sales, _) => sales.achivedGoal,
        data: data,
      )

    ];
  }
}
