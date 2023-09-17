import 'package:flutter/material.dart';
import 'package:todo_app/Add_todo.dart';



void main()  {
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
  bool isSearching = false;
  int _currrentIndex = 0;

  // Define the pages for each tab
  final List<Widget> _pages = [
    // Replace these with your pages
    Center(
      child: Text('Home Page'),
    ),
    Center(
      child: Text('Favorites Page'),
    ),
    Center(
      child: Text('Profile Page'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? Container(
            width: 300.0,
            margin: EdgeInsets.only(left: 25.0),
            child: Row(children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              )
            ]))
            : Text(
          'ToDo App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
        actions: [
          isSearching
              ? Container(
              margin: EdgeInsets.only(right: 25.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                  });
                },
              ))
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          ),
        ],
      ),
      body: _pages[_currrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currrentIndex,
        onTap: (index) {
          setState(() {
            _currrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
              color: _currrentIndex == 0 ? Colors.black : Colors.white,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
              color: _currrentIndex == 1 ? Colors.black : Colors.white,),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
              color: _currrentIndex == 2 ? Colors.black : Colors.white,),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currrentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>NewTask())
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      )
          : null,
    );
  }
}
