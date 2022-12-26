import 'dart:io';
import 'package:converter/converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/physical_cpu.dart';

abstract class Strings {
  String get cores;
}

class _EnglishStrings extends Strings {
  @override String get cores => 'Cores';
}

class _SpanishStrings extends Strings {
  @override String get cores => 'Núcleos';
}

class _EsperantoStrings extends Strings {
  @override String get cores => 'Kernoj';
}

class HeaderComponent extends StatefulWidget {

  final Strings _str;
  final PhysicalCPU physicalCPU;
  final List<PhysicalCPU> historyPhysicalCPU;

  HeaderComponent({ super.key, required this.physicalCPU, required this.historyPhysicalCPU }) :
    _str = ((){
      final String languageCode = Platform.localeName.split('_')[0];

      if(languageCode == 'es') {
        return _SpanishStrings();

      } else if(languageCode == 'eo') {
        return _EsperantoStrings();

      } else {
        return _EnglishStrings();
      }
    })();

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // Hide overflow
      decoration: BoxDecoration(
        color: (
          (Theme.of(context).brightness == Brightness.light) ?
          Colors.lightBlueAccent :
          Colors.greenAccent
        ),
        borderRadius: const BorderRadius.all(Radius.circular(9.0))
      ),
      margin: const EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: widget.physicalCPU.cores.map((coreCPU) => SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: false,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.transparent,
                        strokeWidth: 0,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: Colors.transparent,
                        strokeWidth: 0,
                      )
                    ),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: LineTouchData(enabled: false),
                    minX: 0,
                    maxX: 59,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.historyPhysicalCPU.map((physicalCPUInPast) => FlSpot(
                            widget.historyPhysicalCPU.indexOf(physicalCPUInPast).toDouble(),
                          (physicalCPUInPast.cores[coreCPU.id].usagePercent == null) ?
                          0.0 :
                          physicalCPUInPast.cores[coreCPU.id].usagePercent!
                        )).toList(),
                        isCurved: true,
                        color: Colors.white.withOpacity(
                          ((1.0 - (coreCPU.id / 10)) < 0.0) ?
                          0.0 :
                          (1.0 - (coreCPU.id / 10))
                        ),
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false)
                      ),
                    ],
                  )
                )
              )).toList()
            )
          ),
          Column(
            children: [
              Center(
                child: Icon(
                  Icons.memory_outlined,
                  size: 100,
                  color: Colors.black.withOpacity(0.8)
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Center(
                  child: Text(
                      widget.physicalCPU.modelName,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 20
                    )
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Center(
                  child: Text(
                    '${Frequency(widget.physicalCPU.maxFrequency, 'Hz').valueIn('GHz').toStringAsFixed(1)} Ghz - ${(widget.physicalCPU.cores.length / 2).floor()}x2 ${widget._str.cores} (${widget.physicalCPU.architecture.bits} bits)',
                    style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15)
                  )
                )
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: (
                (Theme.of(context).brightness == Brightness.light) ?
                Colors.black.withOpacity(0.07) :
                Colors.black.withOpacity(0.15)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0, bottom: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '00 Cº', // TODO: Unimplemented.
                      style: TextStyle(
                        color: (
                          (Theme.of(context).brightness == Brightness.light) ?
                          Colors.white :
                          Colors.black.withOpacity(0.8)
                        ),
                        fontSize: 30,
                        fontWeight: FontWeight.normal
                      )
                    ),
                  ),
                  Expanded(
                    child: Text(
                      (widget.physicalCPU.percentUsage != null) ? '${widget.physicalCPU.percentUsage!.toStringAsFixed(1)} %' : '0.0 %',
                      style: TextStyle(
                        color: (
                          (Theme.of(context).brightness == Brightness.light) ?
                          Colors.white :
                          Colors.black.withOpacity(0.8)
                        ),
                        fontSize: 30,
                        fontWeight: FontWeight.normal
                      ),
                      textAlign: TextAlign.end,
                    )
                  )
                ]
              )
            )
          )
        ]
      ),
    );
  }
}