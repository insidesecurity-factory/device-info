import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/cpu_core.dart';

abstract class Strings {
  String get core;
}

class _EnglishStrings extends Strings {
  @override String get core => 'CORE';
}

class _SpanishStrings extends Strings {
  @override String get core => 'NÚCLEO';
}

class _EsperantoStrings extends Strings {
  @override String get core => 'NUKLEO';
}

class CoresMonitorComponent extends StatefulWidget {

  final Strings _str;
  final List<CPUCore> cores;

  CoresMonitorComponent({ super.key, required this.cores }) :
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
  State<CoresMonitorComponent> createState() => _CoresMonitorComponentState();
}

class _CoresMonitorComponentState extends State<CoresMonitorComponent> {

  @override
  Widget build(BuildContext context) {

    // Rows widgets
    List<Row> rows = <Row> [ ];

    // Calculate responsive rows/cols
    int maxWidthPeerCore = 100;
    double screenWidth = MediaQuery.of(context).size.width;
    int totalWidth = widget.cores.length * maxWidthPeerCore;
    int totalRows = (totalWidth / screenWidth).ceil();
    int totalColumns = (screenWidth / maxWidthPeerCore).floor();

    // Fix padding overflow count
    if((totalColumns * totalRows) < widget.cores.length) {
      totalRows += 1;
    }

    for(int rowId = 0; rowId <= (totalRows - 1); rowId++) {
      final int fromList = rowId * totalColumns;
      final int toList = ((fromList + totalColumns) > widget.cores.length) ? widget.cores.length : (fromList + totalColumns);

      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.cores.sublist(fromList, toList).map((cpuCore) => Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: (cpuCore.usagePercent != null) ? (
                  (cpuCore.usagePercent! < 80.0) ?
                    (
                      (cpuCore.usagePercent! > 50) ?
                      Colors.amber :
                      Colors.greenAccent
                    ) :
                    Colors.red
                ) :
                Colors.lightGreenAccent,
                borderRadius: const BorderRadius.all(Radius.circular(3.0))
            ),
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 7.0, bottom: 7.0),
            margin: const EdgeInsets.only(left: 3.0, right: 3.0, top: 3.0, bottom: 3.0),
            child: Column(
              children: [
                Text(
                  '${widget._str.core} ${cpuCore.id}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  (cpuCore.usagePercent != null) ?
                    '${cpuCore.usagePercent!.toStringAsFixed(2)}%' :
                    '0.00%',
                  style: TextStyle(color: Colors.black.withOpacity(0.8))
                )
              ],
            )
          )
        )).toList()
      ));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(9.0)),
        border: Border.all(
          color: Colors.greenAccent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
      margin: const EdgeInsets.only(top: 5, bottom: 6),
      child: Column(children: rows)
    );
  }
}