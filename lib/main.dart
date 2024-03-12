import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screen/todo_screen.dart';
import 'package:todo_app/view_model/view_class.dart';

import 'firebase_options.dart';
import 'model/model_class.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: TodoScreen(),
      ),
    );
  }
}


