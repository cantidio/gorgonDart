/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library font_test;

import "dart:html";
import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  group("Font", (){
    Font font1, font2;
    setUp((){
      font1 = new Font();
      font2 = new Font(alignment: FontAlignment.center, size: 30);
    });
    
    test( "Empty Constructor Generates Empty Font.family string", (){
      expect( font1.family, equals( "" ) );
    });
    
    test( "Empty Constructor Generates Font.size = 12", (){
      expect( font1.size, equals( 12 ) );
    });
    
    test( "Empty Constructor Generates Font.alignment = FontAlignment.left", (){
      expect( font1.alignment, equals( FontAlignment.left ) );
    });
    
    test( "Set the size in the Constructor, returns the desired size",(){
      expect( font2.size, equals( 30 ) );
    });
    
    test( "Set the alignment in the Constructor, returns the desired alignment",(){
      expect( font2.alignment, equals( FontAlignment.center) );
    });
    
    test( "Try to load an inexistent font returns an exception",(){
      String file = "this_font_donot_exist.ttf";
      font2.load( file ).catchError( expectAsync1((e) {
        expect( e.toString(), equals( new Exception("Timeout loading font: "+file ).toString() ) );
      }));      
    });
    
    test( "Try to load an inexistent font, should not leave a style element in the document.head.",(){
      String file = "this_font_donot_exist.ttf";
      int child   = document.head.children.length;
      
      font2.load( file ).catchError( expectAsync1((e) {
        expect( document.head.children.length, equals( child ) );
      }));
    });
    
  });
}