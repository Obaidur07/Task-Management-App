import 'package:flutter/material.dart';
import 'package:todoapplication/Homepage.dart';
import 'package:todoapplication/colors.dart';
import 'package:todoapplication/todo.dart';

class TodoItems extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;
  final Color color;
  final Color textColor;

  const TodoItems({Key? key,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItem, required this.color,
    required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
      child: ListTile(
        onTap: (){
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: color,
        leading: Icon(
          todo.isDone! ? Icons.check_box: Icons.check_box_outline_blank_rounded,
          color: Colors.blue,
        ),
        title: Text(todo.task!,
          style: TextStyle(
            color: textColor,
            decoration: todo.isDone! ? TextDecoration.lineThrough:null,
          ),),
        trailing: GestureDetector(
          onTap: (){
            onDeleteItem(todo.id);
          },
            child: const Icon(Icons.delete,color: Colors.red,)),
      ),
    );
  }
}
