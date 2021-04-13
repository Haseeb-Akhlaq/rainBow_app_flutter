import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_colors_app/screens/configration_screen.dart';
import 'package:rainbow_colors_app/widgets/heart.dart';

class RainBowScreen extends StatefulWidget {
  RainBowScreen({this.title});

  final String title;

  @override
  _RainBowScreenState createState() => _RainBowScreenState();
}

class _RainBowScreenState extends State<RainBowScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  List filePath = [
    'default.mp3',
  ];

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;

  int selectedSound = 0;
  bool playFromMobile = false;

  String musicPath = '';

  playMusic() async {
    if (playFromMobile) {
      await audioPlayer.play(musicPath);
    } else {
      await audioCache.play(filePath[selectedSound]);
    }
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  changeMusic(int index) {
    setState(() {
      playFromMobile = false;
      selectedSound = index;
    });
  }

  songFromDevice(String path, bool playDeviceSong) {
    setState(() {
      musicPath = path;
      playFromMobile = playDeviceSong;
    });
  }

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });

    playMusic();
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  audioPlayerState == AudioPlayerState.PLAYING
                      ? pauseMusic()
                      : playMusic();
                },
                child: ColorCycler(
                  pauseMusic: pauseMusic,
                  playmusic: playMusic,
                  musicchange: changeMusic,
                  selectSongFromDevice: songFromDevice,
                )),
          ],
        ),
      ),
    );
  }
}

class ColorCycler extends StatefulWidget {
  final Function pauseMusic;
  final Function playmusic;
  final Function musicchange;
  final Function selectSongFromDevice;

  const ColorCycler({
    this.pauseMusic,
    this.playmusic,
    this.musicchange,
    this.selectSongFromDevice,
  });

  @override
  _ColorCyclerState createState() => _ColorCyclerState();
}

class _ColorCyclerState extends State<ColorCycler>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  List animateColors() {
    if (animation.value.toInt() == 0) {
      return [
        Color(0xffff0000),
        Color(0xffffa500),
        Color(0xffffff00),
        Color(0xff008000),
        Color(0xff0000ff),
        Color(0xff4b0082),
        Color(0xffee82ee),
      ];
    } else if (animation.value.toInt() == 1) {
      return [
        Color(0xffee82ee),
        Color(0xffff0000),
        Color(0xffffa500),
        Color(0xffffff00),
        Color(0xff008000),
        Color(0xff0000ff),
        Color(0xff4b0082),
      ];
    } else if (animation.value.toInt() == 2) {
      return [
        Color(0xff4b0082),
        Color(0xffee82ee),
        Color(0xffff0000),
        Color(0xffffa500),
        Color(0xffffff00),
        Color(0xff008000),
        Color(0xff0000ff),
      ];
    } else if (animation.value.toInt() == 3) {
      return [
        Color(0xff0000ff),
        Color(0xff4b0082),
        Color(0xffee82ee),
        Color(0xffff0000),
        Color(0xffffa500),
        Color(0xffffff00),
        Color(0xff008000),
      ];
    } else if (animation.value.toInt() == 4) {
      return [
        Color(0xff008000),
        Color(0xff0000ff),
        Color(0xff4b0082),
        Color(0xffee82ee),
        Color(0xffff0000),
        Color(0xffffa500),
        Color(0xffffff00),
      ];
    } else if (animation.value.toInt() == 5) {
      return [
        Color(0xffffff00),
        Color(0xff008000),
        Color(0xff0000ff),
        Color(0xff4b0082),
        Color(0xffee82ee),
        Color(0xffff0000),
        Color(0xffffa500),
      ];
    } else if (animation.value.toInt() == 6) {
      return [
        Color(0xffffa500),
        Color(0xffffff00),
        Color(0xff008000),
        Color(0xff0000ff),
        Color(0xff4b0082),
        Color(0xffee82ee),
        Color(0xffff0000),
      ];
    }
    return [
      Color(0xffffa500),
      Color(0xffffff00),
      Color(0xff008000),
      Color(0xff0000ff),
      Color(0xff4b0082),
      Color(0xffee82ee),
      Color(0xffff0000),
    ];
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    animation = Tween<double>(begin: 0, end: 7).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.99;
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, _) => Stack(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[0],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[1],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[2],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[3],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[4],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[5],
                    ),
                    Container(
                      height: screenHeight / 7,
                      color: animateColors()[6],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        IconButton(
                          onPressed: () async {
                            widget.pauseMusic();
                            bool returned = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfigrationScreen(
                                  musicChange: widget.musicchange,
                                  selectSongFromDevice:
                                      widget.selectSongFromDevice,
                                ),
                              ),
                            );
                            if (returned == null) {
                              widget.playmusic();
                            }
                            print(returned);
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        HeartWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
