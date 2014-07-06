library input_module_test;

import 'keyboard_test.dart' as keyboard_test;
import 'mouse_test.dart'    as mouse_test;
import 'package:unittest/unittest.dart';

main() {
  group("input:",(){
    keyboard_test.main();
    mouse_test.main();
  });
}