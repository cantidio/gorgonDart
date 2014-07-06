/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';

import 'graphic/test.dart'       as graphic;
import 'audio/test.dart'         as audio;
import 'keyboard_test.dart'       as keyboard_test;
import 'mouse_test.dart'          as mouse_test;

main()
{
  useHtmlConfiguration();
  graphic.main();
  audio.main();
  keyboard_test.main();
  mouse_test.main();
}
