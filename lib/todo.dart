class Todo {
  String id;
  String text;
  bool isDone;

  Todo({required this.id, required this.text, this.isDone = false});

  static List<Todo> todoList() {
    return [
      Todo(id: '01', text: 'Check Grocery', isDone: true),
      Todo(id: '02', text: 'Check Emails', ),
      Todo(id: '03', text: 'Check Meetings', isDone: true),
      Todo(id: '04', text: 'Check Emails', ),
      Todo(id: '05', text: 'Check Emails', isDone: true),
      Todo(id: '06', text: 'Check Emails', ),
    ];
  }

}
