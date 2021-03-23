import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

///运行以下命令生成
///flutter packages pub run build_runner build
@JsonSerializable()
class Person {
  final String name;
  final int age;
  final bool? isOld;

  Person({required this.name, required this.age, this.isOld});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
