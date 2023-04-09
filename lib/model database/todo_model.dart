// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

//file yout name.g.dart
part 'todo_model.g.dart';

//paste perintah ini di terminal : flutter packages pub run build_runner build

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final bool? isExpense;
  @HiveField(2)
  final int? ammount;
  TodoModel({this.name, this.ammount, this.isExpense});
}
