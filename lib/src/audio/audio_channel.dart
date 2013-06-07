part of gorgon;
/**
 * Class that represents an [AudioChannel].
 */
class AudioChannel
{
  /// The Context of this Channel.
  AudioContext _context;

  /// The gain node.
  GainNode _gain;

  /// The gain if the [AudioChannel] is muted, null otherwise.
  double _muteGain;

  /// The list of playing instances.
  List<AudioInstance> _instances = new List<AudioInstance>();

  /// Returns the gain in this [AudioChannel].
  double get gain => _gain.gain.value;

  /// Sets the gain in this [AudioChannel].
  void set gain(double gain) { _gain.gain.value = gain; }

  /// Returns true if the [AudioChannel] is muted.
  bool get mute => _muteGain != null;

  /// Mutes/unmute the [AudioChannel].
  void set mute( bool mute )
  {
    if( mute && _muteGain == null )
    {
      _muteGain = gain;
      gain      = 0.0;
    }
    else if( !mute && _muteGain != null )
    {
      gain      = _muteGain;
      _muteGain = null;
    }
  }

  /**
   * Creates an [AudioChannel].
   */
  AudioChannel._()
  {
    _context  = new AudioContext();
    _gain     = _context.createGain();
    _gain.connect(_context.destination, 0, 0 );
  }

  /**
   * Creates an [AudioChannel] and inserts it in the [AudioSystem] with the requested [name].
   */
  factory AudioChannel( String name )
  {
    AudioSystem system    = new AudioSystem();
    AudioChannel channel  = system.channel( name );

    if( channel == null )
    {
      channel = new AudioChannel._();
      system._insertChannel( name, channel );
    }

    return channel;
  }

  /**
   * Method that removes all finished [AudioInstances].
   */
  void _removeFinishedInstances()
  {
    for( int i = _instances.length - 1; i >= 0; --i )
    {
      if( _instances[i].isFinished )
      {
        _instances.removeAt(i);
      }
    }
  }

  /**
   * Method that creates an [AudioInstance] from a [AudioBufferSourceNode].
   *
   * This Method will create the [AudioInstance] and insert it in the  instances List.
   */
  AudioInstance _createInstance( AudioBufferSourceNode source )
  {
    AudioInstance instance = new AudioInstance._fromSource(source);
    _instances.add( instance );

    int max = 100;
    if( _instances.length > max )
    {
      _removeFinishedInstances();
    }

    return instance;
  }

  /**
   * Method that plays a [Sound] generating an [AudioInstance] of it.
   */
  AudioInstance _play( Sound sound, bool looping )
  {
    AudioBufferSourceNode source = _context.createBufferSource();
    source.buffer = sound._buffer;
    source.loop   = looping;

    source.connect( _gain, 0, 0 );
    source.start(0);
    return _createInstance( source );
  }

  /**
   * Sets this [AudioChannel] as the current target.
   */
  void setAsTarget()
  {
    AudioSystem._targetChannel = this;
  }
}