import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final regions = <Region>[];

  @override
  void initState() {
    super.initState();
    initializeBeacon();
  }

  void initializeBeacon() async {
    try {
      // if you want to manage manual checking about the required permissions
      //await flutterBeacon.initializeScanning;

      // or if you want to include automatic checking permission
      final isScaning = await flutterBeacon.initializeAndCheckScanning;
      print(isScaning);
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
