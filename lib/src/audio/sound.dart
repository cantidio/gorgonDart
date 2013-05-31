/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class Sound
{
  AudioElement _element;

  Future<Sound> _onLoad = new Completer().future;

  Future<Sound> get onLoad => _onLoad;

  double get duration     => _element.duration;
  double get currentTime  => _element.currentTime;
  double get volume       => _element.volume;
  bool   get isPaused     => _element.paused;


  Sound({ String soundUrl })
  {
    _element          = new AudioElement();
    _element.autoplay = false;
    _element.preload  = "auto";

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
    Completer completer = new Completer();


    _element.onLoadedData.listen((e)
    {
      completer.complete( this );
    });

    _element.onError.listen((e)
    {
      completer.completeError(new Exception("Sound: $soundUrl could not be found."));
    });


    _element.src = soundUrl;

    _onLoad = completer.future;

    return _onLoad;
  }
  void play()
  {
    _element.play();
  }
  //int
}