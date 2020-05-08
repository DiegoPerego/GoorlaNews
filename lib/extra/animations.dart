import 'package:flutter/material.dart';

class AnimationsTest extends StatefulWidget {
  @override
  AnimationsTestState createState() => AnimationsTestState();
}

class AnimationsTestState extends State<AnimationsTest>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;
  bool pressed = false;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: -0.35, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _animationController.reverse();
        else if (status == AnimationStatus.dismissed)
          _animationController.forward();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double heigth = MediaQuery.of(context).size.height;

    _animationController.forward();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Transform(
            transform: Matrix4.translationValues(
                animation.value * width, animation.value * heigth, 0.0),
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        pressed = !pressed;
                      });
                    },
                    child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: pressed ? 100 : 200,
                        height: pressed ? 100 : 200,
                        color: pressed
                            ? Colors.yellow
                            : Colors.red))));
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
