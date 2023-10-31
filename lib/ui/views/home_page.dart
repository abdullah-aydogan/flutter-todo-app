import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/todos.dart';
import 'package:todo_app/ui/colors.dart';
import 'package:todo_app/ui/cubit/home_page_cubit.dart';
import 'package:todo_app/ui/views/registration_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool searchStatus = false;

  @override
  void initState() {

    super.initState();
    context.read<HomePageCubit>().listTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: appBarTextColor,
        title: searchStatus ?
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "To-Do ara...",
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: appBarTextColor),
              onChanged: (searchResult) {
                context.read<HomePageCubit>().search(searchResult);
              },
            ),
          ) : const Text("To-Do Uygulaması"),
        actions: [
          searchStatus ?
            IconButton(
              onPressed: () {
                setState(() {
                  searchStatus = false;
                });
                context.read<HomePageCubit>().listTodos();
              },
              icon: const Icon(Icons.clear),
            ) :
            IconButton(
              onPressed: () {
                setState(() {
                  searchStatus = true;
                });
              },
              icon: const Icon(Icons.search),
            ),
        ],
      ),
      body: BlocBuilder<HomePageCubit, List<ToDos>>(
        builder: (context, todoList) {
          if(todoList.isNotEmpty) {
            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                var todo = todoList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(todo: todo)));
                    context.read<HomePageCubit>().listTodos();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            todo.todo_status == 1 ?
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    todo.todo_status = 0;
                                    context.read<HomePageCubit>().saveTodoStatus(todo.todo_id, todo.todo_status);
                                  });
                                },
                                icon: const Icon(Icons.check_circle, color: Colors.green,),

                              ) :
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    todo.todo_status = 1;
                                    context.read<HomePageCubit>().saveTodoStatus(todo.todo_id, todo.todo_status);
                                  });
                                },
                                icon: const Icon(Icons.circle_outlined, color: Colors.black54,),
                              ),
                            SizedBox(
                              width: 200,
                              child: Text(todo.todo_content,
                                style: TextStyle(
                                  decoration: todo.todo_status == 1 ? TextDecoration.lineThrough : TextDecoration.none
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("To-Do silinsin mi?"),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: () {
                                          context.read<HomePageCubit>().delete(todo.todo_id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("To-Do silindi."),
                                            )
                                          );
                                        },
                                      ),
                                    )
                                );
                              },
                              icon: const Icon(Icons.clear, color: Colors.black54,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage())).then((value) {
            context.read<HomePageCubit>().listTodos();
          });
        },
        backgroundColor: secondaryColor,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}