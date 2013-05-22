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
    
    test( "loading an existent font, must create a element in the document.head",(){
      String file = "resources/TranscendsGames.otf";
      int child   = document.head.children.length;
      
      font2.load( file ).then( expectAsync1((_) {
        expect( document.head.children.length, equals( child+1 ) );
      }));      
    });
    
    test( "loading an existent font, must create a element of the type STYLE in the document.head",(){
      String file = "resources/TranscendsGames.otf";
      int child   = document.head.children.length;
      
      font2.load( file ).then( expectAsync1((_) {
        expect( document.head.children[child].tagName, equals( "STYLE" ) );
      }));
    });
    
    test( "loading an existent font, must create a element of the type @font-face inside the STYLE created",(){
      String file = "resources/TranscendsGames.otf";
      int child   = document.head.children.length;
      
      font2.load( file ).then( expectAsync1((_) {
        expect( document.head.children[child].nodes[0].toString().substring(0,10), equals( "@font-face" ) );
      }));
    });
    
    test( "loading an existent font, must create a element of the type @font-face with the family expected",(){
      String file = "resources/TranscendsGames.otf";
      int child   = document.head.children.length;
      
      font2.load( file ).then( expectAsync1((_) {
        expect( document.head.children[child].nodes[0].toString().substring(26,26+font2.family.length), equals( font2.family ) );
      }));
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