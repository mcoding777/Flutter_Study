import 'package:flutter/material.dart';

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키
  // GlobalKey : 요소를 식별함, 다른 키로 접근할 수 있는 방법을 제공, 하위 위젯에도 적용됨

  final _heightController = TextEditingController(); // 인풋 값을 가져올 컨트롤러 객체
  final _weightController = TextEditingController();

  @override
  void dispose() {
    // 화면이 종료될 때 컨트롤러 해제
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

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
                  controller: _heightController, // 컨트롤러 연결
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      // 입력한 값의 앞뒤 공백을 제외한 값이 비어있다면
                      return '키를 입력하세요';
                    }
                    return null; // 에러가 없으면 null 반환
                  },
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
                  controller: _weightController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return '몸무게를 입력하세요';
                    }
                    return null;
                  },
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
