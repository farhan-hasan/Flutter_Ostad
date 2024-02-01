import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/add_new_todo_screen.dart';
import 'edit_todo_screen.dart';
import 'todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Visibility(
        visible: todoList.isNotEmpty,
        replacement: Center(
          child: Text("Todo List Empty"),
        ),
        child: ListView.separated(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return _buildTodoListTile(index);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.blue.shade200,
              height: 12,
              indent: 16,
              endIndent: 16,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTodoFAB,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListTile _buildTodoListTile(int index) {
    return ListTile(
            title:  Text(todoList[index].title),
            subtitle:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(todoList[index].description), Text(todoList[index].dateTime.toString())],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      showDeleteConfirmationDialog(index);
                    },
                    icon: Icon(Icons.delete_forever_outlined)),
                IconButton(
                    onPressed: () => _onTapEditTodo(index),
                    icon: Icon(Icons.edit))
              ],
            ),
          );
  }

  Future<void> _onTapEditTodo (int index)  async {
    final Todo? updatedTodo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditTodoScreen(
              todo: todoList[index],
            )));
    if(updatedTodo!=null) {
      todoList[index] = updatedTodo;
      setState(() {

      });
    }
  }

  Future<void> _onTapAddNewTodoFAB() async {
    // Asynchronous Programming
    // Future
    // Await
    // Async
    final Todo? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddNewTodoScreen()));
    if (result != null) {
      todoList.add(result);
      setState(() {

      });
    }
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Todo"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    _removeTodo(index);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );
        });
  }

  void _removeTodo (int index) {
    todoList.removeAt(index);
    setState(() {});
  }

}