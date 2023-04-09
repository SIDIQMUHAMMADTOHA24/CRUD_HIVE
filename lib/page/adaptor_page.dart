import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_pt2/page/add_adaptor_page.dart';
import 'package:todo_hive_pt2/page/edit_adaptor_page.dart';
import '../model database/todo_model.dart';

class AdaptorPage extends StatefulWidget {
  const AdaptorPage({super.key});

  @override
  State<AdaptorPage> createState() => _AdaptorPageState();
}

class _AdaptorPageState extends State<AdaptorPage> {
  late Box<TodoModel> box;

  @override
  void initState() {
    // TODO: implement initState
    box = Hive.box('box');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AddAdaptorPage();
              },
            ));
            setState(() {});
          },
          label: Text('Tambah')),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: box.length,
        itemBuilder: (context, index) {
          var data = box.getAt(index)!;
          return Dismissible(
            confirmDismiss: (direction) {
              return showModalBottomSheet(
                context: context,
                builder: (context) => SizedBox(
                  height: 60,
                  child: Row(children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('batal')),
                    TextButton(
                        onPressed: () {
                          box.deleteAt(index);
                          Navigator.of(context).pop(true);
                        },
                        child: Text('oke')),
                  ]),
                ),
              );
            },
            direction: DismissDirection.endToStart,
            background: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
            key: ValueKey(data.name),
            child: InkWell(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditAdaptorPage(index: index),
                    settings: RouteSettings(arguments: {
                      'name': data.name,
                      'ammount': data.ammount.toString(),
                      'isExpense': data.isExpense
                    })));
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('nama : ${data.name ?? ''}'),
                      Text('id : ${data.ammount ?? ''}'),
                      Checkbox(
                        value: data.isExpense ?? false,
                        onChanged: (value) {},
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
