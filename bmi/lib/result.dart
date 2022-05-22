import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  const BmiResult(this.height, this.weight, {Key? key})
      : super(key: key); // 키와 몸무게를 받는 생성자

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));

    String _calcBmi(double bmi) {
      var result = '저체중';

      if (bmi >= 35) {
        result = '고도 비만';
      } else if (bmi >= 30) {
        result = '2단계 비만';
      } else if (bmi >= 25) {
        result = '1단계 비만';
      } else if (bmi >= 23) {
        result = '과체중';
      } else if (bmi >= 18.5) {
        result = '정상';
      }
      return result;
    }

    Widget _buildIcon(double bmi) {
      if (bmi >= 23) {
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          size: 100,
        );
      } else if (bmi >= 18.5) {
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.green,
          size: 100,
        );
      } else {
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.orange,
          size: 100,
        );
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text('비만도 계산기')),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _calcBmi(
                      bmi), // 에러 발생 : 'Null' 유형의 값은 const 생성자에서 'String' 유형의 매개변수에 할당할 수 없습니다. 하위 유형을 사용하거나 'const' 키워드를 제거해 보십시오.
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildIcon(bmi),
              ]),
        ));
  }
}
