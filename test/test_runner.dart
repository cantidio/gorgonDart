/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
import 'package:unittest/html_config.dart';

import 'graphic/test.dart'       as graphic;
import 'audio/test.dart'         as audio;
import 'input/test.dart'       as input;

main()
{
  useHtmlConfiguration();
  graphic.main();
  audio.main();
  input.main();
}
