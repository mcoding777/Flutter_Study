import 'package:flutter/material.dart';

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키
  // GlobalKey : 요소를 식별함, 다른 키로 접근할 수 있는 방법을 제공, 하위 위젯에도 적용됨

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비만도 계산기'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey, // 글로벌 키 할당
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // 외곽선 있음
                    hintText: '키', // placeholder는 키
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력 가능함
                ),
                const SizedBox(
                  height: 16.0, // input 요소 사이에 여백 제공
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '몸무게',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  // 결과 버튼이 들어갈 컨테이너
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight, // 텍스트 정렬은 가운데
                  child: ElevatedButton(
                    onPressed: () {
                      // 버튼 누르면 폼에 입력된 값 검증하기
                      if (_formKey.currentState!.validate()) {
                        // 검증 시 어떻게 처리할래?
                      }
                    },
                    child: const Text('결과'),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
