import 'package:flutter/material.dart';
import 'dart:async';
import 'package:samiha/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController controller;


  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      (){ 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder:(context) =>const Home())
        );
      }
    );
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 105, 248),
      body: Container(
        width: width*1, 
        height: height*1,
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 33, 105, 248),
              Color.fromARGB(255, 28, 91, 216), 
              Color.fromARGB(255, 22, 73, 173),
              Color.fromARGB(255, 18, 58, 138), 
            ]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "DIAGNOskin",
                style: TextStyle(
                  fontSize: 21, 
                  color: Colors.white, 
                  fontWeight: FontWeight.bold
                ),
              ), 
              const SizedBox(height: 15,),
              Container(
                width: 150, 
                child:LinearProgressIndicator(
                  color: Colors.white,
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ), 
            ],
          ) 
        ),
      )
    );
  }
}