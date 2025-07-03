import 'dart:io';
import 'package:flutter/services.dart';

Future<bool> hasExactAlarmPermission() async {
  if (Platform.isAndroid) {
    const platform = MethodChannel('dexterous.com/flutter/local_notifications');
    try {
      final result = await platform.invokeMethod('areExactAlarmsPermitted');
      return result == true;
    } catch (e) {
      print('❌ Erreur lors de la vérification de la permission exact alarm : $e');
    }
  }
  return true; // iOS ou Android < 12
}
