/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents the font alignment
 */
class FontAlignment
{
  /// With this alignment the text is aligned to the left
  static const left   = const FontAlignment._(0,"left");
  
  /// With this alignment the text is aligned centered
  static const center = const FontAlignment._(1,"center");
  
  /// With this alignment the text is aligned to the right
  static const right  = const FontAlignment._(2,"right");
  
  /// The value of the alignment
  final int     value;
  
  /// The name of the alignment
  final String  name;
  
  /**
   * Method that describes the FontAlignment Object returning a [String].
   */
  String toString() => "FontAlignment:$name";
  
  const FontAlignment._( this.value, this.name );
}
