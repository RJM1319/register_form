// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:register_form/main.dart';
import 'package:register_form/view.dart';

class edit extends StatefulWidget {
  //const edit(Map<dynamic, dynamic> myDetail, {Key? key}) : super(key: key);

  Map myDetail;

  edit(this.myDetail);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController names = TextEditingController();
  TextEditingController emails = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController passwords = TextEditingController();

  // TextEditingController images = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool temp = false;
  XFile? imagess;
  bool pw = true;
  String gender = "", date = "";
  List<bool> temps = [false, false, false, false];
  List<String> hobby = ["", "", "", ""];
  String image_name = "";
  late String qur;
  List<dynamic> city = [
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    names.text = widget.myDetail['name'];
    emails.text = widget.myDetail['email'];
    contacts.text = widget.myDetail['contact'];
    passwords.text = widget.myDetail['password'];
    gender = widget.myDetail['gender'];
    date = widget.myDetail['date'];
    image_name = widget.myDetail['image'];
    dropdown = widget.myDetail['city'];

    if (widget.myDetail['hobby'].toString().contains('Cricket')) {
      temps[0] = true;
      hobby.add('Cricket');
    }
    if (widget.myDetail['hobby'].toString().contains('Football')) {
      temps[1] = true;
      hobby.add('Football');
    }
    if (widget.myDetail['hobby'].toString().contains('Kabaddi')) {
      temps[2] = true;
      hobby.add('Kabaddi');
    }
    if (widget.myDetail['hobby'].toString().contains('Fight')) {
      temps[3] = true;
      hobby.add('Fight');
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(backgroundColor: Colors.black,
        title: const Text(
          "FULL_UPDATE",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,

        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const show();
                },
              ));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            GFImageOverlay(
              boxFit: BoxFit.fill,
              shape: BoxShape.circle,
              width: 150,
              color: Colors.amber,
              height: 150,
              alignment: Alignment.bottomRight,
              image: (temp)
                  ? FileImage(File(imagess!.path))
                  : FileImage(
                      File("${widget.myDetail['image']}"),
                    ),
              child: Baseline(
                baseline: 10,
                baselineType: TextBaseline.ideographic,
                child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              "you can choose camera or gallery img",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              IconButton(
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
                                  icon: const Icon(
                                    Icons.camera,
                                  )),
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
                    child: const Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.red,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.supervisor_account_outlined),
                          border: OutlineInputBorder(),
                          labelText: "name",
                          hintText: "Enter name"),
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          labelText: "email",
                          hintText: "Enter email"),
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.contacts),
                          border: OutlineInputBorder(),
                          labelText: "contact",
                          hintText: "Enter contact"),
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
                          hintText: "Enter password"),
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
                    value: temps[0],
                    onChanged: (value) {
                      temps[0] = value!;
                      if (temps[0]) {
                        hobby[0] = "Cricket ";
                      } else {
                        hobby[0] = "";
                      }

                      setState(() {});
                    },
                  ),
                  const Text(
                    "Cricket",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: temps[1],
                    onChanged: (value) {
                      temps[1] = value!;
                      if (temps[1]) {
                        hobby[1] = "Football ";
                      } else {
                        hobby[1] = "";
                      }
                      setState(() {});
                    },
                  ),
                  const Text(
                    "Football",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: temps[2],
                    onChanged: (value) {
                      temps[2] = value!;
                      if (temps[2]) {
                        hobby[2] = "Kabaddi ";
                      } else {
                        hobby[2] = "";
                      }
                      setState(() {});
                    },
                  ),
                  const Text(
                    "Kabaddi",
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    value: temps[3],
                    onChanged: (value) {
                      temps[3] = value!;
                      if (temps[3]) {
                        hobby[3] = "Fight ";
                      } else {
                        hobby[3] = "";
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
                    highlightColor: Colors.orange[900],
                    onPressed: () async {
                      String Name = names.text;
                      String Email = emails.text;
                      String Password = passwords.text;
                      String Contact = contacts.text;
                      String Hobby = hobby.join();
                      // String GenderSelect = gender;
                      String City = dropdown;
                      if (temp == true) {
                        var path = await ExternalPath
                                .getExternalStoragePublicDirectory(
                                    ExternalPath.DIRECTORY_DOWNLOADS) +
                            "/ishu";

                        //Directory dir = Directory(path);
                        Directory dir = Directory(path);
                        if (!await dir.exists()) {
                          dir.create();
                        }

                        image_name = "img${Random().nextInt(1000)}.jpg";
                        File f = File("${dir.path}/$image_name");
                        print(image_name);

                        f.writeAsBytes(await imagess!.readAsBytes());

                        qur =
                            "UPDATE register SET `name`='$Name',`email`='$Email',`password`='$Password',`contact`='$Contact',`hobby`='$Hobby',`gender`='$gender',`date`='$date',`city`='$City',`image`='${f.path}' WHERE id='${widget.myDetail['id']}'";
                        File("${widget.myDetail['image']}").delete();
                      } else {
                        qur =
                            "UPDATE register SET `name`='$Name',`email`='$Email',`password`='$Password',`contact`='$Contact',`hobby`='$Hobby',`gender`='$gender',`date`='$date',`city`='$City',`image`='${widget.myDetail['image']}' WHERE id='${widget.myDetail['id']}'";
                      }
                      registration.database!.rawUpdate(qur);
                      print(qur);
                      names.clear();
                      emails.clear();
                      passwords.clear();
                      contacts.clear();

                      setState(() {});
                    },
                    child: const Text("UPDATE")),
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
          ],
        ),
      ),
    );
  }
}
