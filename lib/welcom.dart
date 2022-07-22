
import 'package:flutter/material.dart';
import 'package:flutterbookminimysql/network/api.dart';
import 'package:flutterbookminimysql/posts.dart';
import 'package:flutterbookminimysql/signin.dart';
import 'package:flutterbookminimysql/user_details_modal.dart';
import 'package:flutterbookminimysql/user_post.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'add_post.dart';
import 'message.dart';

// ignore: camel_case_types
class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

// ignore: camel_case_types
class _welcomeState extends State<welcome> {
String name ="";
  Future getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

   Future userDetails() async {
   // var url = "http://192.168.0.102/books/user_details.php";
    var response = await http.post(BASEURL.user_details, body: {
      "name": name,
    });
    return userDetailsModalFromJson(response.body);
  }

Future logOut(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('name');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
  }

Widget setupAlertDialoadContainer() {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: FutureBuilder(
      future: userDetails(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index){
                UserDetailsModal product = snapshot.data[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('${product.username}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: Text('${product.usermail}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.call),
                        title: Text('${product.userMobile}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.school),
                        title: Text('${product.university}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.create),
                        title: Text('${product.registrationdate}'),
                      ),
                    )
                  ],

                );

              }
            );
          }
           return Center(child: CircularProgressIndicator());
        }
    )
  );
}






  showDetailsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("User Details"),
            content: setupAlertDialoadContainer(),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  @override
  void initState(){
    super.initState();
    getName();
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Dashboard")),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children:[
  //         Center(
  //           child: Text(name),
  //           ),
  //           SizedBox(height: 20.0),
  //           MaterialButton(
  //             color: Colors.blue,
  //             onPressed: (){
  //               logOut(context);
  //             },child: Text("Log Out", style: TextStyle(color: Colors.white)),
  //             )
  //       ]
  //     )
      
  //   );
  // }

   Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text("Hello"+" "+name.toUpperCase()),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    logOut(context);
                  },
                ),
              ],
            ),
          )
,
      appBar: AppBar(
        title: Text("DASHBOARD"),
        elevation: .1,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem(name, Icons.person),
            makeDashboardItem2("Create Ads", Icons.local_post_office),
            makeDashboardItem3("Your Ads", Icons.notifications),
            makeDashboardItem4("All Ads", Icons.list),
            makeDashboardItem5("Inbox", Icons.markunread_mailbox),
            
          ],
        ),
      ),
      
    );
  }

  Card makeDashboardItem2(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageDemo()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

  Card makeDashboardItem3(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

  


  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              showDetailsDialog(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }



  

  Card makeDashboardItem4(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdsPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

   Card makeDashboardItem5(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MsgPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }



}