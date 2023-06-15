// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/getwidget.dart';
import 'package:register_form/edit.dart';
import 'package:register_form/main.dart';
import 'package:register_form/update.dart';

class show extends StatefulWidget {
  const show({Key? key}) : super(key: key);

  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {
  List<Map> myDetail = [];
  List<Map> temp_names = [];

  List name = [];
  List search_name = [];
  List search_contact = [];
  bool temp_search = false;
  List contact = [];
  List id = [];
  List img = [];
  List email = [];
  List password = [];
  List gender = [];
  List city = [];
  List hobby = [];
  List bdate = [];
  bool t = true;

  Directory? dir;

  View_Data() async {
    String qur = "select * from register";
    temp_names = await registration.database!.rawQuery(qur);
    var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        "/ishu";
    dir = Directory(path);
    if (t == true) {
      myDetail = temp_names;
      /*  name.clear();
        for (int i = 0; i < myDetail.length; i++) {
          name.add(myDetail[i]['name']);
          contact.add(myDetail[i]['contact']);
        }
        search_name = name;
        search_contact = contact;
*/
      t = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDetail.clear();
    //View_Data();
    // my = my_name.where((element) => element.toString().contains('j')).toList();
    // print("name = $my");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Colors.black,
        title: (temp_search)
            ? TextField(
                onChanged: (value) {
                  List<Map> Data = [];

                  if (!value.isNotEmpty) {
                    Data = temp_names;
                  } else {
                    Data = temp_names
                        .where((element) =>
                            element['name'].toString().contains(value))
                        .toList();
                  }

                  myDetail = Data;
                  // contact = search_contact
                  //     .where((element) => element.toString().contains(value))
                  //     .toList();
                  // print(contact);
                  //  print(name);
                  setState(() {});
                },
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: "search",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              )
            : const Text(
                "USER LIST",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const registration();
                },
              ));
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                temp_search = !temp_search;
                setState(() {});
              },
              icon: (temp_search)
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search))
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: View_Data(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(myDetail);
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: myDetail.length,
                itemBuilder: (context, index) {
                  String mykey = "$index";
                  return Slidable(
                    key: Key(mykey),
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.all(10),
                        onPressed: (context) {
                          String qur =
                              "delete from register where id=${myDetail[index]['id']}";
                          registration.database!.rawDelete(qur);
                          // File f = File(
                          //     "${dir!.path}/${myDetail[index]['image']}");
                          // f.delete();
                          setState(() {});
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: "Delete",
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.all(10),
                        onPressed: (context) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return update(myDetail[index]);
                            },
                          ));
                        },
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: "Edit",
                      ),
                    ]),
                    endActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.all(10),
                        onPressed: (context) {},
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: "Share",
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.all(10),
                        onPressed: (context) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return edit(myDetail[index]);
                            },
                          ));
                        },
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit_note_rounded,
                        label: "Full Edit",
                      ),
                    ]),
                    child: Card(
                      color: Colors.amber,
                      child: ExpansionTile(
                        backgroundColor: Colors.pink[700],
                        iconColor: Colors.black,
                        leading: CircleAvatar(
                            backgroundImage:
                                FileImage(File("${myDetail[index]['image']}"))),
                        title: Text(
                          "${myDetail[index]['name']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        subtitle: Text(
                          "${myDetail[index]['contact']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(75),
                                  height: 150,
                                  width: 150,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      //shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: FileImage(File(
                                            "${myDetail[index]['image']}")),
                                        fit: BoxFit.fill,
                                      )),
                                  // child: Image(
                                  //     image: FileImage(File(
                                  //         "${dir!.path}/${myDetail[index]['image']}")),fit: BoxFit.fill,),
                                ),
                                Text(
                                  "Email :- ${myDetail[index]['email']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Password :- ${myDetail[index]['password']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Gender :- ${myDetail[index]['gender']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "City :- ${myDetail[index]['city']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Hobby's :- ${myDetail[index]['hobby']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "BirthDate :- ${myDetail[index]['date']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
