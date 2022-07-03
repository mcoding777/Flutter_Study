import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('SplashScreen', style: TextStyle(fontSize: 20),),
            Text('나만의 일정 관리 : Todo 리스트 앱', style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    )
  }
}