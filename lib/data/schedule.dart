import 'package:flutter/foundation.dart';
import 'package:demo/data/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotesSchedule with ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  NotesSchedule() : super() {
    getFromPreferences();
  }

  void add(NoteModel note) {
    _notes.add(note);
    notifyListeners();
    saveToPreferences(_notes);
  }

  bool exists(String uuid) {
    return _notes.indexWhere((o) => o.uuid == uuid) != -1;
  }

  void update(String uuid, String content) {
    _notes.firstWhere((o) => o.uuid == uuid).update(content);
    notifyListeners();
    saveToPreferences(_notes);
  }

  void delete(String uuid) {
    _notes.removeWhere((o) => o.uuid == uuid);
    notifyListeners();
    saveToPreferences(_notes);
  }

  saveToPreferences(List<NoteModel> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(notes);

    prefs.setString('notes', json);
  }

  getFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = prefs.getString('notes') ?? '';

    if (json != '') {
      final List list = jsonDecode(json);
      final notes =
          List<NoteModel>.from(list.map((map) => NoteModel.fromJson(map)));
      _notes = notes;
    }

    _loading = false;
    notifyListeners();
  }
}
