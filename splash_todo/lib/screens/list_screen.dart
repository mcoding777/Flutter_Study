import 'dart:async';

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../providers/todo_default.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String title = '';
              String description = '';
              return AlertDialog(
                title: const Text('할 일 추가하기'),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          title = value;
                        },
                        decoration: const InputDecoration(labelText: '제목'),
                      ),
                      TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: const InputDecoration(labelText: '설명'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        print('[UI] ADD');
                        todoDefault.addTodo(
                          Todo(title: title, description: description),
                        );
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('추가'),
                  ),
                  TextButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        },
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
