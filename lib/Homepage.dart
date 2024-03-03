import 'package:flutter/material.dart';
import 'package:todoapplication/colors.dart';
import 'package:todoapplication/todo.dart';
import 'package:todoapplication/todoItems.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final todoList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundTodo = [];
  bool isDarkmode = false;

  @override
  void initState() {
    super.initState();
    _foundTodo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkmode ? Colors.grey[400]:Colors.black,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        backgroundColor: isDarkmode? Colors.white : Colors.grey[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
                Icons.menu,
                color: isDarkmode ? Colors.black : Colors.white
            ),
            Text(
                'TaskVault',
              style: TextStyle(
                color: isDarkmode ? Colors.black : Colors.white
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/ProfileImage.png'),
              ),
            ),
          ],
        )
      ),
      body: Stack(
        children: [
          Column(
            children: [
              searchBox(),
              Center(child: Text('Your Tasks',
                style: TextStyle(
                    fontWeight:
                    FontWeight.w500,
                    fontSize: 25,
                  color: isDarkmode ? Colors.black:Colors.white54
                ),
              )),
              const SizedBox(height: 5,),
              Expanded(
                child: ListView(
                  children:  [
                    for(Todo i in _foundTodo.reversed )
                      TodoItems(
                        todo: i,
                        onTodoChanged: _handleTodoChange,
                        onDeleteItem: _deleteTodoItem,
                        color: isDarkmode ?  Colors.white :Color(0xFF212121),
                        textColor: isDarkmode ?  Color(0xFF616161) :Colors.white ,
                      ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                        right: 20
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: isDarkmode?Colors.white:Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new Task',
                        hintStyle: TextStyle(color: isDarkmode ? Colors.grey[700]:Colors.white ),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: (){
                            _todoController.text.isEmpty?null:_addTodoItem(_todoController.text);
                          },
                            child: const Icon(
                              Icons.add_circle_rounded,
                              size: 30,
                              color: Colors.lightGreen,
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,right: 20),
                  child: FloatingActionButton(
                    onPressed: (){
                      setState(() {
                        isDarkmode = !isDarkmode;
                      });
                    },
                    child: Icon(isDarkmode ? Icons.dark_mode_outlined:Icons.dark_mode),

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo){
    setState(() {
      if(todo.isDone == true) {
        todo.isDone =false;
      } else {
        todo.isDone=true;
      }
    });
  }

  void _deleteTodoItem(String id){
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addTodoItem(String task){
    setState(() {
      todoList.add(
        Todo(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            task: task
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList.where((item) => item.task!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: Colors.grey,width: 0.5),
          color: isDarkmode?Colors.white:Colors.grey[900],
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search_sharp,
              color: isDarkmode ? tdGrey: Colors.white),
            prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
            border: InputBorder.none,
            hintStyle: TextStyle(color: isDarkmode ? Colors.grey[700]:Colors.white ),
            hintText: 'Search'
        ),
      ),
    );
  }
}
