import 'package:flutter/material.dart';
import 'package:todo_app/educationalTask.dart';
import 'package:todo_app/personalTask.dart';
import 'package:todo_app/shoppingTask.dart';
import 'package:todo_app/task_database.dart';

import 'Add_todo.dart';

class CategoryPage extends StatefulWidget {
  final Function() reloadTasks;

  CategoryPage({Key? key, required this.reloadTasks}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TaskDatabase taskDatabase = TaskDatabase.instance;
  int educationalCount = 0;
  int personalCount = 0;
  int shoppingCount = 0;

  @override
  void initState() {
    super.initState();
    _updateCounts();
  }

  Future<void> _updateCounts() async {
    final educational = await taskDatabase.getCountEducational();
    final personal = await taskDatabase.getCountPersonal();
    final shopping = await taskDatabase.getCountShopping();

    setState(() {
      educationalCount = educational ?? 0;
      personalCount = personal ?? 0;
      shoppingCount = shopping ?? 0;
    });
  }

  // Callback function to reload category counts
  void reloadCategoryCounts() {
    _updateCounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Navigate to the EducationalTask screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EducationalTask(
                      reloadTasks: widget.reloadTasks,
                      reloadCategoryPage: () {
                        _updateCounts();
                      },
                      reloadCategoryCounts: reloadCategoryCounts, // Pass the callback
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0),
                padding: EdgeInsets.all(10.0),
                primary: Colors.red[100],
                onPrimary: Colors.black,
                textStyle: TextStyle(fontSize: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
              ),
              child: Text('Educational ($educationalCount)'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalTask(
                      reloadTasks: widget.reloadTasks,
                      reloadCategoryPage: () {
                        _updateCounts();
                      },
                      reloadCategoryCounts: reloadCategoryCounts, // Pass the callback
                    ),
                  ),
                );

                if (newTask != null) {
                  // Reload tasks in the CategoryPage
                  widget.reloadTasks();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0),
                padding: EdgeInsets.all(10.0),
                primary: Colors.red[100],
                onPrimary: Colors.black,
                textStyle: TextStyle(fontSize: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
              ),
              child: Text('Personal ($personalCount)'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingTask(
                      reloadTasks: () {},
                      reloadCategoryPage: () {},
                      reloadCategoryCounts: reloadCategoryCounts, // Pass the callback
                    ),
                  ),
                );

                if (newTask != null) {
                  // Reload tasks in the CategoryPage
                  widget.reloadTasks();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0),
                padding: EdgeInsets.all(10.0),
                primary: Colors.red[100],
                onPrimary: Colors.black,
                textStyle: TextStyle(fontSize: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
              ),
              child: Text('Shopping ($shoppingCount)'),
            ),
          ],
        ),
      ),
    );
  }
}
