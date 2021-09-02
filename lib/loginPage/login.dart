import 'package:fit_app/authentication.dart';
import 'package:fit_app/loginPage/forgotPassword.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/loginPage/newAccount.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
 
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({ Key key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthenticationService _auth = AuthenticationService();
  
  
  String name = "";
  String password = "";
  bool corrPassword = false;

  bool loading = false;

  TextEditingController nameC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();

  void logIn() async {
    this.name = nameC.text;
    this.password = passwordC.text;
    setState(() => loading = true);
    dynamic result = await _auth.signIn(email: name,password: password);
    if(result != 'Signed in') {
      setState(() => loading = false);
      print('error signing in');
    } else {
      print('signd in');
    }
   
  }

  void forgotPassword() {
    Navigator.push(context, MaterialPageRoute(builder:
     (context) => ForgotPassword()));
  }

  void newAcc() {
    Navigator.push(context, MaterialPageRoute(builder:
     (context) => NewAccount()));
  }

  @override
  Widget build(BuildContext context) {
    final urLImage1 = 'assets/logo/logo_1.jpg';
    return loading ? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Padding(
           padding: const EdgeInsets.all(80.0),
            child: Image.asset(
              urLImage1,
              width: 500,
              height: 150,
              fit: BoxFit.cover,
            ),),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: this.nameC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'Enter Your Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: this.passwordC,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            if(corrPassword)
              Text("Wrong Password or Email !"),
            TextButton(
              onPressed: this.forgotPassword,
              child: Text(
                'Forgot Password ?',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: this.logIn,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
           TextButton(
              onPressed: this.newAcc,
              child: Text(
                'Creat New Account',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            ),
            SizedBox(height: 300)
          ],
        ));
  }
}