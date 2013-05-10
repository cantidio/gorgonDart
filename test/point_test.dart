/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
library point_test;

import "package:unittest/unittest.dart";
import '../src/gorgon.dart';

void main()
{
  test
  (
      "Point.zero member values should result in x=0 and y=0", (){
        Point zero = new Point.zero();

        expect( zero.x, equals( 0.0 ) );
        expect( zero.y, equals( 0.0 ) );
  });
  test
  (
      "Point constructor with null values should result in x=0 and y=0", (){
        Point a = new Point(null,null);

        expect( a.x, isNot(equals(null)) );
        expect( a.y, isNot(equals(null)) );
        expect( a.x, equals(0.0) );
        expect( a.y, equals(0.0) );
  });
  test
  (
      "Point constructor with valid values should keep the right values in it's member attributes.", (){
        Point zero = new Point(5.0, 10.0);

        expect( zero.x, equals( 5.0 ) );
        expect( zero.y, equals( 10.0 ) );
  });
  test
  (
      "Point toString should return a string with the correct values", (){
        
        expect( new Point.zero().toString()     , equals("Point(x: 0.0, y: 0.0)") );
        expect( new Point(null,null).toString() , equals("Point(x: 0.0, y: 0.0)") );
        expect( new Point(1.0,2.0).toString()   , equals("Point(x: 1.0, y: 2.0)") );
        expect( new Point(-1.0,-2.0).toString()   , equals("Point(x: -1.0, y: -2.0)") );
  });
  test
  (
      "Point distance should calculate the correct distance between two points.", (){
        Point a = new Point( 10.0, 10.0 );
        Point b = new Point( 1.0, 1.0 );
        Point c = new Point( 2.0, 2.0 );
        
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
      "Point Operator ==", (){
        Point a = new Point( 1.0, 1.0 );
        Point b = new Point( 1.0, 1.0 );
        Point c = new Point( 2.0, 2.0 );
        
        expect( a , equals(a) );
        expect( a , equals(b) );
        expect( b , equals(a) );
        expect( a , isNot(equals(c)) );
        expect( b , isNot(equals(c)) );
  });
  test
  (
      "Point operator + should add the values of 2 points and return the correct value.", (){
        Point a = new Point( 5.0, 10.0 );
        Point b = new Point( 1.0, 0.0 );
        Point c = new Point( 0.0, 0.0 );
        
        expect( a + b, equals(new Point( 06.0, 10.0 )) );
        expect( b + a, equals(new Point( 06.0, 10.0 )) );
        expect( a + a, equals(new Point( 10.0, 20.0 )) );
        expect( b + b, equals(new Point( 02.0, 0.0  )) );
        
        expect( a + c, equals( a ) );
        expect( b + c, equals( b ) );
        expect( c + a, equals( a ) );
        expect( c + b, equals( b ) );
        expect( c + c, equals( c ) );
  });
  test
  (
      "Point operator - should substract the values of 2 points and return the correct value.", (){
        Point a = new Point( 5.0, 10.0 );
        Point b = new Point( 1.0, 0.0 );
        Point c = new Point( 0.0, 0.0 );
        
        expect( a - b, equals(new Point( 4.0, 10.0 )) );
        expect( b - a, equals(new Point( -4.0, -10.0 )) );
        expect( a - a, equals(new Point.zero()) );
        expect( b - b, equals(new Point.zero()) );
        
        expect( a - c, equals( a ) );
        expect( b - c, equals( b ) );
        expect( c - c, equals( c ) );
        expect( c - a, equals( new Point( -a.x, -a.y ) ) );
        expect( c - b, equals( new Point( -b.x, -b.y ) ) );
  });
  test
  (
      "Point operator -Point should multiply the object members for -1 and return the correct value.", (){
        Point a = new Point( 5.0, 10.0 );
        Point b = new Point( 1.0, 0.0 );
        Point c = new Point( 0.0, 0.0 );
        
        expect( -a, equals(new Point( -5.0, -10.0 )) );
        expect( -b, equals(new Point( -1.0, 0.0 )) );
        expect( -c, equals(new Point( 0.0, 0.0 )) );
  });
  test
  (
      "Point operator * should multiply the values of 2 points and return the correct value.", (){
        Point a = new Point( 5.0, 10.0 );
        Point b = new Point( 1.0, 0.0 );
        Point c = new Point( 0.0, 0.0 );
        
        expect( a * a, equals(new Point( 25.0, 100.0 )) );
        expect( a * b, equals(new Point( 5.0, 0.0 )) );
        expect( a * c, equals(new Point( 0.0, 0.0 )) );
        
        expect( b * a, equals(new Point( 5.0, 0.0 )) );
        expect( b * b, equals(new Point( 1.0, 0.0 )) );
        expect( b * c, equals(new Point( 0.0, 0.0 )) );
        
        expect( c * a, equals(c) );
        expect( c * b, equals(c) );
        expect( c * c, equals(c) );
  });
  test
  (
      "Point operator / should divide the values of 2 points and return the correct value.", (){
        Point a = new Point( 5.0, 10.0 );
        Point b = new Point( 1.0, 0.0 );
        Point c = new Point( 0.0, 0.0 );
        
        expect( a / a, equals(new Point( 1.0, 1.0 )) );
        expect( a / b, equals(new Point( 5.0, double.INFINITY )) );
        expect( a / c, equals(new Point( double.INFINITY, double.INFINITY )) );
        
        expect( b / a, equals(new Point( 0.2, 0.0 )) );
        /// @todo Correct these tests Once Dart can evaluate NaN == NaN or thrown an exception.
        /*expect( (b / b).y, equals(double.NAN) );
        expect( b / c, equals(new Point( double.INFINITY, double.INFINITY)) );
        
        expect( c / a, equals(new Point( 0.0, 0.0 )) );
        expect( c / b, equals(new Point( 0.0, double.INFINITY )) );
        expect( c / c, equals(new Point( double.INFINITY, double.INFINITY )) );*/
  });

}