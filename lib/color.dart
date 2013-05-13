/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in gorgon.dart
 */
part of gorgon;
/**
 * Class that represents a color
 */
class Color 
{
  int r;
  int g;
  int b;
  int a;

  /**
   * Method that describes the Mirroring Object returning a [String].
   */
  String toString() => "Color(r:$r, g:$g, b:$b, a:$a)";
  /**
   * Constructor
   */
  Color([ int r=0, int g=0, int b=0, int a= 255 ])
  {
    this.r = (r >= 0) ? r : 0;
    this.g = (g >= 0) ? g : 0;
    this.b = (b >= 0) ? b : 0;
    this.a = (a >= 0) ? a : 0;
  }  
}


