import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/colors.dart';
import 'package:todo_app/ui/cubit/detail_page_cubit.dart';
import 'package:todo_app/ui/cubit/home_page_cubit.dart';
import 'package:todo_app/ui/cubit/registration_page_cubit.dart';
import 'package:todo_app/ui/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => DetailPageCubit()),
        BlocProvider(create: (context) => RegistrationPageCubit()),
      ],
      child: MaterialApp(
        title: 'To-Do',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}