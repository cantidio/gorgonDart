/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library display_test;

import "dart:html";
import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  group("Display", (){
    Element content;

    setUp((){
      content  = new Element.tag("div");
      content.style.width   = "640px";
      content.style.height  = "480px";
      document.body.append(content);
    });
    tearDown((){
      content.remove();
    });

    test( "Display.target while no display is created is null.", (){
      expect( Display.target, equals( null ) );
    });

    test( "Display.target after a display is created is the first created display.", (){
      Display display = new Display( content );
      expect( Display.target, equals( display ) );
    });

    test( "Display.setAsTarget sets the display as the Display.target.", (){
      Display display = new Display( content );
      Display display2 = new Display( content );
      display2.setAsTarget();
      expect( Display.target, equals( display2 ) );
    });

    test( "Constructor pushes only one element inside the target content", (){
      Display display = new Display( content );
      expect( content.children.length, equals( 1 ) );
    });

    test( "Constructor pushes a canvas element inside the target content", (){
      Display display = new Display( content );
      expect( content.children[0].tagName , equals( "CANVAS" ) );
    });

    test( "Constructor default width value is 300.", (){
      Display display = new Display( content );
      CanvasElement canvas = content.children[0];
      expect( canvas.width , equals( 300 ) );
    });

    test( "Constructor default height value is 150.", (){
      Display display = new Display( content );
      CanvasElement canvas = content.children[0];
      expect( canvas.height , equals( 150 ) );
    });

    test( "Creating Display places a canvas element, with the correct width requested", (){
      Display display = new Display( content, width: 100 );
      CanvasElement canvas = content.children[0];
      expect( canvas.width , equals( 100 ) );
    });

    test( "Creating Display places a canvas element, with the correct height requested", (){
      Display display = new Display( content, height: 200 );
      CanvasElement canvas = content.children[0];
      expect( canvas.height , equals( 200 ) );
    });

    test( "Creating Display larger than the parent Element places a canvas element, with the correct width requested", (){
      Display display = new Display( content, width: 800 );
      CanvasElement canvas = content.children[0];
      expect( canvas.width , equals( 800 ) );
    });

    test( "Creating Display larger than the parent Element places a canvas element, with the correct height requested", (){
      Display display = new Display( content, height: 600 );
      CanvasElement canvas = content.children[0];
      expect( canvas.height , equals( 600 ) );
    });

    test( "Creating Display with width bellow 0 throws an FormatException.", (){
      expect( () => new Display( content, width: -100 ), throwsFormatException );
    });

    test( "Creating Display with height bellow 0 throws an FormatException.", (){
      expect( () => new Display( content, height: -100 ), throwsFormatException );
    });

    test( "Constructor with the stretchToFill=true must generate a canvas with the same width of it's container", (){
      Display display = new Display( content, width:320, height: 240, stretchToFill: true );
      CanvasElement canvas = content.children[0];
      expect( canvas.width , equals( 640 ) );
    });

    test( "Constructor with the stretchToFill=true must generate a canvas with the same height of it's container", (){
      Display display = new Display( content, width:320, height: 240, stretchToFill: true );
      CanvasElement canvas = content.children[0];
      expect( canvas.height , equals( 480 ) );
    });

    test( "Constructor with the stretchToFill = true must have the correct scale value", (){
      Display display = new Display( content, width:320, height: 240, stretchToFill: true );
      expect( display.scale, equals( new Point2D( 2.0, 2.0 ) ) );
    });

    test( "Constructor with the imageSmoothing=true must generate a canvas with context2D.imageSmoothingEnabled = true.", (){
      Display display = new Display( content, imageSmoothing: true );
      CanvasElement canvas = content.children[0];
      expect( canvas.context2D.imageSmoothingEnabled, equals( true ) );
    });

  });


}