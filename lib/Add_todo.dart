import 'package:flutter/material.dart';


class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController dateController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String? selectedDropdownValue = 'Personal'; // Initially selected option
  List<String> dropdownItems = [
    'Personal',
    'Educational',
    'Shopping'
  ]; // Dropdown items

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      // Adjust as needed
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.redAccent,
            // Change calendar color to redAccent
            hintColor: Colors.redAccent,
            // Change calendar color to redAccent
            colorScheme: ColorScheme.light(primary: Colors.redAccent),
            // Change calendar color to redAccent
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        "${selectedDate.toLocal()}".split(' ')[0]; // Update text field
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  }

  @override
  void dispose() {
    dateController.dispose();
    taskTitleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // // Function to submit data to Firestore
  // Future<void> _submitDataToFirestore() async {
  //   // Access the entered data
  //   String taskTitle = taskTitleController.text;
  //   String selectedDateString = dateController.text;
  //   String description = descriptionController.text;
  //   String category = selectedDropdownValue ?? ''; // Get selected category
  //
  //   // Create a Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   try {
  //     // Add the data to Firestore
  //     await firestore.collection('tasks').add({
  //       'title': taskTitle,
  //       'date': selectedDateString,
  //       'description': description,
  //       'category': category,
  //     });
  //
  //     // Optionally, you can show a success message or navigate to a different screen.
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Data submitted to Firestore successfully.'),
  //       ),
  //     );
  //   } catch (error) {
  //     // Handle errors here, e.g., display an error message
  //     print('Error submitting data: $error');
  //   }
  // }

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
            child: Column(
              children: [
                TextFormField(
                  controller: taskTitleController,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
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
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
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
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
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
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: (){},
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

void main() {
  runApp(MaterialApp(
    home: NewTask(),
  ));
}
