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
  static const None = const Mirroring._(0, "None");           /// No mirroring is applied
  static const H  = const Mirroring._(1, "H");                /// Horizontal mirroring
  static const V  = const Mirroring._(2, "V");                /// Vertical mirroring
  static const HV = const Mirroring._(3, "HV");               /// Horizontal and Vertical mirroring
  static const VH = const Mirroring._(3, "HV");               /// Horizontal and Vertical mirroring
  static List<Mirroring> get values => [None, H, V, HV, VH];  /// The list of acceptable Mirroring values

  final int     value;  /// The mirroring value
  final String  name;   /// The mirroring name

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


