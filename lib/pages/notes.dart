import 'package:flutter/cupertino.dart';
import 'package:demo/pages/note.dart';
import 'package:provider/provider.dart';
import 'package:demo/data/schedule.dart';
import 'package:demo/data/models.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatelessWidget {
  Widget itemBuilder(BuildContext context, int index) {
    final _schedule = Provider.of<NotesSchedule>(context);
    final _note = _schedule.notes[index];

    return Dismissible(
      key: Key(_note.uuid),
      onDismissed: (direction) {
        _schedule.delete(_note.uuid);
      },
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                DateFormat("EEEE dd MMMM yyyy 'om' HH:mm", 'nl_NL')
                    .format(_note.modified),
                style: TextStyle(
                  color: CupertinoColors.lightBackgroundGray,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => NotePage(note: _note),
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<NotesSchedule>(context);

    return CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        bottom: true,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.create),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          NotePage(note: NoteModel()),
                    ),
                  );
                },
              ),
              largeTitle: Text('Notes'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: _schedule.notes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
