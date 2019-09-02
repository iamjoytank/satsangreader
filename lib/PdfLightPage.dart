import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

final mainReference1 = FirebaseDatabase.instance.reference();

class PdfLightPage extends StatefulWidget {
  final String url;
  final String filename;

  PdfLightPage({Key key, this.url, this.filename}) : super(key: key);
  @override
  _PdfLightPageState createState() => _PdfLightPageState();
}

class _PdfLightPageState extends State<PdfLightPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;
  String urlPDFPath = "";

  @override
  void initState() {
    super.initState();
    print("filename--" + widget.filename);
    print("url---" + widget.url);

    getFileFromUrl(widget.url).then((f) {
      setState(() {
        urlPDFPath = f.path;
        print("urlPath---" + urlPDFPath);
      });
    });
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.filename}"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: this.urlPDFPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: false,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            pageFling: (true),
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
    );
  }
}
