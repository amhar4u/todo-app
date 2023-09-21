import 'package:flutter/material.dart';
import 'task_database.dart'; // Import your TaskDatabase class

class CategoryPage extends StatelessWidget {
  final TaskDatabase taskDatabase = TaskDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<int?>(
              future: taskDatabase.getCountEducational(),
              builder: (context, snapshot) {
                int? count = snapshot.data;
                return ElevatedButton(
                  onPressed: () {
                    // Handle default button press
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
                  child: Text('Default (${count ?? 0})'),
                );
              },
            ),
            SizedBox(height: 20.0),
            FutureBuilder<int?>(
              future: taskDatabase.getCountPersonal(),
              builder: (context, snapshot) {
                int? count = snapshot.data;
                return ElevatedButton(
                  onPressed: () {
                    // Handle personal button press
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
                  child: Text('Personal (${count ?? 0})'),
                );
              },
            ),
            SizedBox(height: 20.0),
            FutureBuilder<int?>(
              future: taskDatabase.getCountShopping(),
              builder: (context, snapshot) {
                int? count = snapshot.data;
                return ElevatedButton(
                  onPressed: () {
                    // Handle shopping button press
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
                  child: Text('Shopping (${count ?? 0})'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
