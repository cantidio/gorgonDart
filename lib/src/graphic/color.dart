/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a color
 */
class Color
{
  int _r;
  int _g;
  int _b;
  int _a;

  int get r => _r;
  int get g => _g;
  int get b => _b;
  int get a => _a;

  set r(int r) => _r = (r >= 0) ? (r <= 255 ) ? r : 255 : 0;
  set g(int g) => _g = (g >= 0) ? (g <= 255 ) ? g : 255 : 0;
  set b(int b) => _b = (b >= 0) ? (b <= 255 ) ? b : 255 : 0;
  set a(int a) => _a = (a >= 0) ? (a <= 255 ) ? a : 255 : 0;

  /**
   * Method that describes the Color Object returning a [String].
   */
  String toString() => "Color(r:$r, g:$g, b:$b, a:$a)";

  /**
   * Constructor
   *
   * You should pass the components you whish to set.
   * For setting the red component you should set the[r] param as an int
   * For setting the green component you should set the[g] param as an int
   * For setting the blue component you should set the[b] param as an int
   * For setting the alpha component you should set the[a] param as an int
   */
  Color({ int r:0, int g:0, int b:0, int a: 255 })
  {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
  /**
   * Operator that sums 2 [Color]s.
   */
  operator +(Color other) => new Color( r: r + other.r, g: g + other.g, b: b + other.b, a: a + other.a );
  /**
   * Operator that substracts one [Color] from the [other] [Color].
   */
  operator -(Color other) => new Color( r: r - other.r, g: g - other.g, b: b - other.b, a: a - other.a );
  /**
   * Operator that checks if 2 [Color]s are have the same values.
   */
  operator ==(Color other) => r == other.r && g == other.g && b == other.b && a == other.a;
}

