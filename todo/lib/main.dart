import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 할 일 클래스
class Todo {
  bool isDone = false;
  String title;

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[]; // 할일 목록을 저장할 리스트
  final _todoController = TextEditingController();

  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = ''; // 할일 입력 필드를 비우기
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      // 높이가 고정된 1개의 행, 텍스트나 아이콘 등을 포함한다
      onTap: () {
        setState(() {
          _toggleTodo(todo);
        });
      },
      title: Text(
        todo.title,
        style: todo.isDone
            ? const TextStyle(
                decoration: TextDecoration.lineThrough, // 취소선
                fontStyle: FontStyle.italic, // 이탤릭체
              )
            : null,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () {
          setState(() {
            _deleteTodo(todo);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('남은 할 일'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    // Row나 Column의 자식 위젯, 부모의 남은 부분을 전부 채운다
                    // 할일 등록하는 input 영역
                    child: TextField(
                      controller: _todoController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _addTodo(Todo(_todoController.text));
                      },
                      child: const Text('추가'))
                ],
              ),
              Expanded(
                // 등록된 할일이 보이는 영역
                child: ListView(
                  children:
                      _items.map((todo) => _buildItemWidget(todo)).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
