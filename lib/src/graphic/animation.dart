/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents an Animation
 */
class Animation
{
  List<Frame> _frames = new List<Frame>();  // the frame list

  /// True if this animation has a loop
  bool looping;

  /// Frame Index that the animation start looping
  int loopFrame;

  /// Frame Index that the animation loops
  int repeatNumber;

  /// Returns the number of frames in the animation
  int get length => _frames.length;

  /**
   * Method that describes the Animation Object returning a [String].
   */
  String toString() => "Animation(frames: $_frames)";

  /**
   * Creates a [Animation].
   *
   * If the [looping] is [true], this animation will have loop, which will start at the frame [loopFrame]
   * and will keep repeating for [repeatNumber] of times.
   *
   * If you wish this animation for loop indefinitely set the [repeatNumber] to -1.
   */
  Animation({ bool looping: false, int loopFrame: 0, int repeatNumber: -1, List<Frame> frames })
  {
    this.looping      = looping;
    this.loopFrame    = loopFrame;
    this.repeatNumber = repeatNumber;

    if( frames != null )
      _frames.addAll( frames );
  }

  /**
   * Creates a [Animation] from a [Map].
   */
  Animation.fromMap( Map animation )
  {
    this.looping      = ( animation["looping"]      != null ) ? animation["looping"]      : false;
    this.loopFrame    = ( animation["loopFrame"]    != null ) ? animation["loopFrame"]    : 0;
    this.repeatNumber = ( animation["repeatNumber"] != null ) ? animation["repeatNumber"] : -1;
    int globalTime    = animation["time"];

    if( animation["frames"] != null )
    {
      Frame fr;
      animation["frames"].forEach((frame){
        fr = add(new Frame.fromMap(frame));
        if( globalTime != null && fr.time == 0 )
        {
          fr.time = globalTime;
        }
      });
    }
  }

  /**
   * Method that adds a [AnimationFrame] [frame] into the [Animation].
   *
   * You can tell at which position it should be added by setting the [index].
   */
  Frame add(Frame frame, [ int index ])
  {
    if( index != null )
    {
      _frames.insert(index, frame);
    }
    else
    {
      _frames.add(frame);
    }
    return frame;
  }

  /**
   * Method that removes the [AnimationFrame] [frame] from the [Animation].
   *
   * This method will return the [Frame] removed.
   */
  Frame remove( Frame frame )
  {
    _frames.remove(frame);
    return frame;
  }

  /**
   * Method that removes a [Frame] at [index] from the [Animation].
   *
   * This method will return the [Frame] removed.
   */
  Frame removeAt( int index )
  {
    Frame frame = _frames[index];
    _frames.removeAt(index);
    return frame;
  }

  /**
   * Operator that returns a [Frame] at the [index] position in the [Animation].
   */
  Frame operator[](int index )
  {
    return _frames[index];
  }

  /**
   * Applies the function [f] to each [Frame] {[Frame]} of the [Animation].
   */
  void forEachFrame( void f(Frame frame) )
  {
    _frames.forEach(f);
  }
}