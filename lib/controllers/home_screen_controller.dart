import 'package:flutter/foundation.dart ' show kIsWeb;
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyHomeScreenController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  

  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
    }
  }
}
