import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screens/todo.dart';

class AddtodosPage extends StatefulWidget {
  final Todo? todo;

  const AddtodosPage({super.key, this.todo});

  @override
  State<AddtodosPage> createState() => _AddtodosPageState();
}

class _AddtodosPageState extends State<AddtodosPage> {
  bool isLoading = false;

  final dateController = TextEditingController();
  final taskController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      taskController.text = widget.todo!.title;
      dateController.text = widget.todo!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 209, 209),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.task_alt_rounded),
        onPressed: () async {
          if (taskController.text.isEmpty || selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please fill all fields")),
            );
            return;
          }

          setState(() => isLoading = true);

          await Future.delayed(Duration(seconds: 1));

          final todo = Todo(
            title: taskController.text,
            date:
                "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            isDone: widget.todo?.isDone ?? false,
          );

          setState(() => isLoading = false);

          Navigator.pop(context, todo);
        },
      ),

      appBar: AppBar(title: Text('New Task',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),)),

      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/lottie/Radar Detecting.json',
                height: 150,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 200,top: 50),
                      child: Text(
                        'What is to be Done?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                
                    SizedBox(height: 10),
                
                    Card(
                      elevation: 5,
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            //  Task Field
                            TextFormField(
                              controller: taskController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Enter Task',
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                
                            SizedBox(height: 60),
                
                            //  Date Field
                            TextFormField(
                              controller: dateController,
                              readOnly: true,
                              maxLines: 2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Select Date",
                                suffixIcon: Icon(Icons.calendar_today),
                                filled: true,
                              ),
                              onTap: () async {
                                DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                
                                if (pickedDate != null) {
                                  selectedDate = pickedDate;
                                  dateController.text =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                }
                              },
                            ),
                            SizedBox(
                              height: 88,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}