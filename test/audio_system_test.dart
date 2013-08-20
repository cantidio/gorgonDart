/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library audio_system_test;

import 'package:unittest/unittest.dart';
import 'package:gorgon/gorgon.dart';

void main()
{
  AudioSystem system;
  group("AudioSystem",(){

    test("Every instance of the AudioSystem must be the same.", (){
      AudioSystem system1 = new AudioSystem();
      AudioSystem system2 = new AudioSystem();

      expect( system2, system1 );
    });

    test("The AudioSystem must have a default channel.",(){
      AudioSystem system = new AudioSystem();

      expect( system.channel("default"), isNotNull );
    });

    // This test must be executed before all other tests that changes the target Channel.
    test("The AudioSystem targetChannel must be the default channel.",(){
      AudioSystem system = new AudioSystem();

      expect( system.targetChannel, system.channel("default") );
    });

    test("Every channel created must be registered in the System.",(){
      AudioChannel channel1 = new AudioChannel("Channel-1");
      AudioChannel channel2 = new AudioChannel("Channel-2");
      AudioSystem  system   = new AudioSystem();

      expect( system.channel("Channel-1"), channel1 );
      expect( system.channel("Channel-2"), channel2 );
    });

  });
}
