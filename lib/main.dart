import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:todo_hive_pt2/model%20database/todo_model.dart';
import 'package:todo_hive_pt2/page/adaptor_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_pt2/page/edit_adaptor_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter();

  Hive.registerAdapter<TodoModel>(TodoModelAdapter());
  // //agar dapat mengakses ke semua kelas
  // await Hive.openBox('myBox');
  await Hive.openBox<TodoModel>('box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: AdaptorPage());
  }
}
