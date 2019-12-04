import 'dart:async';

import 'package:flutter/services.dart';

export 'package:key_event_utils/tce/tce_key_event_utils.dart' ;
export 'package:key_event_utils/tce/scan_utils.dart' ;

class KeyEventUtils {
  static const MethodChannel _channel =
      const MethodChannel('key_event_utils');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
