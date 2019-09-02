import 'dart:async';
import 'dart:ui';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satsangreader/PdfLightPage.dart';
import 'package:satsangreader/folder.dart';
import 'package:satsangreader/pdffiles.dart';

final mainReference1 = FirebaseDatabase.instance.reference();
final TextEditingController eCtrl = new TextEditingController();

void main() => runApp(MyApp());
List<Folder> foldername = new List();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satsang Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashS(),
    );
  }
}

class SplashS extends StatefulWidget {
  @override
  _SplashSState createState() => _SplashSState();
}

class _SplashSState extends State<SplashS> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _getData();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 8), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  _getData() {
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
        Folder folder = new Folder(key1, pdfFiles,count);
        foldername.add(folder);
        count=0;
      });
      // printdata();
      // print(foldername[0].getPdf[0].getFileName);
      // print(foldername[0].getPdf[1].getFileName);
      // print(foldername[1].getPdf[0].getFileName);
    });
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
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.indigo[800],
                  Colors.indigo[700],
                  Colors.indigo[600],
                  Colors.indigo[400],
                ],
              ),
            ),
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
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader4,
                      color: Colors.blue,
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _listViewScrollController = new ScrollController();
    String urlPDFPath = "";
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text('Satsang Reader',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                letterSpacing: 1.0,
              )),
        )),
        body: Container(
          child: _buildCard(context)
        )
    );
  }

  Widget _buildCard(BuildContext context) {
    return ListView.builder(
      controller: _listViewScrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: foldername.length,
      itemBuilder: (context, index) {
        return Card(
            child: ExpansionTile(
          title: Text(foldername[index].getFolderName),
          children: <Widget>[
            ListView.builder(
              controller: _listViewScrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: foldername[index].getCount,
              itemBuilder: (context, index1) {
                return ListTile(
                    title: Text(foldername[index].getPdf[index1].getFileName),
                    onTap: ()=>Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (context)=>PdfLightPage(
                        url:(foldername[index].getPdf[index1].getUrl),
                        filename:foldername[index].getPdf[index1].getFileName
                        )
                    )
                    ),
                );
              },
            )
          ],
        ));
      },
    );
  }
}