/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
part of gorgon;
/**
 * Class that represents a point in a 2D world
 */
class Point
{
  num x; /// the position of the point in the x axis 
  num y; /// the position of the point in the y axis

  /**
   * Method that describes the Point Object returning a [String].
   */
  String toString() => "Point(x: $x, y: $y)";
  /**
   * Creates a [Point], setting its [num] [x] axis value and its [num] [y] value.
   */
  Point( num x, num y )
  {
    this.x = (x != null) ? x : 0.0;
    this.y = (y != null) ? y : 0.0;
  }
  /**
   * Creates a zero point
   * 
   * This constructor returns a [Point] with x and y values = 0. 
   */
  Point.zero() : x = 0.0, y = 0.0;
  /**
   * Method that returns the distance between two [Point] Objects.
   *  
   * You must provide the [other] [Point] and the method will return a [num] with the
   * distance between the two.
   */
  num distance( Point other ) => sqrt( pow(other.x-x,2) + pow(other.y-y,2) );
  /**
   * Operator that returns a [bool] true if the [other] [Point] has the same values as this.
   */
  operator ==( Point other ) => x == other.x && y == other.y;
  /**
   * Operator that sums 2 [Point]s and returns the resulting [Point].
   */
  operator +(Point other) => new Point( x + other.x, y + other.y );
  /**
   * Operator that substracts 2 [Point]s and returns the resulting [Point].
   */
  operator -(Point other) => new Point( x - other.x, y - other.y );
  /**
   * Operator that multiplies all the axis values of the point to -1 and then return a new [Point].
   */
  operator -() => new Point( -x, - y );
  /**
   * Operator that multiplies 2 [Point]s and returns the resulting [Point].
   */
  operator *(Point other) => new Point( x * other.x, y * other.y );
  /**
   * Operator that divides 2 [Point]s and returns the resulting [Point].
   */
  operator /(Point other) => new Point( x / other.x, y / other.y );
}