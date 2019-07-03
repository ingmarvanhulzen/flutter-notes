import 'package:uuid/uuid.dart';

var uuidGenerator = new Uuid();

class NoteModel {
  String uuid;
  String content;
  DateTime modified;

  NoteModel({this.content = ''}) {
    this.uuid = uuidGenerator.v4();
    this.modified = DateTime.now();
  }

  void update(String content) {
    this.content = content;
    this.modified = DateTime.now();
  }

  NoteModel.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        content = json['content'],
        modified = DateTime.parse(json['modified']);

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'content': content,
        'modified': modified.toIso8601String(),
      };
}
