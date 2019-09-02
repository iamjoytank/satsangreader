import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

final mainReference1 = FirebaseDatabase.instance.reference();

class PdfNightPage extends StatefulWidget {
  final String path;
  final String filename;
  const PdfNightPage({Key key,this.path,this.filename}) : super(key: key);
  @override
  _PdfNightPageState createState() => _PdfNightPageState();
}

class _PdfNightPageState extends State<PdfNightPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.filename}"),
      ),
      body: Center(
        ));
  }
}