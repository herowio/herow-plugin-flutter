import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:herow_plugin_flutter/herow_plugin_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('herow.io/sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getCustomId', () async {
    expect(await HerowPluginFlutter.customId, '42');
  });
  test('start click and collect',() async {
    expect(() => HerowPluginFlutter.launchClickAndCollect(),"");
  });
}
