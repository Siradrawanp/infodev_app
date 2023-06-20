import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/device_info.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});
  
  @override
  State<PageB> createState() => _PageBState();

}

class _PageBState extends State<PageB> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  //final Map<String, dynamic> _readWebBrowserInfo = _readWebBrowserInfo(WebBrowserInfo);

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        deviceData = switch (defaultTargetPlatform) {
          TargetPlatform.android => readAndroidBuildData(await deviceInfoPlugin.androidInfo),
          TargetPlatform.iOS => readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
          TargetPlatform.linux => readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
          TargetPlatform.macOS => readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
          TargetPlatform.windows => readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
          TargetPlatform.fuchsia => <String, dynamic>{'Error:':'Fuchsia platform not supported'}
        };
      }
    } on PlatformException {
      deviceData = <String, dynamic> {'Error:':'Failed to get platform version'};
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }


  @override
  void initState(){
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _deviceData.keys.map(
        (String property) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      property,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //padding: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${_deviceData[property]}',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          );
        }
      ).toList(),
    );
  }
}