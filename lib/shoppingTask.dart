import 'package:flutter/material.dart';
import 'package:todo_app/task_database.dart';
import 'TaskClass.dart';

class ShoppingTask extends StatefulWidget {
  final Function() reloadTasks;
  final Function() reloadCategoryPage;
  ShoppingTask({required this.reloadTasks, required this.reloadCategoryPage, required void Function() reloadCategoryCounts});

  @override
  _ShoppingTaskState createState() => _ShoppingTaskState();
}

class _ShoppingTaskState extends State<ShoppingTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Shopping Task',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            widget.reloadCategoryPage(); // Reload the CategoryPage
            Navigator.of(context).pop(); // Navigate back to the previous screen (CategoryPage)
          },
        ),
      ),
      body:Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder<List<Task>>(
                  future: TaskDatabase.instance.getTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No tasks available.'));
                    } else {
                      final tasks = snapshot.data!.where((task) => task.category == 'Shopping').toList();
                      // Filter tasks to include only those with status "pending"

                      if (tasks.isEmpty) {
                        return Center(child: Text('No Shopping tasks available.'));
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
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: task.status == 'completed'
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 30.0,
                                    ),
                                ],
                              ),

                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _reloadShoppingTaskPage() {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingTask(reloadTasks: _reloadShoppingTaskPage, reloadCategoryPage: () {  }, reloadCategoryCounts: () {  },),
      ),
    );
  }

}
