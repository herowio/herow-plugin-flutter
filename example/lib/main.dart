import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:herow_plugin_flutter/herow_plugin_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _customId = 'Unknown';
  bool _isClickAndCollect = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initHerow();
  }

  Future<void> initHerow() async {
    await HerowPluginFlutter.initialize(
        "PRE_PROD", "SDK_ID", "SDK_KEY");
    await HerowPluginFlutter.setCustomId("FlutterIos");
    HerowPluginFlutter.customId.then((value) => setState(() {
          _customId = value;
        }));
  

    await Permission.location.request().isGranted;
    await Permission.notification.request().isGranted;
    await Permission.appTrackingTransparency.request().isGranted;

    HerowPluginFlutter.acceptOptin();
    HerowPluginFlutter.isOnClickAndCollect().then((value) => setState(() {
          _isClickAndCollect = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Herow sdk example app')),
        ),
        body: displayTab(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Click&Collect',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.blue,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget displayTab() {
    if (_selectedIndex == 0) {
      return Center(
          child: Text(
        'User id is :$_customId',
      ));
    } else if (_selectedIndex == 1) {
      if (_isClickAndCollect) {
        return TextButton(
          onPressed: () => stopClickAndCollect(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.stop),
                Text("Click&Collect"),
              ],
            ),
          ),
        );
      } else {
        return TextButton(
          onPressed: () => launchClickAndCollect(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow),
                Text("Click&Collect"),
              ],
            ),
          ),
        );
      }
    }
    return Container();
  }

  void launchClickAndCollect() async {
       if (await Permission.location.request().isGranted) {
      await HerowPluginFlutter.launchClickAndCollect();
      HerowPluginFlutter.isOnClickAndCollect().then(
        (value) => setState(() {
          _isClickAndCollect = value;
        }),
      );
    }
  }

  void stopClickAndCollect() async {
    await HerowPluginFlutter.stopClickAndCollect();
    HerowPluginFlutter.isOnClickAndCollect().then(
      (value) => setState(() {
        _isClickAndCollect = value;
      }),
    );
  }
}
