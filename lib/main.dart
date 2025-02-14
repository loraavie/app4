import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Three Screen App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

//loras screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedStars = 0;

  void _setRating(int rating) {
    setState(() {
      _selectedStars = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Lora\'s Screen',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ))),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Welcome to Lora\'s Screen',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/dog.webp',
                    height: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Text(
                          '<-This is the dog I have in me.',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                color: index < _selectedStars
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 40,
                              ),
                              onPressed: () => _setRating(index + 1),
                            );
                          }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //comment commit #1
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                          textStyle: WidgetStatePropertyAll(
                              TextStyle(color: Colors.white))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ScreenOne()),
                        );
                      },
                      child: Text(
                        'Go to Kaleb\'s Screen',
                        selectionColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                          textStyle: WidgetStatePropertyAll(
                              TextStyle(color: Colors.white))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ScreenTwo()),
                        );
                      },
                      child: Text(
                        'Go to Amy\'s Screen',
                        selectionColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//kalebs screen
class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

//Commment commit #2, this was stressful
class _ScreenOneState extends State<ScreenOne> with TickerProviderStateMixin {
  double _lightX = 150;
  double _lightY = 300;
  late Offset _dragStartOffset;
  late ValueNotifier<Offset> _lightPosition;

  final double _fishX = 200;
  final double _fishY = 500;
  final double _revealDistance = 100;

  late AnimationController firstController;
  late Animation<double> firstAnimation;
  late AnimationController secondController;
  late Animation<double> secondAnimation;
  late AnimationController thirdController;
  late Animation<double> thirdAnimation;
  late AnimationController fourthController;
  late Animation<double> fourthAnimation;
  @override
  void initState() {
    super.initState();
    _lightPosition = ValueNotifier(Offset(_lightX, _lightY));

    firstController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat(reverse: true);
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
      CurvedAnimation(parent: firstController, curve: Curves.easeInOut),
    );

    secondController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat(reverse: true);
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
      CurvedAnimation(parent: secondController, curve: Curves.easeInOut),
    );

    thirdController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat(reverse: true);
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
      CurvedAnimation(parent: thirdController, curve: Curves.easeInOut),
    );

    fourthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat(reverse: true);
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
      CurvedAnimation(parent: fourthController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    _lightPosition.dispose();
    super.dispose();
  }

  bool isFishVisible(Offset lightPos) {
    double distance =
        sqrt(pow(lightPos.dx - _fishX, 2) + pow(lightPos.dy - _fishY, 2));
    return distance < _revealDistance;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Deep Sea Discovery')),
      backgroundColor: Color(0xff2B2C56),
      body: Stack(
        children: [
          // Water Animation
          AnimatedBuilder(
            animation: Listenable.merge([
              firstController,
              secondController,
              thirdController,
              fourthController
            ]),
            builder: (context, child) {
              return CustomPaint(
                painter: MyPainter(firstAnimation.value, secondAnimation.value,
                    thirdAnimation.value, fourthAnimation.value),
                child: SizedBox(height: size.height, width: size.width),
              );
            },
          ),

          // Light Effect Layer
          ValueListenableBuilder(
            valueListenable: _lightPosition,
            builder: (context, Offset pos, child) {
              return Positioned.fill(
                child: CustomPaint(
                  painter: LightPainter(pos.dx, pos.dy),
                ),
              );
            },
          ),

          // Anglerfish (Hidden Until Light is Near)
          ValueListenableBuilder(
            valueListenable: _lightPosition,
            builder: (context, Offset pos, child) {
              bool visible = isFishVisible(pos);
              return Positioned(
                left: _fishX - 40,
                top: _fishY - 40,
                child: AnimatedOpacity(
                  opacity: visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Image.asset(
                    'assets/images/blue-eyed-anglerfish.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // Draggable Light Source
          ValueListenableBuilder(
            valueListenable: _lightPosition,
            builder: (context, Offset pos, child) {
              return Positioned(
                left: pos.dx - 25,
                top: pos.dy - 25,
                child: GestureDetector(
                  onPanStart: (details) {
                    _dragStartOffset = Offset(
                        details.globalPosition.dx - pos.dx,
                        details.globalPosition.dy - pos.dy);
                  },
                  onPanUpdate: (details) {
                    _lightPosition.value = Offset(
                      details.globalPosition.dx - _dragStartOffset.dx,
                      details.globalPosition.dy - _dragStartOffset.dy,
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow.withOpacity(0.8),
                    ),
                  ),
                ),
              );
            },
          ),

          // 📌 Back & Forward Buttons (Now Fixed)
          Positioned(
            bottom: 80,
            left: size.width * 0.25,
            right: size.width * 0.25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ),

          Positioned(
            bottom: 20,
            left: size.width * 0.25,
            right: size.width * 0.25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenTwo()),
                );
              },
              child: Text('Go to Amy\'s Screen'),
            ),
          ),
        ],
      ),
    );
  }
}

// Water Effect Painter
class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;
  MyPainter(
      this.firstValue, this.secondValue, this.thirdValue, this.fourthValue);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff3B6ABA).withOpacity(0.8)
      ..style = PaintingStyle.fill;
    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * 0.4, size.height / secondValue, size.width * 0.7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Light Effect Painter
class LightPainter extends CustomPainter {
  final double x;
  final double y;
  LightPainter(this.x, this.y);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withOpacity(0.6), Colors.transparent],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 100));

    canvas.drawCircle(Offset(x, y), 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Amy's Favorite Show Screen"),
          backgroundColor: Colors.amber),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/download.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "THE MANDELORIAN!! is my new fav show to watch with my DOG!!!",
                    style: TextStyle(
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 87, 1))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  child: Text("Back to Kaleb's Screen"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  child: Text("Back to Lora's Screen"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
