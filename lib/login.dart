// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:register_form/main.dart';
import 'package:register_form/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  print(appDocumentsDir.path);
  //Hive.registerAdapter(studentAdapter());
  var box = await Hive.openBox('black');
  runApp(const MaterialApp(
    home: login(),
    debugShowCheckedModeBanner: false,
  ));
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Box box = Hive.box('black');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool error_username = false;
  bool error_password = false;
  bool checked = false;

  void getdata() async {
    if (box.get('email') != null) {
      email.text = box.get('email');
      checked = true;
      setState(() {});
    }
    if (box.get('pass') != null) {
      password.text = box.get('pass');
      checked = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "LOGIN",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              "email:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Flexible(
              child: Card(
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: "email",
                      isDense: true,
                      hintText: "Enter Email",
                      border: const OutlineInputBorder(),
                      errorText: (error_username) ? "Enter Email" : null),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text(
              "pass :",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Flexible(
              child: Card(
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "password",
                      isDense: true,
                      hintText: "Enter Password",
                      border: const OutlineInputBorder(),
                      errorText: (error_password) ? "Enter Password" : null),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Remember Me",
              style: TextStyle(color: Colors.white),
            ),
            Checkbox(
              value: checked,
              onChanged: (value) {
                checked = !checked;
                setState(() {});
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GFButton(
            highlightColor: Colors.lime[700],
            color: Colors.indigoAccent,
            onPressed: () {
              String emails,pass;
              emails = email.text;
              pass = password.text;
              error_username = false;
              error_password = false;
              String pre =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              RegExp regexp = RegExp(pre);
              String uper_case = r'[A-Z]';
              RegExp reguper = RegExp(uper_case);
              String lower_case = r'[a-z]';
              RegExp regLower = RegExp(lower_case);
              String number = r'[0-9]';
              RegExp regnumber = RegExp(number);
              String special = r'[!@#\$&*~]';
              RegExp regspecial = RegExp(special);
              String length = r'.{8,}';
              RegExp regLength = RegExp(length);
              if(emails=="")
                {
                  error_username = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("enter email")));
                }
              else if (!regexp.hasMatch(emails)) {
                error_username = true;
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("enter valid email")));
              }
              else if(pass=="")
                {
                  error_password = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("enter password")));
                }
              else if (!reguper.hasMatch(pass)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("at least one uper case latter")));
              } else if (!regLower.hasMatch(pass)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("at least one lower case latter")));
              } else if (!regnumber.hasMatch(pass)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("at least one number")));
              } else if (!regspecial.hasMatch(pass)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("at least one Special character")));
              } else if (!regLength.hasMatch(pass)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("at least must be 8 length ")));
              }
             else
               {
                 Navigator.pushReplacement(context, MaterialPageRoute(
                   builder: (context) {
                     return const show();
                   },
                 ));
               }
            },
            child: RichText(
                text: const TextSpan(
              text:' Register Now',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0XFF4321F5)),
                ),
            )),
        TextButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const registration();
          },));
        }, child: const Text("New User?"))
      ]),
    );
  }

  void login() {
    if (checked) {
      box.put('email', email.value.text);
      box.put('pass', password.value.text);
    }
  }
}
