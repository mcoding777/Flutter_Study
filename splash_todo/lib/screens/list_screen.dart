import 'package:flutter/material.dart';
import '../models/todo.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('initState');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록 앱'),
        actions: [
          InkWell(
            // 버튼 클릭 시 물결 표시
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.book), Text('뉴스')],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '+',
          style: TextStyle(fontSize: 25),
        ),
        onPressed: () {},
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // spinner 화면 표시
            )
          : ListView.separated(
              // ListView.separated : ListView에 구분자를 넣어주는 위젯
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () {},
                  trailing: Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            child: const Icon(Icons.edit),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            child: const Icon(Icons.delete),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                // 구분자
                return const Divider();
              },
              itemCount: todos.length),
    );
  }
}
