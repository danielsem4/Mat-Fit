import 'package:fit_app/authentication.dart';
import 'package:fit_app/loginPage/forgotPassword.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:fit_app/loginPage/newAccount.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( 
              colors:[
                Colors.green,
                Colors.lime
              ]
            )
          ),
        ),
      ),
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
  bool isPasswordVisible = false;

  bool loading = false;
  bool wrongInfo = false;

  TextEditingController nameC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();

  void logIn() async {
    this.name = nameC.text;
    this.password = passwordC.text;
    setState(() => loading = true);
    dynamic result = await _auth.signIn(email: name,password: password);
    if(result != 'Signed in') {
      setState(() {
        wrongInfo = true;
        loading = false;
      });
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
  Widget build(BuildContext context) => KeyboardDismisser(
    gestures: [
      GestureType.onTap,
      GestureType.onVerticalDragCancel,
    ],
    child: GestureDetector(
    child: loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
    body: Stack(children: [ 
     SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Padding(
           padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              ('assets/logo/logo_7.png'),
              width: 300,
              height: 195,
              fit: BoxFit.cover,
            ),),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: this.nameC,
                cursorColor: Colors.green.shade400,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green.shade600,width: 3)
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius:  BorderRadius.circular(16),
                       borderSide: BorderSide(color: Colors.green.shade600,width: 3), 
                    ),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.green.shade600,),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[850]),
                    hintText: 'Enter Your Email',
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: this.passwordC,
                obscureText: isPasswordVisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green.shade600,width: 3)
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius:  BorderRadius.circular(16),
                       borderSide: BorderSide(color: Colors.green.shade600,width: 3),
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.green),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[850]),
                    hintText: 'Enter secure password',
                    suffixIcon: IconButton(
                      icon: isPasswordVisible
                      ? Icon(Icons.visibility_off,color: Colors.grey.shade500,)
                      : Icon(Icons.visibility,color: Colors.grey.shade500,),
                      onPressed: () => 
                      setState(() => isPasswordVisible = !isPasswordVisible),
                    )
                    ),
              ),
            ),
            if(wrongInfo)
              Text("Wrong Password or Email !"),
            TextButton(
              onPressed: this.forgotPassword,
              child: Text(
                'Forgot Password ?',
                style: TextStyle(color: Colors.green.shade600, fontSize: 16),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green.shade600, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: this.logIn,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
           TextButton(
              onPressed: this.newAcc,
              child: Text(
                'Create New Account',
                style: TextStyle(color: Colors.green.shade600, fontSize: 18),
              ),
            ),
            SizedBox(height: 300),
            ],
          )
        )
      ],
    )
  )
  ));
}