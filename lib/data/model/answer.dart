import 'dart:convert';

final class Answer {
  String reading;

  Answer({required this.reading});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reading': reading,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      reading: map['reading'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}
