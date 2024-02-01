import 'package:flutter/material.dart';
import 'todo.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({super.key, required this.todo});

  final Todo todo;

  @override
  State<EditTodoScreen> createState() => _AddNewTodoScreenState();
}

class _AddNewTodoScreenState extends State<EditTodoScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTEC.text = widget.todo.title;
    _descriptionTEC.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEC,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  final v = value ?? '';
                  if (v.trim().isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionTEC,
                maxLines: 5,
                maxLength: 100,
                decoration: const InputDecoration(hintText: 'Description'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Todo todo = Todo(_titleTEC.text.trim(), _descriptionTEC.text.trim(), DateTime.now());
                        Navigator.pop(context, todo);
                      }
                    },
                    child: Text("Edit")),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEC.dispose();
    _descriptionTEC.dispose();
    super.dispose();
  }

}
