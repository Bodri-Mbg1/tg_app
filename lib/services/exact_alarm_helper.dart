import 'dart:io';
import 'package:flutter/services.dart';

class ExactAlarmHelper {
  static const MethodChannel _channel = MethodChannel('exact_alarm_permission');

  static Future<bool> hasExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;
    try {
      final bool result = await _channel.invokeMethod('hasExactAlarmPermission');
      return result;
    } catch (e) {
      print('Erreur lors de la vérification de la permission Exact Alarm : $e');
      return false;
    }
  }
}
