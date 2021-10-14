import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  static const style = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      color: Colors.indigo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/images/1.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: const [
              Text(
                "Hello Everyone!",
                style: SplashScreen.style,
              ),
              Text(
                "Let's ",
                style: SplashScreen.style,
              ),
              Text(
                "Explore the Space",
                style: SplashScreen.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: const Color(0xFF232323),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/2.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            children: const [
              Text(
                "Get to",
                style: SplashScreen.style,
              ),
              Text(
                "Know our",
                style: SplashScreen.style,
              ),
              Text(
                "Solar System",
                style: SplashScreen.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: const Color(0xFF460BA1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/3.jpg',
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: const [
              Text(
                "Ejoy",
                style: SplashScreen.style,
              ),
              Text(
                "the",
                style: SplashScreen.style,
              ),
              Text(
                "Journey!",
                style: SplashScreen.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepOrange.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Image.asset(
              'assets/images/4.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: const [
              Text(
                "Be",
                style: SplashScreen.style,
              ),
              Text(
                "Like",
                style: SplashScreen.style,
              ),
              Text(
                "Astronaut",
                style: SplashScreen.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Image.asset(
              'assets/images/5.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: const [
              Text(
                "Feel",
                style: SplashScreen.style,
              ),
              Text(
                "the",
                style: SplashScreen.style,
              ),
              Text(
                "Moon",
                style: SplashScreen.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              LiquidSwipe(
                pages: pages,
                slideIconWidget: const Icon(Icons.arrow_back_ios),
                onPageChangeCallback: pageChangeCallback,
                waveType: WaveType.liquidReveal,
                liquidController: liquidController,
                enableSideReveal: true,
                ignoreUserGestureWhileAnimating: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(pages.length, _buildDot),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextButton(
                    onPressed: () {
                      liquidController.animateToPage(
                          page: pages.length - 1, duration: 700);
                    },
                    child: const Text("Skip to End",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextButton(
                    onPressed: () {
                      liquidController.jumpToPage(
                          page: liquidController.currentPage + 1 >
                                  pages.length - 1
                              ? 0
                              : liquidController.currentPage + 1);
                    },
                    child: const Text("Next",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
