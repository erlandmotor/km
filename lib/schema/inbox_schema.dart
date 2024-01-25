import 'package:hive/hive.dart';

part 'inbox_schema.g.dart';

@HiveType(typeId: 1)
class InboxSchema {

  InboxSchema({ required this.title, required this.content, required this.status,
  required this.date });

  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  int status;

  @HiveField(3)
  DateTime date;
}