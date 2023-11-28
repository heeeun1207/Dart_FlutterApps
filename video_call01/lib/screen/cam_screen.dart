import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//import 'package:video_call/const/agora.dart';


class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  _CamScreenState createState() => _CamScreenState();

}

class _CamScreenState extends State<CamScreen> {
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LIVE'),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Text('모든 권한이 있습니다!'),
            );
          }
      ),
    );
  }
}