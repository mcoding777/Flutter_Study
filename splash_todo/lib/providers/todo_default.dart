import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoDefault {
  List<Todo> dummyTodos = [
    Todo(id: 1, title: '플러터 공부 시작하기', description: '뽕 뽑는 플러터를 읽어봅시다.'),
    Todo(id: 2, title: '당근 거래하기', description: '오후 7시 30분 에어팟 거래'),
    Todo(id: 3, title: '강아지랑 산책하기', description: '퇴근 하자마자 산책하기'),
    Todo(id: 4, title: '블로그 글 쓰기', description: '공부한 내용 블로그에 정리'),
  ];

  List<Todo> getTodos() {
    return dummyTodos;
  }

  Todo getTodo(int id) {
    return dummyTodos[id];
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(
        id: dummyTodos.length + 1,
        title: todo.title,
        description: todo.description);
    dummyTodos.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == id) {
        dummyTodos.removeAt(i);
      }
    }
  }

  void updateTodo(int index, Todo todo) {
    dummyTodos[index] = todo;
  }
}
