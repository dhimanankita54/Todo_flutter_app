import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_item.dart';

void main() => runApp(MaterialApp(
      home: Todoapp(),
    ));

class Todoapp extends StatefulWidget {
  @override
  State<Todoapp> createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> {
  final todoList = Todo.todoList();
  final todoController = TextEditingController();
  List<Todo> foundTodo = [];

  @override
  void initState() {
    foundTodo = todoList;
    super.initState();
  }

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteTodo(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void addTodo(String toDo) {
    setState(() {
      todoList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: toDo));
    });
    todoController.clear();
  }

  void filter(String keyword) {
    List<Todo> res = [];
    if (keyword.isEmpty) {
      res = todoList;
    } else {
      res = todoList
          .where((element) =>
              element.text!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodo = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Container(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avtar.jpg'),
                ))
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    onChanged: (value) => filter(value),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20,
                        ),
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: 20, minWidth: 25),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Text(
                        'All Todos',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      for (Todo todo in foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          ontodoChanged: handleTodoChange,
                          onDelete: deleteTodo,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      hintText: "Add a new todo item",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addTodo(todoController.text);
                    },
                    child: Text('+',
                        style: TextStyle(
                          fontSize: 40,
                        )),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(60, 60),
                        elevation: 10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
