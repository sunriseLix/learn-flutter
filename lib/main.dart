import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(new MaterialApp(
    title: 'Passing Data',
    home: new TodoScreen(
      todos: new List.generate(
        20,
        (i) => new Todo(
              'Todo $i',
              'A description of what needs to be done for Todo $i',
            ),
      ),
    ),
  ));
}

class TodoScreen extends StatelessWidget {
  final List<Todo> todos;
  TodoScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Todos'),
        ),
        body: new ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final Todo todo = todos[index];
            return new Dismissible(
                key: new Key(todo.title),
                onDismissed: (direction) {
                  todos.removeAt(index);
                  Scaffold.of(context).showSnackBar(
                      new SnackBar(content: new Text('${todo.title} dismissed')));
                },
                background: new Container(color: Colors.red),
                child: new ListTile(
                  title: new Text("${todo.title}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) =>
                            new DetailScreen(todo: todo),
                      ),
                    );
                  },
                ));
          },
        ));
  }
}

class DetailScreen extends StatelessWidget {
  final Todo todo;

  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("${todo.title}"),
        ),
        body: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Text("${todo.description}")));
  }
}
