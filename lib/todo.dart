class Todo{
  String? id;
  String? task;
  bool? isDone;

  Todo({
    required this.id,
    required this.task,
    this.isDone= false
  });

  static List<Todo> todoList(){
    return[
      Todo(id: '1', task: 'Check Mail', isDone: true),
      Todo(id: '2', task: 'Read Books', isDone: true),
      Todo(id: '3', task: 'Go For Exercise', ),
      Todo(id: '4', task: 'Have Dinner', ),
      Todo(id: '5', task: 'Sleep', isDone: true),
    ];
  }
}