/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class Sound
{
  static AudioContext _context = new AudioContext();
  AudioBuffer _source;

  AudioElement _element;

  Future<Sound> _onLoad = new Completer().future;

  Future<Sound> get onLoad => _onLoad;

  /*double get duration     => _element.duration;
  double get currentTime  => _element.currentTime;
  double get volume       => _element.volume;
  bool   get isPaused     => _element.paused;
*/

  Sound({ String soundUrl })
  {
    /*_element          = new AudioElement();
    _element.autoplay = false;
    _element.preload  = "auto";

    AudioContext audio = new AudioContext();
    */

    //document.body.append(_element);
    /*
     * Research before going any further:
     * http://www.html5rocks.com/en/tutorials/webaudio/games/
     * http://www.html5rocks.com/en/tutorials/webaudio/intro/
     * */
    load( soundUrl );
  }

  Future<Sound> load( String soundUrl )
  {
    Completer completer   = new Completer();
    HttpRequest request   = new HttpRequest();
    request.responseType  = "arraybuffer";

    request.open( "GET", soundUrl, async: true );
    request.onLoad.listen((_){
      /** @todo Check why this crashes when running in the DartVM.*/
      _context.decodeAudioData
      (
        request.response,
        (buffer)
        {
          _source = buffer;
          completer.complete( this );
        },
        (error)
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

  SoundInstance play()
  {
    AudioBufferSourceNode source = _context.createBufferSource();
    source.buffer = _source;
    source.connect( _context.destination, 0, 0 );
    source.start(0);
    return new SoundInstance._(source);
  }
  //int
}