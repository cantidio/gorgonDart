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
  double x; /// the position of the point in the x axis 
  double y; /// the position of the point in the y axis
  
  /**
   * Creates a [Point] with the [this.x] and [this.y] values given.
   */
  Point(this.x, this.y);
  /**
   * Creates a zero point
   * 
   * This constructor returns a [Point] with x and y values = 0. 
   */
  Point.zero() : x = 0.0, y = 0.0;
}