/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library sound_test;

import 'dart:async';
import "package:unittest/unittest.dart";

import 'package:gorgon/gorgon.dart';

void main()
{
  group("Sound",(){

    test("Empty constructor, channel is AudioSystem.targetChannel",(){

      Sound sound = new Sound();
      expect( sound.channel, equals( new AudioSystem().targetChannel ) );
    });

    test("Empty constructor, duration is 0.0",(){

      Sound sound = new Sound();
      expect( sound.duration, equals( 0.0 ) );
    });

    test("Empty constructor, gain is 0.0",(){

      Sound sound = new Sound();
      expect( sound.gain, equals( 0.0 ) );
    });


  });
}