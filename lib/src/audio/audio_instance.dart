/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents an instance of a playing Audio.
 */
class AudioInstance
{
  /// The source of this [AudioInstance].
  AudioBufferSourceNode _source;

  /// The gain node of the source [Sound].
  GainNode _gain;

  /// The time when the [Sound] was scheduled to be played.
  double _start;

  /// True if this [AudioInstance] was stopped.
  bool _stopped;

  /// Returns the [gain] of this [AudioInstance].
  double get gain => _gain.gain.value;

  /// Sets the [gain] of this [AudioInstance].
  void set gain( double gain ) {
    _gain.gain.value = gain;
    if(_gain.gain.value > 1.0) {
      _gain.gain.value = 1.0;
    }
    else if(_gain.gain.value < 0.0) {
      _gain.gain.value = 0.0;
    }
  }

  /// Returns [true] if the [AudioInstance] is stopped.
  bool get isStopped => _stopped;

  /// Returns [true] if the [AudioInstance] is playing.
  bool get isPlaying => !_stopped && _source.context.currentTime >= _start && (_source.loop || _source.context.currentTime < _start + _source.buffer.duration);

  /// Returns [true] if the [AudioInstance] finished playing.
  bool get isFinished => !_stopped && !_source.loop && _source.context.currentTime > _start + _source.buffer.duration;

  /**
   * Creates an [AudioInstance] from a [AudioBufferSourceNode].
   */
  AudioInstance._fromSource(AudioBufferSourceNode source, GainNode gain)
  {
    _stopped = false;
    _source = source;
    _gain = gain;
    _start = _source.context.currentTime;
  }

  /**
   * Plays the [AudioInstance].
   */
  void play()
  {
    if( !isPlaying )
    {
      _stopped = false;
      _source.start(0);
    }
  }

  /**
   * Stops the [AudioInstance].
   */
  void stop()
  {
    _source.stop(0);
    _stopped = true;
  }

  /**
   * Reset the [AudioInstance].
   */
  void reset()
  {
    stop();
    play();
  }
}
