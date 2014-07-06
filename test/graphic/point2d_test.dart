/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
library point_test;

import "package:unittest/unittest.dart";
import 'package:gorgon/gorgon.dart';

void main()
{
  test
  (
      "Point2D.zero member values should result in x=0 and y=0", (){
        Point2D zero = new Point2D.zero();

        expect( zero.x, equals( 0.0 ) );
        expect( zero.y, equals( 0.0 ) );
  });
  test
  (
      "Point2D constructor with null values should result in x=0 and y=0", (){
        Point2D a = new Point2D(null,null);

        expect( a.x, isNot(equals(null)) );
        expect( a.y, isNot(equals(null)) );
        expect( a.x, equals(0.0) );
        expect( a.y, equals(0.0) );
  });
  test
  (
      "Point2D constructor with valid values should keep the right values in it's member attributes.", (){
        Point2D zero = new Point2D(5.0, 10.0);

        expect( zero.x, equals( 5.0 ) );
        expect( zero.y, equals( 10.0 ) );
  });
  test
  (
      "Point2D toString should return a string with the correct values", (){

        expect( new Point2D.zero().toString()     , equals("Point2D(x: 0.0, y: 0.0)") );
        expect( new Point2D(null,null).toString() , equals("Point2D(x: 0.0, y: 0.0)") );
        expect( new Point2D(1.0,2.0).toString()   , equals("Point2D(x: 1.0, y: 2.0)") );
        expect( new Point2D(-1.0,-2.0).toString()   , equals("Point2D(x: -1.0, y: -2.0)") );
  });
  test
  (
      "Point2D distance should calculate the correct distance between two points.", (){
        Point2D a = new Point2D( 10.0, 10.0 );
        Point2D b = new Point2D( 1.0, 1.0 );
        Point2D c = new Point2D( 2.0, 2.0 );

        expect( a.distance(a) , equals(0.0) );
        expect( a.distance(b) , equals(12.727922061357855) );
        expect( a.distance(c) , equals(11.313708498984761) );

        expect( b.distance(a) , equals(12.727922061357855) );
        expect( b.distance(b) , equals(0.0) );
        expect( b.distance(c) , equals(1.4142135623730951) );

        expect( c.distance(a) , equals(11.313708498984761) );
        expect( c.distance(b) , equals(1.4142135623730951) );
        expect( c.distance(c) , equals(0.0) );

  });
  test
  (
      "Point2D Operator ==", (){
        Point2D a = new Point2D( 1.0, 1.0 );
        Point2D b = new Point2D( 1.0, 1.0 );
        Point2D c = new Point2D( 2.0, 2.0 );

        expect( a , equals(a) );
        expect( a , equals(b) );
        expect( b , equals(a) );
        expect( a , isNot(equals(c)) );
        expect( b , isNot(equals(c)) );
  });
  test
  (
      "Point2D operator + should add the values of 2 points and return the correct value.", (){
        Point2D a = new Point2D( 5.0, 10.0 );
        Point2D b = new Point2D( 1.0, 0.0 );
        Point2D c = new Point2D( 0.0, 0.0 );

        expect( a + b, equals(new Point2D( 06.0, 10.0 )) );
        expect( b + a, equals(new Point2D( 06.0, 10.0 )) );
        expect( a + a, equals(new Point2D( 10.0, 20.0 )) );
        expect( b + b, equals(new Point2D( 02.0, 0.0  )) );

        expect( a + c, equals( a ) );
        expect( b + c, equals( b ) );
        expect( c + a, equals( a ) );
        expect( c + b, equals( b ) );
        expect( c + c, equals( c ) );
  });
  test
  (
      "Point2D operator - should substract the values of 2 points and return the correct value.", (){
        Point2D a = new Point2D( 5.0, 10.0 );
        Point2D b = new Point2D( 1.0, 0.0 );
        Point2D c = new Point2D( 0.0, 0.0 );

        expect( a - b, equals(new Point2D( 4.0, 10.0 )) );
        expect( b - a, equals(new Point2D( -4.0, -10.0 )) );
        expect( a - a, equals(new Point2D.zero()) );
        expect( b - b, equals(new Point2D.zero()) );

        expect( a - c, equals( a ) );
        expect( b - c, equals( b ) );
        expect( c - c, equals( c ) );
        expect( c - a, equals( new Point2D( -a.x, -a.y ) ) );
        expect( c - b, equals( new Point2D( -b.x, -b.y ) ) );
  });
  test
  (
      "Point2D operator -Point2D should multiply the object members for -1 and return the correct value.", (){
        Point2D a = new Point2D( 5.0, 10.0 );
        Point2D b = new Point2D( 1.0, 0.0 );
        Point2D c = new Point2D( 0.0, 0.0 );

        expect( -a, equals(new Point2D( -5.0, -10.0 )) );
        expect( -b, equals(new Point2D( -1.0, 0.0 )) );
        expect( -c, equals(new Point2D( 0.0, 0.0 )) );
  });
  test
  (
      "Point2D operator * should multiply the values of 2 points and return the correct value.", (){
        Point2D a = new Point2D( 5.0, 10.0 );
        Point2D b = new Point2D( 1.0, 0.0 );
        Point2D c = new Point2D( 0.0, 0.0 );

        expect( a * a, equals(new Point2D( 25.0, 100.0 )) );
        expect( a * b, equals(new Point2D( 5.0, 0.0 )) );
        expect( a * c, equals(new Point2D( 0.0, 0.0 )) );

        expect( b * a, equals(new Point2D( 5.0, 0.0 )) );
        expect( b * b, equals(new Point2D( 1.0, 0.0 )) );
        expect( b * c, equals(new Point2D( 0.0, 0.0 )) );

        expect( c * a, equals(c) );
        expect( c * b, equals(c) );
        expect( c * c, equals(c) );
  });
  test
  (
      "Point2D operator / should divide the values of 2 points and return the correct value.", (){
        Point2D a = new Point2D( 5.0, 10.0 );
        Point2D b = new Point2D( 1.0, 0.0 );
        Point2D c = new Point2D( 0.0, 0.0 );

        expect( a / a, equals(new Point2D( 1.0, 1.0 )) );
        expect( a / b, equals(new Point2D( 5.0, double.INFINITY )) );
        expect( a / c, equals(new Point2D( double.INFINITY, double.INFINITY )) );

        expect( b / a, equals(new Point2D( 0.2, 0.0 )) );
        /// @todo Correct these tests Once Dart can evaluate NaN == NaN or thrown an exception.
        /*expect( (b / b).y, equals(double.NAN) );
        expect( b / c, equals(new Point2D( double.INFINITY, double.INFINITY)) );

        expect( c / a, equals(new Point2D( 0.0, 0.0 )) );
        expect( c / b, equals(new Point2D( 0.0, double.INFINITY )) );
        expect( c / c, equals(new Point2D( double.INFINITY, double.INFINITY )) );*/
  });

}