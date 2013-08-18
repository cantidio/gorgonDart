/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
/**
 * Class that represents a Sound.
 */
class Sound
{
  /// The Audio Channel throught this sound plays.
  AudioChannel _channel;

  /// The Sound internal buffer.
  AudioBuffer _buffer;

  /// The onLoad Future.
  Future<Sound> _onLoad = new Completer().future;

  /// Returns the Future that is triggered when  the sound is loaded.
  Future<Sound> get onLoad => _onLoad;

  /// Returns the [AudioChannel] of this [Sound].
  AudioChannel get channel => _channel;

  /// Returns a [double] representing the [duration], in seconds of the Loaded [Sound].
  double get duration     => (_buffer != null) ? _buffer.duration : 0.0;

  /// Returns a [double] representing the [gain] of the Loaded [Sound].
  double get gain         => (_buffer != null) ? _buffer.gain : 0.0;

  /// Sets the [gain] of the Loaded [Sound].
  void set gain( double gain ) { _buffer.gain = gain; }

  /**
   * Creates a [Sound] that will play thought an [AudioChannel].
   */
  Sound({ String soundUrl, AudioChannel channel })
  {
    _channel = ( channel != null ) ? channel : new AudioSystem().targetChannel;
    if( soundUrl != null )
    {
      load( soundUrl );
    }
  }

  /**
   * Loads a [Sound] file throught it's Url provided by the [soundUrl].
   *
   * Returns a [Future<Sound>] that can be checked for this method completion.
   */
  Future<Sound> load( String soundUrl )
  {
    Completer completer   = new Completer();
    HttpRequest request   = new HttpRequest();
    request.responseType  = "arraybuffer";

    request.open( "GET", soundUrl, async: true );
    request.onLoad.listen((_){
      _channel._context.decodeAudioData( request.response ).then(
        (buffer)
        {
          _buffer = buffer;
          completer.complete( this );
        },
        onError: (error)
        {
          completer.completeError(new Exception("Sound: Error when decoding $soundUrl."));
        });
    });

    request.onError.listen((e)
    {
      completer.completeError(new Exception("Sound: $soundUrl could not be found."));
    });

    request.send();

    _onLoad = completer.future;

    return _onLoad;
  }

  /**
   * Plays the [Sound] generating an [AudioInstance].
   */
  AudioInstance play({ bool looping: false })
  {
    return _channel._play(this, looping);
  }
}