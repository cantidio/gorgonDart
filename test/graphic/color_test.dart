/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library color_test;

import "package:unittest/unittest.dart";
import "package:gorgon/gorgon.dart";

void main()
{
  test( "Color members value check when using the empty Constructor ", (){
    Color color = new Color();

    expect( color.r, equals( 0 ) );
    expect( color.g, equals( 0 ) );
    expect( color.b, equals( 0 ) );
    expect( color.a, equals( 255 ) );

  });

  test( "Color members value check when setting the values in the Constructor ", (){
    Color color = new Color( r: 255, g: 200, b: 0, a: 175 );

    expect( color.r, equals( 255 ) );
    expect( color.g, equals( 200 ) );
    expect( color.b, equals( 0 ) );
    expect( color.a, equals( 175 ) );
  });

  test( "Color members value check when setting negative values in the Constructor ", (){
    Color color = new Color( r:-255, g:200, b:10, a:-175 );

    expect( color.r, equals( 0 ) );
    expect( color.g, equals( 200 ) );
    expect( color.b, equals( 10 ) );
    expect( color.a, equals( 0 ) );
  });
  test( "Color members value check when setting values over 255 in the Constructor ", (){
    Color color = new Color( r: 255, g:400, b:100, a: 750 );

    expect( color.r, equals( 255 ) );
    expect( color.g, equals( 255 ) );
    expect( color.b, equals( 100 ) );
    expect( color.a, equals( 255 ) );
  });

  test( "Color getter r", (){
    Color red = new Color( r: 255 );

    expect( red.r, equals( 255 ) );
  });

  test( "Color getter g", (){
    Color green = new Color( g: 255 );

    expect( green.g, equals( 255 ) );
  });

  test( "Color getter b", (){
    Color blue = new Color( b: 255 );

    expect( blue.b, equals( 255 ) );
  });

  test( "Color getter a", (){
    Color alpha = new Color( a: 255 );

    expect( alpha.a, equals( 255 ) );
  });

  test( "Color setter r normal value", (){
    Color red = new Color();
    red.r = 255;

    expect( red.r, equals( 255 ) );
  });

  test( "Color setter r negative value", (){
    Color red = new Color();
    red.r = -255;

    expect( red.r, equals( 0 ) );
  });

  test( "Color setter r value over 255", (){
    Color red = new Color();
    red.r = 355;

    expect( red.r, equals( 255 ) );
  });

  test( "Color setter g normal value", (){
    Color green = new Color();
    green.g = 255;

    expect( green.g, equals( 255 ) );
  });

  test( "Color setter g negative value", (){
    Color green = new Color();
    green.g = -255;

    expect( green.g, equals( 0 ) );
  });

  test( "Color setter g value over 255", (){
    Color green = new Color();
    green.g = 355;

    expect( green.g, equals( 255 ) );
  });

  test( "Color setter b normal value", (){
    Color blue = new Color();
    blue.b = 255;

    expect( blue.b, equals( 255 ) );
  });

  test( "Color setter b negative value", (){
    Color blue = new Color();
    blue.b = -255;

    expect( blue.b, equals( 0 ) );
  });

  test( "Color setter b value over 255", (){
    Color blue = new Color();
    blue.b = 355;

    expect( blue.b, equals( 255 ) );
  });

  test( "Color setter a normal value", (){
    Color alpha = new Color();
    alpha.a = 255;

    expect( alpha.a, equals( 255 ) );
  });

  test( "Color setter a negative value", (){
    Color alpha = new Color();
    alpha.a = -255;

    expect( alpha.a, equals( 0 ) );
  });

  test( "Color setter a value over 255", (){
    Color alpha = new Color();
    alpha.a = 355;

    expect( alpha.a, equals( 255 ) );
  });

  test( "Color Operator ==", (){
    Color colorA = new Color( r:50, g:100, b: 150, a: 200 );
    Color colorB = new Color( r:50, g:100, b: 150, a: 200 );

    expect( colorA, equals( colorB ) );
  });

  test( "Color Operator +", (){
    Color colorA = new Color( r:100, g:100 );
    Color colorB = new Color( r:100, b:150 );

    expect( colorA + colorB, equals( new Color( r: 200, g: 100, b: 150 ) ) );
  });

  test( "Color Operator + with values that surpass 255", (){
    Color colorA = new Color( r:150, g:150, b: 150, a: 255 );
    Color colorB = new Color( r:150, g:150, b: 150, a: 255 );

    expect( colorA + colorB, equals( new Color( r: 255, g: 255, b: 255, a: 255 ) ) );
  });

  test( "Color Operator -", (){
    Color colorA = new Color( r:100, g:100 );
    Color colorB = new Color( r:100, g:10 );

    expect( colorA - colorB, equals( new Color( r: 0, g: 90, b: 0, a: 0 ) ) );
  });

  test( "Color Operator - with values when subbed become less than 0", (){
    Color colorA = new Color( r:150, g:150, b: 150, a: 150 );
    Color colorB = new Color( r:250, g:250, b: 250, a: 255 );

    expect( colorA - colorB, equals( new Color( r: 0, g: 0, b: 0, a: 0 ) ) );
  });

}
