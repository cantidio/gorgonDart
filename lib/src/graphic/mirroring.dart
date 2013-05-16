/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a sprite Mirroring
 */
class Mirroring
{
  /// No mirroring is applied
  static const None = const Mirroring._(0, "None");

  /// Horizontal mirroring
  static const H  = const Mirroring._(1, "H");

  /// Vertical mirroring
  static const V  = const Mirroring._(2, "V");

  /// Horizontal and Vertical mirroring
  static const HV = const Mirroring._(3, "HV");

  /// Horizontal and Vertical mirroring
  static const VH = const Mirroring._(3, "HV");

  /// The list of acceptable Mirroring values
  static List<Mirroring> get values => [None, H, V, HV, VH];

  /// The mirroring value
  final int     value;

  /// The mirroring name
  final String  name;

  /**
   * Method that describes the Mirroring Object returning a [String].
   */
  String toString() => "Mirroring:$name";
  /**
   * Private constructor that generates a const instance of a Mirroring Class.
   */
  const Mirroring._( this.value, this.name );
  /**
   * Operator that does the bitwise & operation between two [Mirroring] Objects and returns
   * the correct [Mirroring].
   */
  operator &( Mirroring other )
  {
    for( int i = values.length-1; i >= 0; --i )
    {
      if( values[i].value == (value & other.value) )
      {
        return values[i];
      }
    }
  }
  /**
   * Operator that does the bitwise | operation between two [Mirroring] Objects and returns
   * the correct [Mirroring].
   */
  operator |( Mirroring other )
  {
    for( int i = values.length-1; i >= 0; --i )
    {
      if( values[i].value == (value | other.value) )
      {
        return values[i];
      }
    }
  }
}


