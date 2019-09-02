import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.6,
              heightFactor: 0.6,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/aksharderi.png',width: 80,height:80,),
                        )),
                    CustomInputField(
                        Icon(Icons.person, color: Colors.white), 'Username'),
                    CustomInputField(
                        Icon(Icons.lock, color: Colors.white), 'Password'),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: (){},color: Colors.deepOrange,textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Text('Login',style: TextStyle(
                            fontSize: 20.0
                        ),),),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CustomInputField extends StatelessWidget{

  Icon fieldIcon;
  String hintText;

  CustomInputField(this.fieldIcon,this.hintText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 250,
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: fieldIcon,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                ),
                width: 200,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        fillColor: Colors.white,
                        filled: true
                    ),
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

}