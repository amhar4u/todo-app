import 'package:flutter/material.dart';
import 'package:todo_app/task_database.dart';
import 'TaskClass.dart';

class TaskList extends StatefulWidget {
  final Function() reloadTasks; // Add a callback function

  TaskList({required this.reloadTasks});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: TaskDatabase.instance.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No tasks available.'));
        } else {
          final tasks = snapshot.data!.where((task) => task.status == 'pending').toList();
          // Filter tasks to include only those with status "pending"

          if (tasks.isEmpty) {
            return Center(child: Text('Tasks Are Completed'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.taskTitle,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(task.date),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.check_circle_outline,
                          color: task.status == 'completed'
                              ? Colors.green
                              : Colors.grey,
                          size: 30.0,
                        ),
                        onPressed: () {
                          TaskDatabase.instance.completeTask(task.id!);
                          widget.reloadTasks();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          await TaskDatabase.instance.deleteTask(task.id!);
                          widget.reloadTasks();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

}
