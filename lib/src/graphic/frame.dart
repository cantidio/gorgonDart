/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class Frame
{
  String group;
  int index;
  int time;
  Point2D offset;
  Mirroring mirroring;
  int rotation;

  /**
   * Method that describes the AnimationFrame Object returning a [String].
   */
  String toString() => "AnimationFrame(group: $group, index: $index, time: $time, rotation: $rotation, offset: $offset, mirroring: $mirroring)";

  Frame({ String group, int index, int time, Point2D offset, Mirroring mirroring, int rotation })
  {
    this.time       = ( time      != null ) ? time      : 0;
    this.group      = ( group     != null ) ? group     : "";
    this.index      = ( index     != null ) ? index     : 0;
    this.rotation   = ( rotation  != null ) ? rotation  : 0;
    this.offset     = ( offset    != null ) ? offset    : new Point2D.zero();
    this.mirroring  = ( mirroring != null ) ? mirroring : Mirroring.None;
  }

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