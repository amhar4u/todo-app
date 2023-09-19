import 'package:flutter/material.dart';
import 'package:todo_app/Add_todo.dart';
import 'package:todo_app/TaskList.dart';
import 'package:todo_app/task_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the TaskDatabase
  final database = TaskDatabase.instance;
  await database.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(16.0), // Adjust the margin as needed
        child: _currentIndex == 0
            ? TaskList(reloadTasks: reloadTasks)
            : _currentIndex == 1
            ? Center(
          child: Text('Category Page'),
        )
            : Center(
          child: Text('Details Page'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.black : Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
              color: _currentIndex == 1 ? Colors.black : Colors.white,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.details,
              color: _currentIndex == 2 ? Colors.black : Colors.white,
            ),
            label: 'Details',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTask(),
            ),
          ).then((_) {
            // When the NewTask screen is dismissed, reload tasks
            reloadTasks();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }


  void reloadTasks() {
    setState(() {}); // Trigger a rebuild of the widget
  }
}
