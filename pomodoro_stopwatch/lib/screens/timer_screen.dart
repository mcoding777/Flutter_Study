import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/secondsToString.dart';
import '../utils/showToast.dart';

enum TimerStatus {
  running, // 작업 중
  paused, // 일시정지
  stopped, // 정지
  resting // 휴식 중
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const workSeconds = 25;
  static const restSeconds = 5;

  late TimerStatus _timerStatus;
  late Timer _timer;
  late int _time; // 타이머 시간
  late int _pomodoroCount; // 뽀모도로 갯수

  @override
  void initState() {
    super.initState();
    _timerStatus = TimerStatus.stopped;
    showToast(_timerStatus.toString());
    _time = workSeconds;
    _pomodoroCount = 0;
  }

  @override
  void dispose() {
    // 앱이 종료될 때 Timer도 종료시키기
    _timer.cancel();
    super.dispose();
  }

  void run() {
    setState(() {
      _timerStatus = TimerStatus.running;
      showToast('[=>] $_timerStatus');
      runTimer();
    });
  }

  void rest() {
    setState(() {
      _time = restSeconds;
      _timerStatus = TimerStatus.resting;
      showToast('[=>] $_timerStatus');
    });
  }

  void pause() {
    setState(() {
      _timerStatus = TimerStatus.paused;
      showToast('[=>] $_timerStatus');
    });
  }

  void resume() {
    // 직관성을 위해 굳이 만든 함수!
    run();
  }

  void stop() {
    setState(() {
      _time = workSeconds;
      _timerStatus = TimerStatus.stopped;
      showToast('[=>] $_timerStatus');
    });
  }

  void runTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (_timer) {
      switch (_timerStatus) {
        case TimerStatus.paused:
          _timer.cancel();
          break;
        case TimerStatus.stopped:
          _timer.cancel();
          break;
        case TimerStatus.resting:
          if (_time <= 0) {
            setState(() {
              _pomodoroCount += 1;
            });
            showToast('오늘 $_pomodoroCount개의 뽀모도로를 달성했습니다.');
            _timer.cancel();
            stop();
          } else {
            setState(() {
              _time -= 1;
            });
          }
          break;
        case TimerStatus.running:
          if (_time <= 0) {
            showToast('작업 완료!');
            rest();
          } else {
            setState(() {
              _time -= 1;
            });
          }
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 러닝 상태일 때 버튼 위젯
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: () {
          _timerStatus == TimerStatus.paused ? resume() : pause();
        },
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: Text(
            _timerStatus == TimerStatus.paused
                ? '계속하기'
                : '일시정지', // 중단된 상태인가 ? true 계속하기 : false 일시정지
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
      const Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
          onPressed: stop,
          style: ElevatedButton.styleFrom(primary: Colors.grey),
          child: const Text('포기하기', style: TextStyle(fontSize: 16)))
    ];

    // 정지 상태일 때 버튼 위젯
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        onPressed: run,
        style: ElevatedButton.styleFrom(
            primary: _timerStatus == TimerStatus.resting
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
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _timerStatus == TimerStatus.resting
                    ? Colors.green
                    : Colors.blue // 휴식 중인가? true 초록색 : false 파란색
                ),
            child: Center(
              child: Text(
                secondsToString(_time),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _timerStatus == TimerStatus.resting
                ? const []
                : _timerStatus == TimerStatus.stopped
                    ? _stoppedButtons
                    : _runningButtons,
          ),
        ],
      ),
    );
  }
}
