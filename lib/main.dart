import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satsangreader/PdfLightPage.dart';
import 'package:satsangreader/folder.dart';
import 'package:satsangreader/menu_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:satsangreader/pdffiles.dart';
import 'package:satsangreader/splashScreen.dart';
import 'package:satsangreader/zoom_scaffold.dart';

final TextEditingController eCtrl = new TextEditingController();

Future main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satsang Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScrollController _listViewScrollController = new ScrollController();
  MenuController menuController;
  @override
  void initState() {
    super.initState();
    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => menuController,
      child: ZoomScaffold(
        menuScreen: MenuScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
                  color: Color(0xff4d0e0a),
                  child: Container(
                    color: Color(0xff4d0e0a),
                    height: (MediaQuery.of(context).size.height),
                    child:_buildCard(context)
                  ),
                )),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return ListView.builder(
      controller: _listViewScrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      itemCount: foldername.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PdfLightPage(
                              url: (foldername[index].getPdf[index1].getUrl),
                              filename: foldername[index]
                                  .getPdf[index1]
                                  .getFileName))),
                    );
                  },
                )
              ],
            ));
      },
    );
  }
}
