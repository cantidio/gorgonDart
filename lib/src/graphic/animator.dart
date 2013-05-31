/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a Handler that deals with Animation Control.
 */
class Animator
{
  Spritepack    _spritepack;
  Animationpack _animationpack;

  /// The index of the animation playing
  String _animationOn;

  /// Actual time of the current frame
  int _timeOn;

  /// Current frame of the current animation
  int _frameOn;

  /// Number of loops the current animação passed throught
  int _loopOn;

  /// True if the animation is paused
  bool _isPaused;

  /// True if the animation is running
  bool _isPlaying;

  String  get animationOn => _animationOn;
  int     get timeOn      => _timeOn;
  int     get frameOn     => _frameOn;
  int     get loopOn      => _loopOn;
  bool    get isPaused    => _isPaused;
  bool    get isPlaying   => _isPlaying;

  /**
   * Method that describes the Animation Object returning a [String].
   */
  String toString() => "Animator(animationOn: $animationOn, frameOn: $frameOn, timeOn: $timeOn, loopOn: $loopOn, isPaused: $isPaused)";

  Animator( Spritepack spritepack, Animationpack animationpack )
  {
    _spritepack     = spritepack;
    _animationpack  = animationpack;
    reset();
  }

  void reset()
  {
    _isPaused       = false;
    _isPlaying      = true;
    _animationOn    = (_animationpack.animations.length > 0 ) ? _animationpack.animations[0] : null;
    _frameOn        = 0;
    _timeOn         = 0;
    _loopOn         = 0;
  }

  void pause()
  {
    _isPaused = true;
  }

  void resume()
  {
    _isPaused = false;
  }

  void changeAnimation(String animation, [bool force=false])
  {
    if(_animationpack != null)
    {
      if( animationOn != animation || force )
      {
        if(_animationpack[animation] != null )
        {
          reset();
          _animationOn = animation;
        }
        else
        {
          throw new Exception("Unable to change Animation due to incorrect index( $animation ).");
        }
      }
    }
    else
    {
      throw new Exception("Unable to change Animation due to animationpack is null.");
    }
  }

  void runStep()
  {
    if( isPaused ) return;
    if( _animationpack != null )
    {
      Animation      animation   = _animationpack[animationOn];
      Frame frame       = animation[frameOn];

      _isPlaying = true;

      if( frame.time > 0 )  // if the frame time is 0 or less, then we are stuck at it
      {
        ++_timeOn;

        if( frame.time < _timeOn ) //frame time is over
        {
          _timeOn = 0;
          ++_frameOn;
        }
        if( _frameOn >= animation.length ) //animation is over
        {
          if( animation.looping && animation.repeatNumber < 0 )           //repeat for ever
          {
            _isPlaying  = false;
            _timeOn     = 0;
            _frameOn    = animation.loopFrame;
          }
          else if( animation.looping && _loopOn < animation.repeatNumber ) //there's more loops
          {
            ++_loopOn;
            _timeOn     = 0;
            _frameOn    = animation.loopFrame;
          }
          else  //finish for good
          {
            --_frameOn;
            _timeOn     = frame.time;
            _isPlaying  = false;
          }
        }
      }
    }
    else
    {
      throw new Exception("Animationpack is null.");
    }
  }

  /**
   * This method checks if the internal [Animationpack] and [Spritepack].
   *
   * This method will check if every [Animation] and [Frame] in the [Animationpack]
   * corresponds to a valid entry. It will correlate the [Frame] group and index to the
   * [Spritepack] group and [Sprite] index.
   *
   * **Warning** If any strange behavior is detected this method will return an exception.
   */
  void sanityCheck()
  {
    if( _animationpack == null ) throw new Exception("Animationpack is null.");
    if( _spritepack == null ) throw new Exception("Spritepack is null.");

    _animationpack.forEach((animationKey, animation){
      if( animation == null ) throw new Exception("Animation $animationKey is null");

      for( int i = 0; i < animation.length; ++i )
      {
        Frame frame = animation[i];

        if( _spritepack[frame.group] == null || _spritepack[frame.group].length == 0 )
          throw new Exception("sprite group[${frame.group}] requested by animation[$animationKey] at frame[$i] is empty.");

        if( _spritepack[frame.group].length <= frame.index || frame.index < 0 )
          throw new Exception("Sprite[${frame.group}][${frame.index}] requested by animation[$animationKey] at frame[$i] is unreacheable.");

        if(frame.time <= 0 && i < animation.length-1)
          throw new Exception("In animation[$animationKey] at frame[$i], time is 0, and it isn't the last frame.");
      }
    });
  }

  void draw( Point2D position, { alpha: 255 ,Mirroring mirroring: Mirroring.None, num rotation: 0, num scale: 1})
  {
    if( _animationpack != null && _spritepack != null )
    {
      Frame frame = _animationpack[_animationOn][_frameOn];

      _spritepack[frame.group][frame.index].draw
      (
        position + frame.offset,
        alpha:      alpha,
        mirroring:  mirroring ^ frame.mirroring,
        rotation:   rotation + frame.rotation,
        scale:      scale
      );
    }
  }


}