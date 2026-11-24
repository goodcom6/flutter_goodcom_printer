import 'package:flutter_test/flutter_test.dart';
import 'package:gcprinter/gcprinter_platform_interface.dart';
import 'package:gcprinter/gcprinter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('$MethodChannelGcprinter is the default instance', () {
    expect(GcprinterPlatform.instance, isInstanceOf<MethodChannelGcprinter>());
  });
}
