import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeartWidgets extends StatefulWidget {
  @override
  _HeartWidgetsState createState() => _HeartWidgetsState();
}

class _HeartWidgetsState extends State<HeartWidgets>
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
    double width = MediaQuery.of(context).size.width * 0.99;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[6],
          width: width,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[5],
          width: width * 0.90,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[4],
          width: width * 0.75,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[3],
          width: width * 0.65,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[2],
          width: width * 0.50,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[1],
          width: width * 0.40,
        ),
        SvgPicture.asset(
          'assets/heart.svg',
          color: animateColors()[0],
          width: width * 0.30,
        ),
      ],
    );
  }
}
