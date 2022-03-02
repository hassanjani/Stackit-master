import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PercentagePie extends StatelessWidget {
  final double total;
  final double value;
  final double size;

  PercentagePie({double total, double value, double size = 96})
      : this.total = total < 1.0 ? 1.0 : total,
        this.value = value,
        this.size = size;

  @override
  Widget build(BuildContext context) {
    Color idlecolor = Colors.blueGrey[100];
    Color activecolor = Colors.green;
    double idlevalue;
    double activevalue;

    if (value > total) {
      /* overflow */
      activevalue = value % total;
      idlevalue = total - activevalue;
      if (value < total * 2) {
        activecolor = Colors.red;
        idlecolor = Colors.green;
      } else {
        activecolor = Colors.purple;
        idlecolor = Colors.red;
      }
    } else {
      /* okay */
      idlevalue = total - value;
      activevalue = value;
    }

    print('value ${value} total ${total}');

    return SizedBox(
      height: size,
      width: size,
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                '${(value / total * 100).toInt()}%',
              ),
            ),
            Center(
              child: PieChart(
                PieChartData(
                  startDegreeOffset: 270,
                  sectionsSpace: .5,
                  centerSpaceRadius: size / 2 - 12,
                  borderData: FlBorderData(
                    show: true,
                  ),
                  sections: [
                    PieChartSectionData(
                      color: activecolor,
                      value: activevalue,
                      showTitle: false,
                      radius: 12,
                    ),
                    PieChartSectionData(
                      color: idlecolor,
                      value: idlevalue,
                      showTitle: false,
                      radius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
