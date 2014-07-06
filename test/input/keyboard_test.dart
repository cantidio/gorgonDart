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
      Completer on_down= new Completer();
      keyboard.onKeyDown.listen( (_) => on_down.complete() );

      window.dispatchEvent( new KeyboardEvent("keydown") );
      return on_down.future;
    });

    test("When a key is released the Keyup event must be called",(){
      Completer on_up= new Completer();
      keyboard.onKeyUp.listen( (_) => on_up.complete() );

      window.dispatchEvent( new KeyboardEvent("keyup") );
      return on_up.future;
    });

  });
}
