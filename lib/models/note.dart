class Note {
  String noteTitle;
  String noteText;
  static int noteId = -1;

  Note(String titel, String text) {
    noteTitle = titel;
    noteText = text;
    noteId += 1;
  }

  int get getid {
    return noteId;
  }
}
