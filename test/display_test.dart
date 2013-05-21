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



  });


}