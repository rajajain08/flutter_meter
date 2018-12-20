import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Meter extends StatelessWidget {
  final double size;
  final int percentage;
  final int strokeSize;
  final Color backgroundColor;
  const Meter(
      {Key key,
      this.percentage,
      this.size,
      this.strokeSize = 10,
      this.backgroundColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GaugeChart gaugeChart = new GaugeChart.withSampleData(percentage);
    gaugeChart.setData(strokeSize);
    return new Stack(
      children: <Widget>[
        new Container(
          height: size,
          width: size,
          alignment: Alignment.center,
          margin: EdgeInsets.all(22.5),
          decoration: new BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: new Border(),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black, blurRadius: 0, spreadRadius: 22.5),
              new BoxShadow(
                  color: Colors.black, blurRadius: 4.0, spreadRadius: 17),
              new BoxShadow(
                  color: Colors.white, blurRadius: 2.5, spreadRadius: 20.0),
              new BoxShadow(
                  color: Colors.black, blurRadius: 8.5, spreadRadius: 15.0),
              new BoxShadow(
                  color: Colors.white, blurRadius: 5.0, spreadRadius: 10.0),
              new BoxShadow(
                  color: Colors.black, blurRadius: 4.0, spreadRadius: 5.0),
              new BoxShadow(
                  color: backgroundColor, blurRadius: 0.0, spreadRadius: 3.0)
            ],
          ),
          child: new Text(
            "$percentage",
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
            ),
          ),
        ),
        new Container(
          height: size + 45,
          width: size + 45,
          alignment: Alignment.topLeft,
          child: gaugeChart,
        ),
        new Container(
          height: size,
          width: size - (0.2 * size),
          alignment: Alignment.bottomRight,
          child: new Text(
            '100',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  GaugeChart(this.seriesList, {this.animate});
  int strokeSize = 30;

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData(int percentage) {
    int number = (percentage / 5).round();
    return new GaugeChart(
      _createSampleData(number),
      // Disable animations for image tests.
      animate: false,
    );
  }
  void setData(int sizeOfStroke) {
    strokeSize = sizeOfStroke;
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: strokeSize,
            startAngle: 4 / 5 * 3.14,
            arcLength: 7 / 5 * 3.14));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData(
      int number) {
    final data = [
      new GaugeSegment('1', 1, number),
      new GaugeSegment('2', 1, number),
      new GaugeSegment('3', 1, number),
      new GaugeSegment('4', 1, number),
      new GaugeSegment('5', 1, number),
      new GaugeSegment('6', 1, number),
      new GaugeSegment('7', 1, number),
      new GaugeSegment('8', 1, number),
      new GaugeSegment('9', 1, number),
      new GaugeSegment('10', 1, number),
      new GaugeSegment('11', 1, number),
      new GaugeSegment('12', 1, number),
      new GaugeSegment('13', 1, number),
      new GaugeSegment('14', 1, number),
      new GaugeSegment('15', 1, number),
      new GaugeSegment('16', 1, number),
      new GaugeSegment('17', 1, number),
      new GaugeSegment('18', 1, number),
      new GaugeSegment('19', 1, number),
      new GaugeSegment('20', 1, number),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        fillColorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  static int count = 0;
  final String segment;
  final int size;
  int val;
  var color;
  int get counter => val;

  GaugeSegment(this.segment, this.size, this.val) {
    count++;
    if (count <= val) {
      color = charts.MaterialPalette.red.shadeDefault;
    } else {
      color = charts.MaterialPalette.black;
    }
    if (count >= 20) {
      count = 0;
    }
  }
}
