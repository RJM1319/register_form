// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:register_form/login.dart';
import 'package:register_form/view.dart';
import 'package:sqflite/sqflite.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);
  static Database? database;

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  TextEditingController names = TextEditingController();
  TextEditingController emails = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController passwords = TextEditingController();
  TextEditingController images = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  bool temp = false;
  XFile? imagess;
  bool pw = true, C1 = false, C2 = false, C3 = false, C4 = false;
  bool errorname = false;
  bool erroremail = false;
  bool errorcontact = false;
  bool errorpassword = false;
  List<bool> temps = [];
  String name = "",
      contactss = "",
      emailss = "",
      pass = "",
      gender = "",
      date = "",
      img = "";
  List<String> hobby = [];
  List<String> city = <String>[
    '',
    'welligton',
    'queensland',
    'sydny',
    'surat',
    'captown',
    'london',
    'malbourne',
    'johanisburg',
    'dawarka',
    'ahamadabad',
    'skytown',
    'perth',
    'brisbane'
  ];
  late String dropdown;
  DateTime? pickedDate;

  app_db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'anz.db');
    registration.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE register (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT,email TEXT,password TEXT,hobby TEXT,gender TEXT,city TEXT,date TEXT,image TEXT)');
        });
  }

  get_permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_permission();
    app_db();
    dropdown = city.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(backgroundColor: Colors.black,
        title: const Text(
          "REGISTRATION",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const login();
          },));
        }, icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Flexible(
                  child: Card(
                    child: TextField(
                      controller: names,
                      decoration: InputDecoration(
                          prefixIcon:
                          const Icon(Icons.supervisor_account_outlined),
                          border: const OutlineInputBorder(),
                          labelText: "name",
                          hintText: "Enter name",
                          errorText: (errorname) ? "enter name" : null),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Email:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Flexible(
                  child: Card(
                    child: TextField(
                      controller: emails,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder(),
                          labelText: "email",
                          hintText: "Enter email",
                          errorText: (erroremail) ? "enter email" : null),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Mobil:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Flexible(
                  child: Card(
                    child: TextField(
                      controller: contacts,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.contacts),
                          border: const OutlineInputBorder(),
                          labelText: "contact",
                          hintText: "Enter contact",
                          errorText: (errorcontact) ? "enter contact" : null),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Pass :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Flexible(
                  child: Card(
                    child: TextField(
                      controller: passwords,
                      obscureText: pw,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                            onPressed: () {
                              pw = !pw;
                              setState(() {});
                            },
                            icon: (pw)
                                ? const Icon(Icons.remove_red_eye_outlined)
                                : const Icon(Icons.remove_red_eye)),
                        border: const OutlineInputBorder(),
                        labelText: "password",
                        hintText: "Enter password",
                        errorText: (errorpassword) ? "enter password" : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  const SizedBox(
                    height: 55,
                    width: 5,
                  ),
                  const Text(
                    "Hobby : ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Checkbox(
                    value: C1,
                    onChanged: (value) {
                      C1 = value!;
                      (C1 = value)
                          ? hobby.add("Cricket")
                          : hobby.remove("Cricket");

                      setState(() {});
                    },
                  ),
                  const Text(
                    "Cricket",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: C2,
                    onChanged: (value) {
                      C2 = value!;
                      if (C2 = value) {
                        hobby.add("Football");
                      } else {
                        hobby.remove("Football");
                      }
                      setState(() {});
                    },
                  ),
                  const Text(
                    "Football",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: C3,
                    onChanged: (value) {
                      C3 = value!;
                      if (C3 = value) {
                        hobby.add("Kabaddi");
                      } else {
                        hobby.remove("Kabaddi");
                      }
                      setState(() {});
                    },
                  ),
                  const Text(
                    "Kabaddi",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: C4,
                    onChanged: (value) {
                      C4 = value!;
                      if (C4 = value) {
                        hobby.add("Fight");
                      } else {
                        hobby.remove("Fight");
                      }
                      setState(() {});
                    },
                  ),
                  const Text(
                    "Fight",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 55,
                    width: 5,
                  ),
                  const Text("Gender : ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Radio(
                    value: "male",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  const Text(
                    "male",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Radio(
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  const Text(
                    "female",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Radio(
                    value: "other",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  const Text(
                    "other",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                  height: 55,
                ),
                const Text(
                  "City : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Flexible(
                    child: Card(
                      child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            value: dropdown,
                            icon: const Icon(Icons.location_on_sharp),
                            items: city
                                .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                                .toList(),
                            onChanged: (dynamic value) {
                              dropdown = value!;
                              setState(() {});
                            },
                          )),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 20),
                    height: 55,
                    alignment: Alignment.center,
                    child: const Text(
                      "Birth Date : ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Flexible(
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          (pickedDate == null) ? "" : date,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))),
                Card(
                  margin: const EdgeInsets.all(15),
                  child: IconButton(
                      onPressed: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now());
                        date =
                        "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                        setState(() {});
                      },
                      icon: const Icon(Icons.date_range)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                    color: Colors.amber,
                    highlightColor: Colors.purple[900],
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                "you can choose camera or gallery img"),
                            actions: [
                              IconButton(
                                  hoverColor: Colors.amber,
                                  highlightColor: Colors.red[900],
                                  color: Colors.indigo,
                                  onPressed: () async {
                                    imagess = await _picker.pickImage(
                                        source: ImageSource.camera);
                                    if (imagess != null) {
                                      temp = true;
                                    }
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.camera)),
                              IconButton(
                                  highlightColor: Colors.red[900],
                                  color: Colors.indigo,
                                  onPressed: () async {
                                    imagess = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (imagess != null) {
                                      temp = true;
                                    }
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.folder_copy))
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Upload")),
                GFButton(
                    color: Colors.amber,
                    highlightColor: Colors.orange[900],
                    onPressed: () async {
                      name = names.text;
                      contactss = contacts.text;
                      emailss = emails.text;
                      pass = passwords.text;
                      img = images.text;
                      errorname = false;
                      String pattern =
                          r'^(?:(?:\+|0{0,2})91(\5*[\-]\5*)?[0]?)?[789]\d{9}$';
                      RegExp regExp = RegExp(pattern);
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
                      erroremail = false;
                      errorcontact = false;
                      errorpassword = false;
                      String hob = hobby.join();
                      if (name.isEmpty) {
                        errorname = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter name")));
                      } else if (emailss.isEmpty) {
                        erroremail = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter email")));
                      } else if (!regexp.hasMatch(emailss)) {
                        erroremail = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter valid email")));
                      } else if (contactss.isEmpty) {
                        errorcontact = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter contact")));
                      } else if (!regExp.hasMatch(contactss)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("enter valid contact")));
                      } else if (pass.isEmpty) {
                        errorpassword = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter password")));
                      } else if (!reguper.hasMatch(pass)) {
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
                      } else {
                        var path = await ExternalPath
                            .getExternalStoragePublicDirectory(
                            ExternalPath.DIRECTORY_DOWNLOADS) +
                            "/ishu";
                        Directory dir = Directory(path);
                        if (!await dir.exists()) {
                          dir.create();
                        }
                        String imgName = "img${Random().nextInt(1000)}.jpg";
                        File f = File("${dir.path}/$imgName");

                        f.writeAsBytes(await imagess!.readAsBytes());

                        String qury =
                            "INSERT INTO register (name,contact,email,password,hobby,gender,city,date,image) VALUES ('$name','$contactss','$emailss','$pass','$hob','$gender','$dropdown','$date','${f.path}')";
                        registration.database!.rawInsert(qury);
                        names.clear();
                        emails.clear();
                        passwords.clear();
                        contacts.clear();
                        setState(() {});
                      }
                    },
                    child: const Text("Register")),
                GFButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const show();
                      },
                    ));
                  },
                  color: Colors.amber,
                  highlightColor: Colors.red[900],
                  child: const Text("NEXT"),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: (temp) ? Image.file(File(imagess!.path)) : const Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
