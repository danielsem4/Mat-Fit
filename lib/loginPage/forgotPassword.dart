import 'package:fit_app/authentication.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recover Password'
          ),
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
      body: Body()
    );
  }
}

class Body extends StatefulWidget {
  const Body({ Key key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  AuthenticationService auth = AuthenticationService();
  TextEditingController emailC = new TextEditingController();
  bool loading = false;
  bool resetTry = false;

  void submmit() async {
    setState(() => loading = true);
    bool sent = await auth.resetPassword(emailC.text);
      if (sent) {
        Text("Check your mail");
        setState(() => loading = false);
        
          Navigator.pop(context);
      } else {
        setState(() {
          loading = false;
          resetTry = true;
        });
          Text("Unvalid email");
      }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                ('assets/logo/fpassword.png'),
                width: 180,
                height: 150,
                fit: BoxFit.cover,
            ),),
            SizedBox(height: 15),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: this.emailC,
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
            SizedBox(height: 20),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                onPressed: this.submmit,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            resetTry ? buildDialog() : Container()
          ]
    ));
  }
  
  Widget buildDialog() {
    return Dialog(  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        height: 170,
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              child: Icon(Icons.do_not_disturb_alt, size: 60,color: Colors.redAccent),
            ),
            Expanded(
              child: Container(
                color: Colors.blueGrey.shade700,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "The email dose not exists",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18
                           ) ,
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back to login page"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}