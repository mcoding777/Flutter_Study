import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splash_todo/providers/todo_sqlite.dart';

import '../models/todo.dart';
import '../providers/todo_sqlite.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoSqlite todoSqlite = TodoSqlite();
  bool isLoading = true;

  Future initDb() async {
    await todoSqlite.initDb().then((value) async {
      todos = await todoSqlite.getTodos();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      initDb().then((_) {
        setState(() {
          isLoading = false;
        });
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
                        todoSqlite.addTodo(
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('할 일'),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text('제목 : ' + todos[index].title),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text('설명 : ' + todos[index].description),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  trailing: Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            child: const Icon(Icons.edit),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String title = todos[index].title;
                                  String description = todos[index].description;
                                  return AlertDialog(
                                    title: const Text('할 일 수정하기'),
                                    content: Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              title = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: todos[index].title,
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (value) {
                                              description = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                                  todos[index].description,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Todo newTodo = Todo(
                                            id: todos[index].id,
                                            title: title,
                                            description: description,
                                          );
                                          setState(() {
                                            todoSqlite.updateTodo(newTodo);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('수정'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('취소'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            child: const Icon(Icons.delete),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('할 일 삭제하기'),
                                    content: Container(
                                      child: const Text('삭제하시겠습니까?'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            todoSqlite.deleteTodo(
                                                todos[index].id ?? 0);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('삭제'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('취소'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
