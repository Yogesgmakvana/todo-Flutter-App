import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/screens/addTodos_page.dart';
import 'package:todo_app/screens/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController controller=Get.put(ThemeController());
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App"),backgroundColor: Colors.blueGrey,),
       endDrawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(currentAccountPicture: CircleAvatar(child: Image.asset('assets/person.png'),),accountName:Text('Yogesh Makvana'), accountEmail: Text('makwanay324@gmail.com')),
            ListTile(
              leading: Text('Chnage theme',style: TextStyle(
                fontSize: 19,),),
                title: Obx(() => Switch(
                value: controller.isDark.value,
                onChanged: (value) {
                  controller.toggleTheme();
                },
              ))
,
            ),
          ],
        ),
       ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddtodosPage(),
            ),
          );

          if (result != null) {
            setState(() {
              todos.add(result);
            });
            saveTodos();
          }
        },
      ),

      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: todo.isDone? const Color.fromARGB(255, 174, 121, 101):Colors.white,
              elevation: 5,
              child: ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: Text(todo.date),
              
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    setState(() {
                      todo.isDone = value!;
                    });
                    saveTodos();
                  },
                ),
              
              
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit,color: Colors.white,),
                          onPressed: () async {
                            final updatedTodo = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddtodosPage(todo: todo),
                              ),
                            );
                                      
                            if (updatedTodo != null) {
                              setState(() {
                                todos[index] = updatedTodo;
                              });
                              saveTodos();
                            }
                          },
                        ),
                      ),
                    ),
              
                    // Delete
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.delete,color: Colors.white,),
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                              saveTodos();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList('todos');

    if (data != null) {
      setState(() {
        todos = data.map((e) => Todo.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> todoList =
        todos.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList('todos', todoList);
  }
}