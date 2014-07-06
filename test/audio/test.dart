library audio_module_test;

import 'audio_instance_test.dart' as audio_instance_test;
import 'sound_test.dart'          as sound_test;
import 'audio_channel_test.dart'  as audio_channel_test;
import 'audio_system_test.dart'   as audio_system_test;
import 'package:unittest/unittest.dart';

main() {
  group("audio:",(){
    audio_system_test.main();
      audio_channel_test.main();
      audio_instance_test.main();
      sound_test.main();
  });
}