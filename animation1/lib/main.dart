import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Animation1(),
    );
  }
}

class Animation1 extends StatefulWidget {
  const Animation1({super.key});

  @override
  State<Animation1> createState() => _Animation1State();
}

//SINGLETICKERPROVIDERSTATEMIXIN IS A MIXIN NEEDED HERE
class _Animation1State extends State<Animation1>
    with SingleTickerProviderStateMixin {
  //ANIMATION CONTROLLER IS NEEDED TO CONTROL THE ANIMATION
  late AnimationController _controller;
  //ANIMATION IS NEEDED TO DEFINE THE ANIMATION
  late Animation<double> _animation;

  void initState() {
    super.initState();

    // Create an AnimationController that manages the animation
    _controller = AnimationController(
      vsync: this, // Provides a ticking mechanism for the animation
      duration: Duration(seconds: 2), // Duration of the animation (2 seconds)
    );

    // Create an Animation object that defines the range of values for the animation
    // In this case, it goes from 0 to 2 * pi (a full circle)
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    // Repeats the animation indefinitely
    _controller.repeat();
  }

  //DONT FORGET TO DISPOSE THE CONTROLLER
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            //NEED TO LISTEN TO THE ANIMATION AS THE CONTROLLER IS CHANGING CONTINUOSLY
            animation: _animation,
            builder: (context, child) {
              return Transform(
                  //ROTATING AROUND THE CENTER SO CENTER IS THE PIVOT POINT(IF I DO TOPLEFT MEANS
                  // THAT IT WILL LOOK LIKE SOMEONE IS HOLDING THE CONTAINER FROM THE TOP LEFT CORNER AND ROTATING IT)
                  //INSTEAD OF ALIGNMENT WE CAN ALSO USE
                  //ORIGIN: OFFSET(0,0) WHICH IS THE DEFAULT VALUE  (offset(x,y)) ORIGIN BEING THE
                  //TOP LEFT CORNER (THE AXIS IS INVERTED)
                  alignment: Alignment.center,
                  //ROTATING AROND THE Z AXIS BY eg(PI/4) RADIANS AROUND THE CIRCUMFERENCE OF THE
                  // IMAGINARY CIRCLE MADE BY THINKING THE CENTER AS A MID POINT
                  // Rotate around the Y-axis by the current value of the animation
                  transform: Matrix4.identity()..rotateY(_animation.value),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ));
            }),
      ),
    );
  }
}
//STILL IT WONT WORK UNLESS WE RERENDER THE SCREEN USING ANIMATEDBUILDER
