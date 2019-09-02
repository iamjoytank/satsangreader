import 'package:satsangreader/pdffiles.dart';

class Folder{
  var foldername;
  int count;
  List<PdfFiles> pdf;
  Folder(this.foldername,this.pdf,this.count);

  String get getFolderName => foldername;
  int get getCount => count;
  List<PdfFiles> get getPdf => pdf;   
}
