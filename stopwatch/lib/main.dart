import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Text('예시'), // _buildBody(),
      bottomNavigationBar: BottomAppBar(
        // 라우터 기능이 있는 하단 바 : FloatingButton과 BottomAppBar은 거의 같이 쓰인다
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 다른 위젯에 방해 받지 않는, 띄우기 버튼 위젯
        onPressed: () => setState(() {
          // _clickButton();
        }),
        child: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 버튼의 위치 : 아래쪽 가운데
    );
  }
}
