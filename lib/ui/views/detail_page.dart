import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/todos.dart';
import 'package:todo_app/ui/cubit/detail_page_cubit.dart';
import 'package:todo_app/ui/cubit/home_page_cubit.dart';
import '../colors.dart';

class DetailPage extends StatefulWidget {

  ToDos todo;

  DetailPage({required this.todo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var tfTodoContent = TextEditingController();

  @override
  void initState() {

    super.initState();

    var todo = widget.todo;
    tfTodoContent.text = todo.todo_content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: appBarTextColor,
        title: const Text("To-Do Düzenle"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: tfTodoContent,
                decoration: const InputDecoration(
                  labelText: "To-Do İçerik",
                  hintText: "İçeriği buraya yazınız...",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if(tfTodoContent.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Herhangi bir şey yazmadınız."))
                      );
                    }

                    else {
                      context.read<DetailPageCubit>().update(widget.todo.todo_id, tfTodoContent.text, widget.todo.todo_status);
                      context.read<HomePageCubit>().listTodos();
                      Navigator.popUntil(context, (route) => route.isFirst);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("To-Do güncellendi."),
                          )
                      );
                    }
                  },
                  label: const Text("GÜNCELLE"),
                  icon: const Icon(Icons.update),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.black,
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