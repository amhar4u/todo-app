import 'package:flutter/material.dart';
import 'package:todo_app/task_database.dart';
import 'TaskClass.dart';

class NewTask extends StatefulWidget {
  final Function() reloadCategoryPage;
  final Function() reloadCategoryCounts; // Define the callback

  NewTask({Key? key, required this.reloadCategoryPage, required this.reloadCategoryCounts}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String? selectedDropdownValue = 'Personal';
  List<String> dropdownItems = ['Personal', 'Educational', 'Shopping'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.redAccent,
            hintColor: Colors.redAccent,
            colorScheme: ColorScheme.light(primary: Colors.redAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.red[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(36.0),
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          constraints: BoxConstraints.expand(height: 550),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always, // Enable auto validation
            child: Column(
              children: [
                TextFormField(
                  controller: taskTitleController,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Task title is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownValue = newValue;
                    });
                  },
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select a category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Category is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.redAccent,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Date is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent, // Always red border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Description is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with task creation
                      final newTask = Task(
                        id: null,
                        taskTitle: taskTitleController.text,
                        category: selectedDropdownValue ?? '',
                        date: dateController.text,
                        description: descriptionController.text,
                        status: 'pending',
                      );

                      final insertedId = await TaskDatabase.instance.insertTask(newTask);

                      newTask.id = insertedId;
                      taskTitleController.clear();
                      dateController.clear();
                      descriptionController.clear();

                      Navigator.pop(context, newTask);

                      // Call the callback function to reload the CategoryPage
                      widget.reloadCategoryPage();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
