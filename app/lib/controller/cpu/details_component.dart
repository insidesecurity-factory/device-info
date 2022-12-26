import 'dart:io';
import 'package:converter/converter.dart';
import 'package:flutter/material.dart';
import '../../domain/physical_cpu.dart';


abstract class Strings{
  String get unknown;
  String get vendorId;
  String get architecture;
  String get minSpeed;
  String get maxSpeed;
  String get currentSpeed;
  String get totalCores;
  String get totalCoresPhysical;
  String get socketType;
  String get voltage;
  String get watts;
  String get temperature;
  String get cache;
}

class _EnglishStrings extends Strings {
  @override String get unknown => 'Unknown';
  @override String get vendorId => 'Vendor id';
  @override String get architecture => 'Architecture';
  @override String get minSpeed => 'Minimal speed';
  @override String get maxSpeed => 'Maximum speed';
  @override String get currentSpeed => 'Current speed';
  @override String get totalCores => 'Total cores';
  @override String get totalCoresPhysical => 'physical';
  @override String get socketType => 'Socket type';
  @override String get voltage => 'Voltage';
  @override String get watts => 'Watts';
  @override String get temperature => 'Temperature';
  @override String get cache => 'Cache';
}

class _SpanishStrings extends Strings {
  @override String get unknown => 'Desconocido';
  @override String get vendorId => 'Id del proveedor';
  @override String get architecture => 'Arquitectura';
  @override String get minSpeed => 'Velocidad mínima';
  @override String get maxSpeed => 'Velocidad máxima';
  @override String get currentSpeed => 'Velocidad actual';
  @override String get totalCores => 'Núcleos totales';
  @override String get totalCoresPhysical => 'físicos';
  @override String get socketType => 'Tipo de socket';
  @override String get voltage => 'Voltaje';
  @override String get watts => 'Watts';
  @override String get temperature => 'Temperatura';
  @override String get cache => 'Caché';
}

class _EsperantoStrings extends Strings {
  @override String get unknown => 'Nekonata';
  @override String get vendorId => 'Vendisto identigilo';
  @override String get architecture => 'Arkitekturo';
  @override String get minSpeed => 'Minimuma rapido';
  @override String get maxSpeed => 'Maksimuma rapido';
  @override String get currentSpeed => 'Nuna rapido';
  @override String get totalCores => 'Totalaj kernoj';
  @override String get totalCoresPhysical => 'fizika';
  @override String get socketType => 'Ingo tipo';
  @override String get voltage => 'Tensio';
  @override String get watts => 'Watts';
  @override String get temperature => 'Temperaturo';
  @override String get cache => 'Kaŝaĵo';
}


class DetailsComponent extends StatefulWidget {

  final Strings _str;
  final PhysicalCPU physicalCPU;

  DetailsComponent({ super.key, required this.physicalCPU }) :
    _str = (() {
      final String languageCode = Platform.localeName.split('_')[0];

      if (languageCode == 'es') {
        return _SpanishStrings();
      } else if (languageCode == 'eo') {
        return _EsperantoStrings();
      } else {
        return _EnglishStrings();
      }
    })();

  @override
  State<DetailsComponent> createState() => _DetailsComponentState();
}

class _DetailsComponentState extends State<DetailsComponent> {

  @override
  Widget build(BuildContext context) {
    final int numTotalCores = widget.physicalCPU.cores.length;
    final int numPhysicalCores = widget.physicalCPU.cores.where((coreCPU) => coreCPU.isPhysical).length;
    final int numVirtualCores = widget.physicalCPU.cores.where((coreCPU) => !coreCPU.isPhysical).length;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: (
            (Theme.of(context).brightness == Brightness.light) ?
            Colors.lightBlueAccent.withOpacity(0.1) :
            Colors.greenAccent.withOpacity(0.02)
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9.0))
        ),
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Row(
          children: [
            Expanded(
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                },
                // defaultColumnWidth: IntrinsicColumnWidth(),
                border: TableBorder(
                  horizontalInside: BorderSide(
                    width: 1,
                    color: (
                      (Theme.of(context).brightness == Brightness.light) ?
                      Colors.lightBlueAccent.withOpacity(0.4) :
                      Colors.greenAccent.withOpacity(0.2)
                    )
                  )
                ),
                children: Map.from({
                  widget._str.vendorId: widget.physicalCPU.vendorId,
                  widget._str.architecture: '${widget.physicalCPU.architecture.code} (${widget.physicalCPU.architecture.bits.toString()} bits)',
                  widget._str.totalCores: '$numTotalCores ($numPhysicalCores ${widget._str.totalCoresPhysical})',
                  widget._str.socketType: (widget.physicalCPU.socketType != null) ? '${widget.physicalCPU.socketType}nm' : widget._str.unknown,
                  widget._str.voltage: widget._str.unknown, // TODO: Unimplemented.
                  widget._str.watts: widget._str.unknown, // TODO: Unimplemented.
                  widget._str.temperature: widget._str.unknown, // TODO: Unimplemented.
                }).entries.map((entry) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 10.0),
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            Colors.black.withOpacity(0.7) :
                            Colors.white.withOpacity(0.9)
                          )
                        ),
                      ),
                    ),
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(':'),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontWeight: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            FontWeight.bold :
                            FontWeight.normal
                          ),
                          color: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            Colors.black :
                            Colors.greenAccent
                          )
                        )
                      )
                    )
                  ]
                )).toList()
              ),
            ),
            Expanded(
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                },
                // defaultColumnWidth: IntrinsicColumnWidth(),
                border: TableBorder(
                  horizontalInside: BorderSide(
                    width: 1,
                    color: (
                      (Theme.of(context).brightness == Brightness.light) ?
                      Colors.lightBlueAccent.withOpacity(0.4) :
                      Colors.greenAccent.withOpacity(0.2)
                    )
                  )
                ),
                children: Map.from({
                  widget._str.minSpeed: '${Frequency(widget.physicalCPU.minFrequency, 'Hz').valueIn('GHz').toStringAsFixed(1)} Ghz',
                  widget._str.maxSpeed: '${Frequency(widget.physicalCPU.maxFrequency, 'Hz').valueIn('GHz').toStringAsFixed(1)} Ghz',
                  widget._str.currentSpeed: '${Frequency(widget.physicalCPU.currentFrequency, 'Hz').valueIn('GHz').toStringAsFixed(2)} Ghz',
                  '${widget._str.cache} L1 Data': (widget.physicalCPU.cache.level1Data != null) ? '${widget.physicalCPU.cache.level1Data! ~/ 1024} KB' : '0 Bytes',
                  '${widget._str.cache} L1 Insert': (widget.physicalCPU.cache.level1Insert != null) ? '${widget.physicalCPU.cache.level1Insert! ~/ 1024} KB' : '0 Bytes',
                  '${widget._str.cache} L2': (widget.physicalCPU.cache.level2 != null) ? '${widget.physicalCPU.cache.level2! ~/ 1024} KB' : '0 Bytes',
                  '${widget._str.cache} L3': (widget.physicalCPU.cache.level3 != null) ? (
                      (widget.physicalCPU.cache.level3! > (1024 * 1024)) ?
                      '${widget.physicalCPU.cache.level3! ~/ (1024 * 1024)} MB' :
                      '${widget.physicalCPU.cache.level3! ~/ 1024} KB'
                  ) : '0 Bytes',
                }).entries.map((entry) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 10.0),
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            Colors.black.withOpacity(0.7) :
                            Colors.white.withOpacity(0.9)
                          )
                        ),
                      ),
                    ),
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(':'),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontWeight: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            FontWeight.bold :
                            FontWeight.normal
                          ),
                          color: (
                            (Theme.of(context).brightness == Brightness.light) ?
                            Colors.black :
                            Colors.greenAccent
                          )
                        )
                      )
                    )
                  ]
                )).toList()
              ),
            )
          ],
        )
      )
    );
  }
}