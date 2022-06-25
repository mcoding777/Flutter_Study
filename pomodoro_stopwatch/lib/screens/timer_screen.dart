import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    // 러닝 상태일 때 버튼 위젯
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: const Text(
            1 == 2 ? '계속하기' : '일시정지', // 중단된 상태인가 ? true 계속하기 : false 일시정지
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      const Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Colors.grey),
          child: const Text('포기하기', style: TextStyle(fontSize: 16)))
    ];

    // 정지 상태일 때 버튼 위젯
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: 1 == 2
                ? Colors.green
                : Colors.blue), // 휴식 중인가? true 초록색 : false 파란색
        child: const Text('시작하기',
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('뽀모도로 타이머'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: 1 == 2
                    ? Colors.green
                    : Colors.blue // 휴식 중인가? true 초록색 : false 파란색
                ),
            child: const Center(
              child: Text(
                '00:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 1 == 2
                ? const []
                : 1 == 2
                    ? _stoppedButtons
                    : _runningButtons,
          ),
        ],
      ),
    );
  }
}
