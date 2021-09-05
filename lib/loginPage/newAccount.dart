import 'package:fit_app/authentication.dart';
import 'package:fit_app/database.dart';
import 'package:fit_app/loginPage/loading.dart';
import 'package:flutter/material.dart';

class NewAccount extends StatelessWidget {
  const NewAccount({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mat-Fit'),backgroundColor: Colors.green,),
      body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> { 

  final AuthenticationService _auth = AuthenticationService();
  bool loading = false;
  DatabaseService dbService = new DatabaseService();

  // The User Info  
  String name = "";
  String lastName = "";
  String password = "";
  String repeatPassword = "";
  String email = "";
  String phoneNumber = "";

  // Flags to check if the info is legal
  bool passwordFlag = false;
  bool repeatPaswwordFlag = false;
  bool emailFlag = false;
  bool phoneNumberFlag = false;

  // Controllers
  TextEditingController nameC = new TextEditingController();
  TextEditingController lastNameC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();
  TextEditingController repeatPasswordC = new TextEditingController();
  TextEditingController emailC = new TextEditingController();
  TextEditingController phoneNumberC = new TextEditingController();

  // Function that check if the info is valid and call signUp function
  void checkIntactness() {
    this.validPassword();
    this.validEmail();
    this.validPhoneNumber();
    if(!this.repeatPaswwordFlag & !this.passwordFlag & !this.emailFlag & !this.phoneNumberFlag) {
        this.name = nameC.text;
        this.lastName = lastNameC.text;
        this.register();
    }
  }

  // functions that check the info structure intactness 
  bool validatePasswordStructure(String value) {
        String pattern = r'^.{6,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }

  bool validatePhoneNumberStructure(String value) {
        String pattern = r'^.{10,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }

  bool validateEmailStructure(String value) {
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
  // functions that update the bool parameters 
  void validEmail() {
    this.email = emailC.text;

    if(validateEmailStructure(this.email)) {
      setState(() {
        this.emailFlag = false;
      });
    } else {
      setState(() {
        this.emailFlag = true;
      });
      this.emailC.clear();
    }
  }

  void validPhoneNumber() {
    this.phoneNumber = phoneNumberC.text;

    if(validatePhoneNumberStructure(this.phoneNumber)) {
        setState(() {
          this.phoneNumberFlag = false;
        });
    } else {
      setState(() {
        this.phoneNumberFlag = true;
      });
      this.phoneNumberC.clear();
    }
  }

  void validPassword() {
    this.password = passwordC.text;
    this.repeatPassword = repeatPasswordC.text;
    
    if(validatePasswordStructure(this.password)) {
      if(repeatPassword == password) {
        setState(() {
          this.passwordFlag = false;
          this.repeatPaswwordFlag = false;
        });
      } else {
        setState(() {
          this.passwordFlag = false;
          this.repeatPaswwordFlag = true;
        });
        this.repeatPasswordC.clear();
      }
    } else {
      setState(() {
      this.passwordFlag = true;
      });
      this.passwordC.clear();
    }
  }
  // navigate to the home page
  void register() async {
    setState(() => loading = true);
    await _auth.signUp(email: emailC.text,password: passwordC.text);
    dbService.saveUser(email, name, lastName, phoneNumber);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : SingleChildScrollView(
       child: Column(
         children: <Widget>[
           SizedBox(
              height: 10
           ),
          //  Container(
          //   width: 300,
          //  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 5),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(0),
          //     color: Colors.white,
          //     border: Border.all(),
          //   ),
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton<String>(
          //       value: value,
          //       items: items
          //       .map((item) => DropdownMenuItem<String>(
          //         child: Row(
          //           children:[
          //             Icon(Icons.people),
          //             const SizedBox(width: 8),
          //             Text(
          //               item,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 15,
          //             )
          //           ),
          //           ]
          //         ),
          //         value: item,
          //         ))
          //         .toList(),
          //         onChanged: (value) => setState(() {
          //           this.value = value;
          //         }),
          //     ),
          //   ),
          // ),
           Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 30, bottom: 0),
              child: TextField(
                controller: this.nameC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    hintText: 'Enter Your Name'),
              ),
            ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: this.lastNameC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Last Name',
                    hintText: 'Enter Your Last Name'),
              ),
            ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: this.emailC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                     prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'Enter Your Email'),
              ),
            ),
            if(this.emailFlag) 
              Text("The Email Is Illegal"),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: this.phoneNumberC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                     prefixIcon: Icon(Icons.phone_iphone),
                    labelText: 'Phone Number',
                    hintText: 'Enter Your Phone Number'),
              ),
            ),
            if(this.phoneNumberFlag)
              Text("The Phone Number Is Illegal"),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: this.passwordC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                     prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Enter Your Password'),
              ),
            ),
            if(this.passwordFlag)
               Text("The Password Should contain at list 6 characters!"),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: this.repeatPasswordC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Repeat Your Password Again'),
              ),
            ),
            if(this.repeatPaswwordFlag)
               Text("The Password Should Be The Same"),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: this.checkIntactness,
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
         ]
       )
    );
  }
}