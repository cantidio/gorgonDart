/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 */
part of gorgon;
class SoundInstance
{
  AudioBufferSourceNode _source;
  SoundInstance._(AudioBufferSourceNode source)
  {
    _source = source;
  }
}