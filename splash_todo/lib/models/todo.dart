class Todo {
  late int? id; // int? => null이 될 수 있는 값 => id = null 해도 됨
  late String title;
  late String description;

  Todo({
    this.id,
    required this.title, // required : 무조건 입력해야하는 인자
    required this.description,
  });

  // json 양식
  Map<String, dynamic> toMap() {
    // dynamic : 다양한 타입 호환. 타입 보호가 되지 않음
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }
}
