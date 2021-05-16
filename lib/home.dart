import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final regions = <Region>[];
  String accuracy = "";
  String proximity = "";
  StreamSubscription<RangingResult> _streamRanging;

  @override
  void initState() {
    super.initState();
    initializeBeacon();
  }

  @override
  void dispose() {
    _streamRanging.cancel();
    super.dispose();
  }

  void initializeBeacon() async {
    try {
      final isScaning = await flutterBeacon.initializeAndCheckScanning;
      print(isScaning);

      startBeaconScan();
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print(e);
    }
  }

  void startBeaconScan() {
    if (Platform.isIOS) {
      // iOS platform, at least set identifier and proximityUUID for region scanning
      regions.add(
        Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0',
          major: 123,
          minor: 321,
        ),
      );
    } else {
      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      regions.add(Region(identifier: 'com.beacon'));
    }

// to start ranging beacons
    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
      if (result.beacons.isNotEmpty) {
        final beacon = result.beacons.first;
        setState(() {
          this.accuracy = "${beacon.accuracy}";
          this.proximity = beacon.proximityUUID;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(proximity),
            Text(accuracy),
          ],
        ),
      ),
    );
  }
}
