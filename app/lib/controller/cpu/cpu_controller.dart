import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/physical_cpu.dart';
import '../../service/cpu_info.dart';
import 'cores_monitor_component.dart';
import 'details_component.dart';
import 'features_component.dart';
import 'header_component.dart';


abstract class Strings {
  String get unsupportedOSException;
  String get unsupportedOS;
}

class _EnglishStrings extends Strings {
  @override String get unsupportedOSException => 'Unsupported OS Exception';
  @override String get unsupportedOS => 'Unsupported OS';
}

class _SpanishStrings extends Strings {
  @override String get unsupportedOSException => 'Sistema Operativo no soportado';
  @override String get unsupportedOS => 'Sistema Operativo no soportado';
}

class _EsperantoStrings extends Strings {
  @override String get unsupportedOSException => 'Operaciumo ne subtenata';
  @override String get unsupportedOS => 'Operaciumo ne subtenata';
}


class CpuController extends StatefulWidget {

  final Strings _str;
  CpuController({ super.key }) :
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
  State<CpuController> createState() => _CpuControllerState();
}

class _CpuControllerState extends State<CpuController> {

  late Timer _interval;
  final List<List<PhysicalCPU>> _historyPhysicalCPUList = <List<PhysicalCPU>>[ ];
  List<PhysicalCPU>? _physicalCPUList;
  FlutterError? _exception;

  _getPhysicalCPUListWithState() {
    setState(() {
      CpuInfo()
        .getPhysicalCPUList(_physicalCPUList)
        .then((physicalCPUList) {
         _physicalCPUList = physicalCPUList;

         // Add to history of data (for chart)
         _historyPhysicalCPUList.add(physicalCPUList);
         if(_historyPhysicalCPUList.length > 60) { // Only 60 times (1 minute)
           _historyPhysicalCPUList.removeAt(0);
         }
        })
        .catchError((e) {
          _exception = e;
        });
    });
  }

  @override
  void initState() {
    super.initState();

    // Start immediately
    _getPhysicalCPUListWithState();

    // Refresh data each 0.5 second
    _interval = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      _getPhysicalCPUListWithState();
    });
  }

  @override
  void dispose() {
    _interval.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Exception view
    if(_exception != null) {
      if (kDebugMode) {
        print('${widget._str.unsupportedOSException}: $_exception.error.toString()');
      }

      // Stop iteration
      _interval.cancel();

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Icon(Icons.error, size: 60.0)
            ),
            Text(widget._str.unsupportedOS, style: Theme.of(context).textTheme.titleLarge)
          ]
        )
      );

    // Loader view
    } else if (_physicalCPUList == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget> [
              CircularProgressIndicator()
            ]
          )
        )
      );

    // Main content tab view
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _physicalCPUList!.map((physicalCPU) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeaderComponent(
                  physicalCPU: physicalCPU,
                  historyPhysicalCPU: _historyPhysicalCPUList
                    .map((physicalCPUList) => physicalCPUList[physicalCPU.socketId])
                    .toList()
                ),
                CoresMonitorComponent(cores: physicalCPU.cores),
                DetailsComponent(physicalCPU: physicalCPU),
                FeaturesComponent(physicalCPU: physicalCPU)
              ]
            )).toList()
          )
        )
      );
    }
  }
}
