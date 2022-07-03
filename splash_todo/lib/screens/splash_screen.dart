import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();875
    Timer(const Duration(seconds: 2), () {
      moveScreen();
    });
  }

  void moveScreen() async {
    // 로그인 정보 확인 후(async await) 결과 값에 따라 함수 실행
    await checkLogin().then((isLogin) {
      if (isLogin) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  // shared_preferences 패키지 사용
  // Future == 자바스크립트의 promise와 비슷?
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false; // isLogin 값이 있으면 가져오고, 없으면 false (?? 연산자 => Null 값이 아닌 것을 return)
    print("[*] isLogin : " + isLogin.toString());
    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'SplashScreen',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '나만의 일정 관리 : Todo 리스트 앱',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
