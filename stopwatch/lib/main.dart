import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchPage(title: 'StopWatch'),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  late Timer _timer; // Timer는 non-nullable => 초기화를 늦추기 위한 late 키워드 사용

  var _time = 0; // 0.01초마다 1씩 증가시킬 정수형 변수
  var _isRunning = false; // 현재 시작 상태

  List<String> _lapTimes = []; // 랩타임에 표시할 시간을 저장하는 리스트

  @override
  void dispose() {
    // 앱이 종료될 때 Timer도 종료시키기
    _timer?.cancel(); // 경고 발생 : 수신자는 null 일 수 없다
    super.dispose();
  }

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  Widget _buildBody() {
    var sec = _time ~/ 100; // 초 (몫을 구하는 연산자 ~/)
    var hundredth =
        '${_time % 100}'.padLeft(2, '0'); // 1/100초 (2글자로 표현하기 위한 함수 padLeft)

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Stack(children: <Widget>[
          // Stack은 여러 위젯을 겹칠 수 있음
          Column(
            children: <Widget>[
              Row(
                // 시간을 표시하는 영역
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // 여기는 왜 const가 붙어야 할까?
                  // flutter의 위젯, final, const에 대한 것 : https://sudarlife.tistory.com/entry/Flutter-%EC%97%90%EC%84%9C%EC%9D%98-immutable-mutable%ED%95%9C-%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A5%BC-immutable-%ED%95%98%EA%B2%8C-%EC%82%AC%EC%9A%A9%ED%95%98%EC%9E%90
                  Text(
                    // 초
                    '$sec',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  Text(hundredth),
                ],
              ),
              SizedBox(
                // Container 또는 SizedBox (둘의 차이는 https://memostack.tistory.com/188)
                // 랩 타임을 표시하는 영역
                width: 100,
                height: 200,
                child: ListView(
                  children: const <Widget>[],
                ),
              )
            ],
          ),
          Positioned(
            // 위치 잡는 위젯
            left: 10,
            bottom: 10,
            child: FloatingActionButton(
              // 왼쪽 아래에 위치한 초기화 버튼
              backgroundColor: Colors.deepOrange,
              onPressed: () {
                // 초기화 버튼 눌렀을 때 이벤트
              },
              child: const Icon(Icons.rotate_left),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: ElevatedButton(
              // 버튼을 강조하고 싶을 때 사용하는 위젯
              // 오른쪽 아래에 위치한 랩 타임 버튼
              onPressed: () {
                // 초기화 버튼 눌렀을 때 이벤트
              },
              child: const Text('랩타임'),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        // 라우터 기능이 있는 하단 바 : FloatingButton과 BottomAppBar은 거의 같이 쓰인다
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 다른 위젯에 방해 받지 않는, 띄우기 버튼 위젯
        onPressed: () => setState(() {
          _clickButton();
        }),
        child:
            _isRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 버튼의 위치 : 아래쪽 가운데
    );
  }
}
