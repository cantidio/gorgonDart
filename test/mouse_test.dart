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
      mouse.onButtonDown.listen( expectAsync1( (_){}, count: 1 ));

      window.dispatchEvent( new MouseEvent("mousedown") );
    });

    test("When a button is released, the stream onButtonUp must trigger.",(){
      mouse.onButtonUp.listen( expectAsync1( (_){}, count: 1 ));

      window.dispatchEvent( new MouseEvent("mouseup") );
    });

    test("When the mouse moves, the stream onMove must trigger.",(){
      mouse.onMove.listen( expectAsync1( (_){}, count: 1 ));

      window.dispatchEvent( new MouseEvent("mousemove") );
    });

  });
}
