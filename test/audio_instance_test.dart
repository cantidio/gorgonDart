/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library audio_instance_test;

import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';

void main()
{
  AudioSystem system;
  group("AudioInstance",(){
    AudioInstance empty;

    setUp((){
      empty = (new Sound()).play();
    });

    test("Default gain is 1.0",(){
      expect( empty.gain, 1.0 );
    });

    test("setting the gain must retain the setted value.",(){
      empty.gain = 0.5;
      expect( empty.gain, 0.5 );
    });

    test("after play the instance it's state must be scheduled.",(){
      empty.play();
      expect( empty.isScheduled, isTrue );
    });

    test("after stop the instance, it's state must be scheduled.",(){
      empty.stop();
      expect( empty.isScheduled, isTrue );
    });

  });
}
