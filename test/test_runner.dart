/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';

import 'point2d_test.dart'        as point2d_test;
import 'mirroring_test.dart'      as mirroring_test;
import 'color_test.dart'          as color_test;
import 'sprite_test.dart'         as sprite_test;
import 'spritepack_test.dart'     as spritepack_test;
import 'display_test.dart'        as display_test;
import 'font_alignment_test.dart' as font_alignment_test;
import 'font_test.dart'           as font_test;
import 'frame_test.dart'          as frame_test;
import 'animation_test.dart'      as animation_test;
import 'animationpack_test.dart'  as animationpack_test;
import 'animator_test.dart'       as animator_test;
import 'audio/audio.dart' as audio;
import 'keyboard_test.dart'       as keyboard_test;
import 'mouse_test.dart'          as mouse_test;

main()
{
  useHtmlConfiguration();
  point2d_test.main();
  mirroring_test.main();
  color_test.main();
  display_test.main();
  font_alignment_test.main();
  font_test.main();
  sprite_test.main();
  spritepack_test.main();
  frame_test.main();
  animation_test.main();
  animationpack_test.main();
  animator_test.main();

  audio.main();
  keyboard_test.main();
  mouse_test.main();
}
