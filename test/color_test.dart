/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
library color_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  test
  (
      "Color members value check when using the empty Constructor ", (){
        Color color = new Color();

        expect( color.r, equals( 0 ) );
        expect( color.g, equals( 0 ) );
        expect( color.b, equals( 0 ) );
        expect( color.a, equals( 255 ) );
  });
  test
  (
      "Color members value check when setting the values in the Constructor ", (){
        Color color = new Color( 255, 200, 0, 175 );

        expect( color.r, equals( 255 ) );
        expect( color.g, equals( 200 ) );
        expect( color.b, equals( 0 ) );
        expect( color.a, equals( 175 ) );
  });
  test
  (
      "Color members value check when setting negative values in the Constructor ", (){
        Color color = new Color( -255, 200, 10, -175 );

        expect( color.r, equals( 0 ) );
        expect( color.g, equals( 200 ) );
        expect( color.b, equals( 10 ) );
        expect( color.a, equals( 0 ) );
  });
}