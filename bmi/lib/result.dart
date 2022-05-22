import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  const BmiResult(this.height, this.weight, {Key? key})
      : super(key: key); // 키와 몸무게를 받는 생성자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('비만도 계산기')),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  '정상',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.green,
                  size: 100,
                )
              ]),
        ));
  }
}
