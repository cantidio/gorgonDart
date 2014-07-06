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
    AudioInstance instance;

    setUp((){
      Sound sound = new Sound(soundUrl: "resources/chico/attack.wav");
      return sound.onLoad.then((_)=> instance = sound.play());
    });

    test("Default gain is 1.0",(){
      expect( instance.gain, 1.0 );
    });

    test("setting the gain must retain the setted value.",(){
      instance.gain = 0.5;
      expect( instance.gain, 0.5 );
    });

    test("after play the instance it's state must be playing.",(){
      instance.play();
      expect( instance.isPlaying, isTrue );
    });

    test("after stop the instance, it's state must be stopped.",(){
      instance.stop();
      expect( instance.isStopped, isTrue );
    });

  });
}
