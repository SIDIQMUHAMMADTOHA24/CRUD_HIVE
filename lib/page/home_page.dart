import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import '../model database/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Box box;

  @override
  void initState() {
    openTheBox();
    super.initState();
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }

  Map<String, dynamic> map = {'5': 'rani', '6': 'tio'};

  openTheBox() {
    // karena await Hive.openBox('myBox); sudah diakses di main , jadi sekarang tinggal membuat Hive.box(myBox) , tapi sebelumnya harus membuat variabel Box di atas
    box = Hive.box('myBox');

    //ketika pud/ add dihapus , walaupun kita panggil dia akan tetap ada , kerena sudah tersimpan di local storage

  
    box.put('1', 'udin');
    box.put('2', 'bardi');
    box.put('3', 'sinden');
    box.put('4', 'dita');
    box.putAll(map);
    box.add('joko');
    box.add('tasya');
    box.add('kintil');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Todo'),
        ),
        body: Column(
          children: [
            Text(box.get(1)), //udin
            // Text(box.get(0)),//joko
            // Text(box.get(1)),//tasya
            // Text(box.get(2)),//kintil
            // Text(box.get('5')),//rani
            // Text(box.get('6')),//tio
            // Text(box.getAt(0)),//joko
            // Text(box.getAt(3)),//tasya
            // Text(box.getAt(2)),//kintil
          ],
        ),
      ),
    );
  }
}
