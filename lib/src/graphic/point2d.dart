/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a point in a 2D world
 */
class Point2D
{
  /// The position of the point in the x axis
  num x;
  /// The position of the point in the y axis
  num y;

  /**
   * Method that describes the Point Object returning a [String].
   */
  String toString() => "Point2D(x: $x, y: $y)";
  /**
   * Creates a [Point2D], setting its [num] [x] axis value and its [num] [y] value.
   */
  Point2D( num x, num y )
  {
    this.x = (x != null) ? x : 0.0;
    this.y = (y != null) ? y : 0.0;
  }
  /**
   * Creates a zero point
   *
   * This constructor returns a [Point2D] with x and y values = 0.
   */
  Point2D.zero() : x = 0.0, y = 0.0;
  /**
   * Method that returns the distance between two [Point2D] Objects.
   *
   * You must provide the [other] [Point2D] and the method will return a [num] with the
   * distance between the two.
   */
  num distance( Point2D other ) => sqrt( pow(other.x-x,2) + pow(other.y-y,2) );
  /**
   * Operator that returns a [bool] true if the [other] [Point2D] has the same values as this.
   */
  operator ==( Point2D other ) => x == other.x && y == other.y;
  /**
   * Operator that sums 2 [Point2D]s and returns the resulting [Point2D].
   */
  operator +(Point2D other) => new Point2D( x + other.x, y + other.y );
  /**
   * Operator that substracts 2 [Point2D]s and returns the resulting [Point2D].
   */
  operator -(Point2D other) => new Point2D( x - other.x, y - other.y );
  /**
   * Operator that multiplies all the axis values of the point to -1 and then return a new [Point2D].
   */
  operator -() => new Point2D( -x, - y );
  /**
   * Operator that multiplies 2 [Point2D]s and returns the resulting [Point2D].
   */
  operator *(Point2D other) => new Point2D( x * other.x, y * other.y );
  /**
   * Operator that divides 2 [Point2D]s and returns the resulting [Point2D].
   */
  operator /(Point2D other) => new Point2D( x / other.x, y / other.y );
}