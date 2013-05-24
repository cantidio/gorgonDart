/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class AnimationFrame
{
  int group;
  int index;
  int time;
  Point2D offset;
  Mirroring mirroring;
  int angle;

  AnimationFrame({ String group, int index, int time, Point2D offset, Mirroring mirroring, int angle })
  {
    this.time       = ( time      != null ) ? time      : 1;
    this.group      = ( group     != null ) ? group     : "";
    this.index      = ( index     != null ) ? index     : 0;
    this.angle      = ( angle     != null ) ? angle     : 0;
    this.offset     = ( offset    != null ) ? offset    : new Point2D.zero();
    this.mirroring  = ( mirroring != null ) ? mirroring : Mirroring.None;
  }

  AnimationFrame.fromMap( Map frame )
  {
    this.time       = ( frame["time"]      != null ) ? frame["time"]      : 1;
    this.group      = ( frame["group"]     != null ) ? frame["group"]     : "";
    this.index      = ( frame["index"]     != null ) ? frame["index"]     : 0;
    this.angle      = ( frame["angle"]     != null ) ? frame["angle"]     : 0;
    this.offset     = ( frame["offset"]    != null ) ? frame["offset"]    : new Point2D.zero();
    this.mirroring  = ( frame["mirroring"] != null ) ? frame["mirroring"] : Mirroring.None;
  }
}