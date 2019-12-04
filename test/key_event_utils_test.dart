import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_event_utils/key_event_utils.dart';

void main() {
  const MethodChannel channel = MethodChannel('key_event_utils');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await KeyEventUtils.platformVersion, '42');
  });
}
