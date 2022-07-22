import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterbookminimysql/network/api.dart';
import 'package:flutterbookminimysql/signin.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController varsity = TextEditingController();
  TextEditingController mobile = TextEditingController();
  

  Future register() async{
   // var url = "http://192.168.43.199/books/registraion.php";
    var response = await http.post(BASEURL.registraion,body:{
      "name": name.text,
      "password" : password.text,
      "email" : email.text,
      "varsity" : varsity.text,
      "mobile" : mobile.text

      
    });

  
    var data = json.decode(response.body);
    if(data=="Login Matched"){
      Fluttertoast.showToast(
        msg: "User Already Registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
    }
    else{
      Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                    'assets/images/logo3.jpg',
                   
                    fit: BoxFit.fitWidth

                  )
                  ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                  ),
                ),

                 Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: varsity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                      labelText: 'University Name',
                    ),
                  ),
                ),
            
             Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobile,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.smartphone),
                      labelText: 'Your Mobile No',
                    ),
                  ),
                ),
          
            
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                  ),
                ),
                 SizedBox(
              height: 16.0,
            ),
                Container(
                  height: 60,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign Up',
                      style: TextStyle(fontSize: 23.0)
                      ),
                      onPressed: () {
                        register();
                      },
                    )),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text('Already have an account?'),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: (
                        ) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}