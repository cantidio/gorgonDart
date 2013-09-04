/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library keyboard_test;

import 'dart:async';
import 'dart:html';
import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  group("Keyboard",(){
    Keyboard keyboard;

    setUp((){
      keyboard = new Keyboard();
    });

    test("When a keyboard is created, no one key must be pressed.",(){
      expect(keyboard.pressedKeys.length, 0);
    });

    test("When a key is pressed the KeyPress event must be called",(){
      keyboard.onKeyDown.listen( expectAsync1( (_){}, count: 1 ));

      window.dispatchEvent( new KeyboardEvent("keydown") );
    });

    test("When a key is released the Keyup event must be called",(){
      keyboard.onKeyUp.listen( expectAsync1( (_){}, count: 1 ));

      window.dispatchEvent( new KeyboardEvent("keyup") );
    });

  });
}
