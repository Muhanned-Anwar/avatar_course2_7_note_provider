import 'package:avatar_course2_7_note_provider/core/storage/local/database/controller/note_database_controller.dart';
import 'package:avatar_course2_7_note_provider/core/widgets/helpers.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/storage/local/database/model/note.dart';

class HomeController extends ChangeNotifier with Helpers {
  List<Note> notes = [];
  final NoteDatabaseController _noteDatabaseController =
      NoteDatabaseController();

  Note currentNote = Note.fillData(id: 0, title: '', content: '');

  Future<void> read() async {
    notes = await _noteDatabaseController.read();
    notes = notes.reversed.toList();
    notifyListeners();
  }

  Future<void> show(int noteId) async {
    currentNote = await _noteDatabaseController.show(noteId) ?? Note();
    notifyListeners();
  }

  Future<bool> create({required Note note}) async {
    int id = await _noteDatabaseController.create(note);
    if (id != 0) {
      note.id = id;
      notes.add(note);
      notifyListeners();
    }

    return id != 0;
  }

  Future<bool> updateNote({required Note updatedNote}) async {
    bool updated = await _noteDatabaseController.update(updatedNote);
    if (updated) {
      for (int i = 0; i < notes.length; i++) {
        if (notes[i].id == updatedNote.id) {
          notifyListeners();

          notes[i] = updatedNote;
          return true;
        }
      }
    }

    return false;
  }

  Future<void> delete(int id, BuildContext context) async {
    if (await _noteDatabaseController.delete(id)) {
      // for (int i = 0; i < notes.length; i++) {
      //   if (notes[i].id == id) {
      //     notes.removeAt(i);
      //         notifyListeners();

      //     showSnackBar(context: context, message: 'Deleted Note Successfully');
      //   }
      // }
      read();
      showSnackBar(context: context, message: 'Deleted Note Successfully');
    } else {
      showSnackBar(
          context: context, message: 'Deleted Note Field', error: true);
    }
  }
}
