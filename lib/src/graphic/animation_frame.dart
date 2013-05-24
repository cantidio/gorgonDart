/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class AnimationFrame
{
  String group;
  int index;
  int time;
  Point2D offset;
  Mirroring mirroring;
  int angle;

  /**
   * Method that describes the AnimationFrame Object returning a [String].
   */
  String toString() => "AnimationFrame(group: $group, index: $index, time: $time, angle: $angle, offset: $offset, mirroring: $mirroring)";

  AnimationFrame({ String group, int index, int time, Point2D offset, Mirroring mirroring, int angle })
  {
    this.time       = ( time      != null ) ? time      : 0;
    this.group      = ( group     != null ) ? group     : "";
    this.index      = ( index     != null ) ? index     : 0;
    this.angle      = ( angle     != null ) ? angle     : 0;
    this.offset     = ( offset    != null ) ? offset    : new Point2D.zero();
    this.mirroring  = ( mirroring != null ) ? mirroring : Mirroring.None;
  }

  AnimationFrame.fromMap( Map frame )
  {
    this.time       = ( frame["time"]      != null ) ? frame["time"]      : 0;
    this.group      = ( frame["group"]     != null ) ? frame["group"]     : "";
    this.index      = ( frame["index"]     != null ) ? frame["index"]     : 0;
    this.angle      = ( frame["angle"]     != null ) ? frame["angle"]     : 0;
    this.offset     = ( frame["offset"]    != null ) ? frame["offset"]    : new Point2D.zero();

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