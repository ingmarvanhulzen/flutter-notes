import 'package:flutter/cupertino.dart';
import 'package:demo/data/models.dart';
import 'package:demo/data/schedule.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final NoteModel note;

  NotePage({this.note}) {
    _controller.text = note.content;
  }

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<NotesSchedule>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Notes'),
      ),
      child: SafeArea(
        child: CupertinoTextField(
          onChanged: (String content) {
            if (_schedule.exists(note.uuid)) {
              _schedule.update(note.uuid, content);
            } else {
              note.content = content;
              _schedule.add(note);
            }
          },
          controller: _controller,
          placeholder: 'Plaats hier je notitie.',
          padding: EdgeInsets.all(16),
          scrollPhysics: ClampingScrollPhysics(),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0,
              color: CupertinoColors.white,
            ),
          ),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
    );
  }
}
