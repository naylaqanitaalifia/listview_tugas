import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF344EA3),
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Menggunakan List<Map<String, dynamic>> untuk menyimpan task
  List<Map<String, dynamic>> tasks = [];
  TextEditingController _taskController = TextEditingController();

  // Fungsi untuk menambahkan task
  void _addTask(String task) {
    setState(() {
      tasks.add({'task': task, 'isChecked': false});
    });
  }

  // Fungsi untuk mengedit task
  void _editTask(int index, String newTask) {
    setState(() {
      tasks[index]['task'] = newTask;
    });
  }

  // Fungsi untuk menghapus task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Fungsi untuk mengganti status ceklis task
  void _toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['isChecked'] = !tasks[index]['isChecked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF041a56),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF041a56),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: tasks[index]['isChecked'],
                    onChanged: (bool? value) {
                      _toggleTaskStatus(index);
                    },
                    activeColor: Colors.blueAccent,
                  ),
                  title: Text(
                    tasks[index]['task'],
                    style: TextStyle(
                      color: tasks[index]['isChecked'] ? Colors.grey : Colors.white,
                      decoration: tasks[index]['isChecked']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _deleteTask(index),
                  ),
                  onTap: () {
                    _taskController.text = tasks[index]['task'];
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit Task'),
                          content: TextField(
                            controller: _taskController,
                            decoration: InputDecoration(hintText: 'Enter new task'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _editTask(index, _taskController.text);
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(hintText: 'Enter task'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_taskController.text.isNotEmpty) {
                        _addTask(_taskController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF041a56),
        foregroundColor: Color(0xFF8aa6ef),
      ),
    );
  }
}
