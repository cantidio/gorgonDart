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

  /// Returns the [gain] of this [AudioInstance].
  double get gain => _source.gain.value;

  /// Sets the [gain] of this [AudioInstance].
  void set gain( double gain ){ _source.gain.value = gain; }

  /// Returns [true] if the [AudioInstance] is playing.
  bool get isPlaying =>   _source.playbackState == AudioBufferSourceNode.PLAYING_STATE;

  /// Returns [true] if the [AudioInstance] finished playing.
  bool get isFinished =>  _source.playbackState == AudioBufferSourceNode.FINISHED_STATE;

  /**
   * Creates an [AudioInstance] from a [AudioBufferSourceNode].
   */
  AudioInstance._fromSource(AudioBufferSourceNode source)
  {
    _source = source;
  }

  /**
   * Plays the [AudioInstance].
   */
  void play()
  {
    if( ! isPlaying )
    {
      _source.start(0);
    }
  }

  /**
   * Stops the [AudioInstance].
   */
  void stop()
  {
    _source.stop(0);
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