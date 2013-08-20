/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library audio_channel_test;

import 'dart:async';
import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';

void main()
{
  AudioChannel channel1;
  group("AudioChannel",(){
    Sound sound;
    AudioChannel channel1;
    AudioChannel channel2;
    AudioSystem system;

    setUp((){
      system   = new AudioSystem();
      channel1 = new AudioChannel("Channel-1");
      channel2 = new AudioChannel("Channel-2");
      sound    = new Sound(channel: channel1 );
    });

    test("When creating a AudioChannel it must be shown in the AudioSystem.",(){
      expect( system.channel("Channel-1"), channel1);
    });

    test("When creating a new channel, it's Gain must be 1.0", (){
      expect( channel1.gain, 1.0 );
    });

    test("When creating a new channel, it must not be muted.", (){
      expect( channel1.mute, false );
    });

    test("When creating a new channel, it must return 0 instances as being used.", (){
      expect( channel1.instances, 0 );
    });

    test("After using setAsTarget, the AudioChannel must be the target AudioChannel in the AudioSystem.", (){
      channel1.setAsTarget();
      expect( system.targetChannel, channel1 );
      channel2.setAsTarget();
      expect( system.targetChannel, channel2 );
    });

    test("When playing a sound in a channel, the instance must be registered in the channel.", (){
      int before = channel1.instances;
      sound.play();
      expect( channel1.instances, before + 1);
    });

  });
}
