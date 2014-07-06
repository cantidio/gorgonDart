[![Stories in Ready](https://badge.waffle.io/cantidio/gorgondart.png?label=ready&title=Ready)](https://waffle.io/cantidio/gorgondart)
Gorgon for Dart
==========

*IMPORTANT NOTICE:* This lib is still under development. Any changes will
be done without prior notice to consumers of this package.

[![Build Status](https://drone.io/github.com/cantidio/gorgonDart/status.png)](https://drone.io/github.com/cantidio/gorgonDart/latest)
[![Stories in Ready](https://badge.waffle.io/cantidio/gorgonDart.png?label=ready)](http://waffle.io/cantidio/gorgonDart)

[Last Build Documentation](https://drone.io/github.com/cantidio/gorgonDart/files/gorgon_docs.zip)

Gorgon is a game development library for Dart.

## Getting Started

1\. Add the following to your project's **pubspec.yaml** and run ```pub install```.

Get the last gorgon version in pub:

```yaml
dependencies:
  gorgon: '>=0.13.3'
```
Or always get the last version in the git repository( **may have broken code** ):

```yaml
dependencies:
  gorgon:
    git: https://github.com/cantidio/gorgonDart.git
```

2\. Add the correct import for your project.

```dart
import 'package:gorgon/gorgon.dart';
```

## Examples ##

1\. Graphic Module

1\.1\. Creating a Display and Drawing a simple Sprite.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Create a new sprite passing it's URL or base64 string
  Sprite sprite = new Sprite( imageSource: "my image url or my imagebase64" );
  // After the sprite load, draw it. in some point in the Display
  sprite.onLoad.then((_) => sprite.draw( new Point2D( 160, 120 ) ) );
}
```

1\.2\. Creating a Sprite from a img element.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Create a new sprite passing it's image element
  Sprite sprite = new Sprite.fromImage( query("#my_image_element") );
}
```

1\.3\. Mirroring, rotating, scaling and applying alpha your sprite draw operation.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Create a new sprite passing it's URL or base64 string
  Sprite sprite = new Sprite( imageSource: "my image url or my imagebase64" );
  // Wait for the sprite to load.
  sprite.onLoad.then((_) {
    // The following code will draw the sprite inverted horizontally, rotated 180 degrees, scaled 2.0 times and semi transparent.
    sprite.draw( new Point2D( 160, 128 ), alpha: 150 mirroring: Mirroring.H, rotation: 180, scale: 2.0 );
  });
}
```

1\.4\. Creating Spritepacks.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Creating a Spritepack from a Dart Map.
  Spritepack spritepack = new Spritepack.fromMap({
    "animation-1" : [
      { "image": "your-image-1.png" },
      { "image": "your-image-2.png" },
      { "image": "your-image-3.png" }
    ],
    "animation-2" : [
      { "image": "your-image-4.png" },
      { "image": "your-image-5.png" },
      { "image": "your-image-6.png" }
    ]
  });

  // Wait for the spritepack to load.
  spritepack.onLoad.then((_) {
    // Get your sprites from the pack and draw them.
    spritepack["animation-1"][0].draw( new Point2D( 160, 128 ) );
  });
}
```

1\.5\. Loading Spritepacks from a Json.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Load a Spritepack from a Json.
  // Inside your Json you can set your images path relative to your json file path.
  Spritepack spritepack = new Spritepack.fromJSON( "yourspritepack.json");
}
```
Json example:
```json
{"spritepack":{
  "group-1":
  [
    { "xoffset" : -32, "yoffset" : -64, "image" : "yourimage_1.png" },
    { "xoffset" : -32, "yoffset" : -64, "image" : "yourimage_2.png" },
    { "xoffset" : -32, "yoffset" : -64, "image" : "yourimage_3.png" }
  ],
  "group-2":
  [
    { "xoffset" : -32, "yoffset" : -64, "image" : "yourimage_4.png" },
    { "xoffset" : -32, "yoffset" : -64, "image" : "yourimage_5.png" }
  ]
}}
```

1\.6\. Creating a Spritepack from a tile sheet. And accessing it's groups and sprites.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create your display inside a DOM element.
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );

  // Create a Spritepaxk where each tile has 32px of width and 32px of height.
  Spritepack spritepack = new Spritepack.fromTileSheet( "tilesheet.png", 32, 32 );

  // Wait for the spritepack to load.
  spritepack.onLoad.then((_) {
    // In tile sheets, every row is a group, and can be accessed by it's number.
    spritepack[0][0].draw( new Point2D( 160, 128 ) );
    spritepack[1][0].draw( new Point2D( 160, 128 ) );
  });
}
```

1\.7\. Creating a simple animation from a Map.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create an animationpack from a dart Map
  Animation animation = new Animation.fromMap({
    "looping":      true,
    "loopFrame":    0,
    "repeatNumber": -1,
    "time":         6,
    "frames": [
       { "group": "walk", "index": 0 },
       { "group": "walk", "index": 1 }
     ]
  });
}
```

1\.8\. Creating a simple animationpack from a Map.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create an animationpack from a dart Map
  Animationpack animation = new Animation.fromMap({
    "animation-1": {
      "looping":      true,
      "loopFrame":    0,
      "repeatNumber": -1,
      "time":         6,
      "frames": [
         { "group": "walk", "index": 0 },
         { "group": "walk", "index": 1 },
         { "group": "walk", "index": 2 },
         { "group": "walk", "index": 3 },
         { "group": "walk", "index": 4 },
         { "group": "walk", "index": 3 },
         { "group": "walk", "index": 2 },
         { "group": "walk", "index": 1 }
       ]
    }
  });
}
```

1\.9\. Load a animationpack from a JSON.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create an animationpack from a dart Map
  Animationpack animationpack = new Animation.fromJSON( "animationpack.json" );
  animationpack.onLoad.then((_){
    // do something here
  });
}
```
Json example:
```json
{"animationpack":{
  "animation-1": {
    "looping":      true,
    "loopFrame":    0,
    "repeatNumber": -1,
    "frames": [
      { "group": "stand", "index": 0, "xoffset": 0, "yoffset":0, "time": 5, "mirroring": "None", "rotation": 0 },
      { "group": "stand", "index": 1, "xoffset": 0, "yoffset":0, "time": 5, "mirroring": "None", "rotation": 0 }
    ]
  }
}}
```

1\.10\. Creating an Animator from a Spritepack and an Animationpack.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  Display display = new Display( query("#My display holder"), width: 320, height: 240 );
  Spritepack spritepack = new Spritepack.fromJSON( "yourspritepack.json");
  Animationpack animationpack = new Animation.fromJSON( "animationpack.json" );

  //wait for your resources to download
  Futures.wait([ spritepack.onLoad, animationpack.onLoad ]).then((){
    // Create a animator that will bind your animationpack to your spritepack
    Animator animator = new Animator( spritepack, animationpack );
    // After binding your spritepack and your animationpack you can run a sanityCheck.
    animator.sanityCheck();

    // Now you can change animations and run them.
    animator.changeAnimation("animation-1");
    int ang = 0;
    // Run this 60 times per second
    Timer timer = new Timer.periodic( const Duration(milliseconds: 1000~/60), (_) {
      display.clear();
      // The method runStep will run only one step of the animation.
      animator.runStep();
      // The method draw will draw the correct sprite for each animation frame.
      animator.draw( new Point2D(150,100), rotation: ang++ );
    });
  });
}
```

2\. Audio Module

2\.1\. Loading and playing a sound
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create a sound object.
  Sound sound = new Sound( soundUrl: "yoursound_url.wav" );
  // Play it after the sound is loaded.
  sound.onLoad.then((_) => sound.play());
}
```

2\.2\. Loading and playing a sound with loop
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create a sound object.
  Sound sound = new Sound( soundUrl: "yoursound_url.wav" );
  // Play it after the sound is loaded with the looping argument as true.
  sound.onLoad.then((_) => sound.play( looping: true ));
}
```

2\.3\. Getting the duration and gain of a sound
```dart
import 'package:gorgon/gorgon.dart';
main() {
  //
  Sound sound = new Sound( soundUrl: "yoursound_url.wav" );
  sound.onLoad.then((_){
    // You can set the base gain of the sound
    sound.gain = 0.5;
    // You can get the values just accessing them by their getters
    print("The sound gain is: ${sound.gain}");
    print("The sound duration is: ${sound.duration}");
  });
}
```

2\.4\. Getting and Setting the AudioChannel of a Sound
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create an AudioChannel
  AudioChannel my_ch = new AudioChannel("MyChannel");
  // You can set the gain of a channel
  my_ch.gain = 0.5;
  // You can check how many AudioInstances are registered in this channel.
  print("This channel has: ${my_ch.instances} instances");
  // You can mute and unmute your channel as well
  my_ch.mute = true;
  my_ch.mute = false;
  // And you can set your channel as a default channel for all sounds created after this operation.
  my_ch.setAsTarget();

  // You can use your channel when creating a sound. If you don`t expecify your channel, it will get the last AudioSystem targetChannel.
  Sound sound = new Sound( soundUrl: "yoursound_url.wav", channel: my_ch );
  sound.onLoad.then((_){
    // You can get your audioChannel
    AudioChannel channel = sound.channel;
    // When you play a sound, every modification defined in the Channel is applied to the Sound as well.
    sound.play();
  });
}
```

2\.5\. Getting an AudioInstance from a Sound and manipulating it.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Create a sound object.
  Sound sound = new Sound( soundUrl: "yoursound_url.wav" );
  // Play it after the sound is loaded with the looping argument as true.
  sound.onLoad.then((_) {
    // Everytime you play a sound it generates an new AudioInstance
    AudioInstance instance = sound.play();
    //You can set and get the instance gain.
    instance.gain = 0.5;
    print("The gain of this sound instance is: ${instance.gain}");
    // You can check if an AudioInstance is playing, scheduled for playing or is Finished.
    print("This instance is Playing: ${instance.isPlaying}");
    print("This instance is Scheduled: ${instance.isScheduled}");
    print("This instance is Finished: ${instance.isFinished}");
    // You can stop an AudioInstance.
    instance.stop();
    // And play it later.
    instance.play();
  });
}
```
2\.6\. Getting the used AudioChannels and searching for one.
```dart
import 'package:gorgon/gorgon.dart';
main() {
  // Get the AudioSystem singleton instance
  AudioSystem system = new AudioSystem();
  // You can get a list with the name of all registered channels.
  List<String> registeredChannels = system.channels;
  // You can search for an expecific channel as well.
  AudioChannel channel = system.channel( "Does this channel exist?" );
}
```


## Version

Gorgon is using the Semantic Versioning for the construction of it's version number. For more info about it check it at
[semver.org](http://semver.org/)

## License

Gorgon is licensed under the zlib license. For conditions of distribution and use, see copyright notice in [`LICENSE.txt`](LICENSE.txt).

## Thanks

Font File used in the tests - [Transcends Games](http://openfontlibrary.org/en/font/transcends-games)

Dalmo Pereira for creating the SpriteSheet used in the tests - <dalmokb@gmail.com>

Thanks for the [HTML5Rocks](http://www.html5rocks.com) which provided me with awesome tutorials and articles.
