
import 'package:flutter/services.dart';

class PlatformRepository {
  static const channelName = 'channel_example';
  static const platform = MethodChannel(channelName);
  static const changeColorFunction = "changeColor";
  static const keyChangeColor = "color";

  Future<String> changeColor(String color) async {
    try {
      final String result = await platform.invokeMethod(changeColorFunction, {
        keyChangeColor: color,
      });
      print('RESULT -> $result');
      color = result;
    } on PlatformException catch (e) {
      print(e);
    }
    return color;
  }
}