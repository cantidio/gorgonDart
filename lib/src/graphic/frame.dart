/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents an [Animation] Frame.
 */
class Frame
{
  /// The group of [Sprite] of the [Frame].
  String group;

  /// The index of the [Sprite] of the index.
  int index;

  /// The time that the [Frame] should be displayed.
  int time;

  /// The offset of the [Frame].
  Point2D offset;

  /// The mirroring of the [Frame].
  Mirroring mirroring;

  /// The rotation of the [Frame].
  int rotation;

  /**
   * Method that describes the AnimationFrame Object returning a [String].
   */
  String toString() => "AnimationFrame(group: $group, index: $index, time: $time, rotation: $rotation, offset: $offset, mirroring: $mirroring)";

  /**
   * Creates a Frame with the desired attributes.
   *
   * You can set the [group] of the [Frame]. Which is the [group] of the desired [Sprite] in the [Spritepack].
   * You can set the [index] of the [Frame]. Which is the index of the [Sprite] in the [group] of the [Spritepack].
   * You can set the [time] of the [Frame]. Which is how many times the frame must be drawn.
   * You can set the [offset] of the [Frame]. Which is an additional offset that will be applied to the [Sprite].
   * You can set the [mirroring] of the [Frame].
   * You can set the [rotation] of the [Frame].
   */
  Frame({ String group, int index, int time, Point2D offset, Mirroring mirroring, int rotation })
  {
    this.time       = ( time      != null ) ? time      : 0;
    this.group      = ( group     != null ) ? group     : "";
    this.index      = ( index     != null ) ? index     : 0;
    this.rotation   = ( rotation  != null ) ? rotation  : 0;
    this.offset     = ( offset    != null ) ? offset    : new Point2D.zero();
    this.mirroring  = ( mirroring != null ) ? mirroring : Mirroring.None;
  }

  /**
   * Creates a [Frame] from a [frame] [Map].
   *
   * The [Map] [Frame] must be like this:
   * [Map] [frame] = {
   *    "group":      "sprite_group",
   *    "index":      0,
   *    "time":       0,
   *    "rotation":   0,
   *    "xoffset":    0,
   *    "yoffset":    0,
   *    "mirroring": "Normal"
   * };
   */
  Frame.fromMap( Map frame )
  {
    this.time       = ( frame["time"]      != null ) ? frame["time"]      : 0;
    this.group      = ( frame["group"]     != null ) ? frame["group"]     : "";
    this.index      = ( frame["index"]     != null ) ? frame["index"]     : 0;
    this.rotation   = ( frame["rotation"]  != null ) ? frame["rotation"]  : 0;
    this.offset     = new Point2D
    (
      ( frame["xoffset"] != null ) ? frame["xoffset"] : 0,
      ( frame["yoffset"] != null ) ? frame["yoffset"] : 0
    );

    if( frame["mirroring"] != null )
    {
      for( Mirroring mirroring in Mirroring.values )
      {
        if( mirroring.name == frame["mirroring"] )
        {
          this.mirroring = mirroring;
          break;
        }
      }
      //if the mirroring provided is not found, then something is wrong.
      if( this.mirroring == null )
      {
        throw new Exception("Mirroring: '${frame["mirroring"]}' not recognized.");
      }
    }
    else
    {
      this.mirroring = Mirroring.None;
    }
  }
}