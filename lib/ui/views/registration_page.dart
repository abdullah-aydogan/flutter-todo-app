import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/cubit/registration_page_cubit.dart';
import '../colors.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  var tfTodoContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: appBarTextColor,
        title: const Text("To-Do Ekle"),
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
                      context.read<RegistrationPageCubit>().save(tfTodoContent.text, 0);
                      Navigator.popUntil(context, (route) => route.isFirst);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("To-Do kayıt edildi."),
                          )
                      );
                    }
                  },
                  label: const Text("KAYDET"),
                  icon: const Icon(Icons.save),
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