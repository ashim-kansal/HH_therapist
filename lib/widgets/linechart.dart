import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:simple_moment/simple_moment.dart';

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
    return new charts.TimeSeriesChart(seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true, radiusPx: 5,stacked: false,includeArea: true, roundEndCaps: true, ),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.SlidingViewport(),
        charts.PanAndZoomBehavior(),
        charts.LinePointHighlighter(
          drawFollowLinesAcrossChart: true,
          showHorizontalFollowLine: charts.LinePointHighlighterFollowLineType.all,
        ),
      ],
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: new charts.NoneRenderSpec(),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'EEE',
            transitionFormat: 'EEE',
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Result, DateTime>> _createSampleData(List<Result> data) {
    return [
      new charts.Series<Result, DateTime>(
        id: 'Goals',
        colorFn: (_, __) => charts.Color.fromHex(code: '#777CEA'),
        domainFn: (Result sales, _) => sales.date,
        measureFn: (Result sales, _) => sales.achivedGoal,
        data: data,
      )

    ];
  }

  String getDateLabel(mdate){
    Moment date = Moment.parse(mdate.toString());
    return date.format("dd");

  }
}
