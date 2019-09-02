import 'package:firebase_database/firebase_database.dart';

class PdfFiles{
  String filename;
  String url;

  PdfFiles(this.filename,this.url);

  String get getFileName => filename;
  String get getUrl => url;

  PdfFiles.fromsnapshot(DataSnapshot snapshot){
    // key = snapshot.key;
    filename = snapshot.value["name"];
    url = snapshot.value["url"];
  }
}