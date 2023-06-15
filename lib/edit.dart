// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:register_form/view.dart';
import 'package:register_form/main.dart';

class update extends StatefulWidget {
  //const update(Map<dynamic, dynamic> myDetail, {Key? key}) : super(key: key);

  Map myDetail;

  update(this.myDetail);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  XFile? imagess;
  bool temp1 = false;
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(backgroundColor: Colors.black,
        title: const Text(
          "UPDATE",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //           colors: [Colors.purple, Colors.red, Colors.teal],
        //           begin: Alignment.topRight,
        //           end: Alignment.bottomRight)),
        // ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFImageOverlay(
            boxFit: BoxFit.fill,
            shape: BoxShape.circle,
            width: 150,
            color: Colors.amber,
            height: 150,
            alignment: Alignment.bottomRight,
            image: (temp1)
                ? FileImage(File(imagess!.path))
                : FileImage(
              File("${widget.myDetail['image']}"),
            ),
            child: Baseline(
              baseline: 10,
              baselineType: TextBaseline.ideographic,
              child: FloatingActionButton(backgroundColor: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "you can choose camera or gallery img",
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            IconButton(
                                highlightColor: Colors.red[900],
                                color: Colors.indigo,
                                onPressed: () async {
                                  imagess = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  if (imagess != null) {
                                    temp1 = true;
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
                                    temp1 = true;
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
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GFButton(
                  color: Colors.amber,
                  highlightColor: Colors.indigo[900],
                  onPressed: () async {
                    var path =
                        await ExternalPath.getExternalStoragePublicDirectory(
                            ExternalPath.DIRECTORY_DOWNLOADS) +
                            "/ishu";

                    Directory dir = Directory(path);
                    if (!await dir.exists()) {
                      await dir.create();
                    }

                    String ImageName = "${widget.myDetail["image"]}";

                    print(widget.myDetail['image']);

                    File f = File(ImageName);

                    f.writeAsBytes(await imagess!.readAsBytes());

                    String qur =
                        "UPDATE register SET `image`='${f.path}' WHERE id='${widget.myDetail['id']}'";

                    registration.database!.rawUpdate(qur);
                    setState(() {});
                  },
                  child: const Text("Update")),
              GFButton(
                  color: Colors.amber,
                  highlightColor: Colors.teal[900],
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const show();
                      },
                    ));
                  },
                  child: const Text("View"))
            ],
          )
        ],
      ),
    );
  }
}
