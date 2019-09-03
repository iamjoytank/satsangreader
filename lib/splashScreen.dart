import 'dart:async';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:satsangreader/folder.dart';
import 'package:satsangreader/loginPage.dart';
import 'package:satsangreader/main.dart';
import 'package:satsangreader/pdffiles.dart';

final mainReference1 = FirebaseDatabase.instance.reference();
List<Folder> foldername = new List();

class SplashScreen extends StatefulWidget {
  @override
  _SplashSState createState() => _SplashSState();
}

class _SplashSState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getData();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds:8), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
  getData(){
    try{
    int count = 0;
    mainReference1
        .child("Satsang Reader PDF/")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key1, values1) {
        List<PdfFiles> pdfFiles = new List();
        values1.forEach((key2, values2) {
          PdfFiles pdf = new PdfFiles(values2["name"], values2["url"]);
          pdfFiles.add(pdf);
          // print(pdf.getFileName);
          count++;
        });
        // print(count);
        Folder folder = new Folder(key1, pdfFiles, count);
        foldername.add(folder);
        count = 0;
      });
    });
    }catch (e) {
      throw Exception("Error opening url file");
    }
  }

  
  // printdata(){
  //   print(foldername.length);
  //   for (int i = 0; i < foldername.length; i++) {
  //     // print("folder1 --" + foldername[i].getFolderName);
  //     var obj = foldername[i];
  //     print(foldername[i].getPdf);
  //     for(var k in obj.getPdf)
  //     {
  //       print("pdfFile --" + k.getFileName);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //   // Box decoration takes a gradient
            //   gradient: LinearGradient(
            //     // Where the linear gradient begins and ends
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     // Add one stop for each color. Stops should increase from 0 to 1
            //     stops: [0.1, 0.5, 0.7, 0.9],
            //     colors: [
            //       // Colors are easy thanks to Flutter's Colors class.
            //       Color(0xff4d0e0a),
            //     ],
            //   ),
            // ),
            color: Color(0xff4d0e0a),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.library_books,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                      Text(
                        'Satsang Reader',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader2,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
