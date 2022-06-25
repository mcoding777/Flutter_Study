import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    // 계속하기 or 일시정지 & 포기하기 버튼
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: const Text(1 == 2 ? '계속하기' : '일시정지',
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      const Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Colors.grey),
          child: const Text('포기하기', style: TextStyle(fontSize: 16)))
    ];
    return Scaffold();
  }
}
