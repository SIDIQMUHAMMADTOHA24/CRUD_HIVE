import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_pt2/model%20database/todo_model.dart';

class EditAdaptorPage extends StatefulWidget {
  EditAdaptorPage({super.key, required this.index});
  final int index;

  @override
  State<EditAdaptorPage> createState() => _EditAdaptorPageState();
}

class _EditAdaptorPageState extends State<EditAdaptorPage> {
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

  Box<TodoModel>? box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('box');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    if (args['name'].isNotEmpty) {
      nameTxt.text = args['name'];
    }
    if (args['ammount'].isNotEmpty) {
      ammountTxt.text = args['ammount'];
    }

    return Scaffold(
      body: Column(children: [
        TextField(
          controller: nameTxt,
          decoration: InputDecoration(
              hintText: 'name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: ammountTxt,
          decoration: InputDecoration(
              hintText: 'ammount',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
              box!.putAt(
                  widget.index,
                  TodoModel(
                      name: nameTxt.text,
                      ammount: int.parse(ammountTxt.text),
                      isExpense: isBoll ? true : false));
              Navigator.pop(context);
            },
            child: Text('change'))
      ]),
    );
  }
}
