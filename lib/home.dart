import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _onScroll();
      });
    super.initState();
  }

  double _scrollOffset = 0.0;

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      print(_scrollOffset);

      // find middle of the screen
      if (_screenHeight == null || _layoutHeight == null) return;

      if (_scrollOffset * _layer1Speed > _screenHeight! * 0.5) {
        showText = true;
      } else {
        showText = false;
      }
    });
  }

  // layers speed
  final double _layer1Speed = 0.5;
  final double _layer2Speed = 0.45;
  final double _layer3Speed = 0.42;
  final double _layer4Speed = 0.375;
  final double _sunSpeed = 0.25;

  // layers horizontal speed
  final double _layer1HSpeed = 0.1;
  final double _layer2HSpeed = 0.08;
  final double _layer3HSpeed = 0.075;
  final double _layer4HSpeed = 0.07;

  bool showText = false;

  double? _layoutHeight;
  double? _screenHeight;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 3;

    _layoutHeight = layoutHeight;
    _screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 66, 240, 210),
            Color.fromARGB(255, 253, 244, 193),
          ],
        )),
        child: Stack(
          children: [
            Positioned(
              bottom: screenSize.height * 0.5 + (_scrollOffset * _sunSpeed),
              right: screenSize.width * 0.3,
              child: SvgPicture.asset("assets/sun.svg"),
            ),
            Positioned(
              bottom: _layer4Speed * _scrollOffset,
              right: _layer4HSpeed * _scrollOffset * -1,
              left: _layer4HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                "assets/mountains-layer-4.svg",
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: _layer3Speed * _scrollOffset,
              right: _layer3HSpeed * _scrollOffset * -1,
              left: _layer3HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                "assets/mountains-layer-2.svg",
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: _layer2Speed * _scrollOffset,
              right: _layer2HSpeed * _scrollOffset * -1,
              left: _layer2HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                "assets/trees-layer-2.svg",
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: -20 + _layer1Speed * _scrollOffset,
              right: _layer1HSpeed * _scrollOffset * -1,
              left: _layer1HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                "assets/layer-1.svg",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: -screenSize.height + (_layer1Speed * _scrollOffset),
              right: 0,
              left: 0,
              height: screenSize.height,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: showText ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 900,
                    ),
                    child: const Text(
                      "This is the parallax effect",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                height: layoutHeight,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
