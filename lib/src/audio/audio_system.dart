part of gorgon;
/**
 * Class that represents an AudioSystem
 */
class AudioSystem
{
  static AudioSystem _singleton;

  static AudioChannel _targetChannel;

  Map<String,AudioChannel> _channels = new Map<String,AudioChannel>();

  /// Returns the [AudioChannel] marked as target. The target [AudioChannel] is used when creating new Sounds.
  AudioChannel get targetChannel => _targetChannel;

  /**
   * Returns a [List] containing the [AudioChannel]s names.
   */
  List<String> get channels => _channels.keys.toList(growable: false);

  /**
   * Creates an [AudioSystem].
   */
  AudioSystem._()
  {
    _channels["default"]  = new AudioChannel._();
    _channels["default"].setAsTarget();
  }

  /**
   * Method that returns the [AudioSystem] Object.
   */
  factory AudioSystem()
  {
    if( _singleton == null )
    {
      _singleton = new AudioSystem._();
    }
    return _singleton;
  }

  /**
   * Returns an [AudioChannel] given it's [name].
   */
  AudioChannel channel( String name )
  {
    return _channels[name];
  }

  /**
   * Inserts an [AudioChannel] in the [AudioSystem].
   *
   * You must provide the [channel] and it's [name].
   */
  void _insertChannel( String name, AudioChannel channel )
  {
    _channels[name] = channel;
  }
}
