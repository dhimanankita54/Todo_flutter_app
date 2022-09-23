import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ontodoChanged;
  final onDelete;
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.ontodoChanged,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          ontodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.indigo,
        ),
        title: Text(
          todo.text!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
              onPressed: () {
                onDelete(todo.id);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }
}
