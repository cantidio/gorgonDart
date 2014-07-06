/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library mouse_test;

import 'dart:async';
import 'dart:html';
import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  group("Mouse",(){
    Mouse mouse;

    setUp((){
      mouse = new Mouse();
    });

    test("When a mouse is created, no one button must be pressed.",(){
      expect(mouse.pressedButtons.length, 0);
    });

    test("When a Button is pressed, the stream onButtonDown must trigger.",(){
      Completer on_down= new Completer();
      mouse.onButtonDown.listen( (_) => on_down.complete() );

      window.dispatchEvent( new MouseEvent("mousedown") );
      return on_down.future;
    });

    test("When a button is released, the stream onButtonUp must trigger.",(){
      Completer on_up = new Completer();
      mouse.onButtonUp.listen( (_) => on_up.complete() );

      window.dispatchEvent( new MouseEvent("mouseup") );
      return on_up.future;
    });

    test("When the mouse moves, the stream onMove must trigger.",(){
      Completer on_move = new Completer();
      mouse.onMove.listen( (_) => on_move.complete() );

      window.dispatchEvent( new MouseEvent("mousemove") );
      return on_move.future;
    });

  });
}
