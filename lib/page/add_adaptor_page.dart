import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_pt2/model%20database/todo_model.dart';

class AddAdaptorPage extends StatefulWidget {
  AddAdaptorPage({super.key});

  @override
  State<AddAdaptorPage> createState() => _AddAdaptorPageState();
}

class _AddAdaptorPageState extends State<AddAdaptorPage> {
  Box<TodoModel>? box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('box');
  }

  TextEditingController nameTxt = TextEditingController();
  TextEditingController ammountTxt = TextEditingController();
  bool isBoll = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTxt.dispose();
    ammountTxt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: nameTxt,
              decoration: InputDecoration(
                  hintText: 'nama',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: ammountTxt,
              decoration: InputDecoration(
                  hintText: 'ammount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Checkbox(
              value: isBoll,
              onChanged: (value) {
                isBoll = !isBoll;
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (nameTxt.text.isEmpty || ammountTxt.text.isEmpty) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: 70,
                              child: Center(child: Text('Belum mengisi apapun')));
                        });
                    return;
                  }
                  box!.add(TodoModel(
                      name: nameTxt.text,
                      ammount: int.parse(ammountTxt.text),
                      isExpense: isBoll ? true : false));
                  Navigator.pop(context);
                },
                child: Text('Enter'))
          ]),
        ),
      ),
    );
  }
}
