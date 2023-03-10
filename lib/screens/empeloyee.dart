// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures, file_names, unused_import, unused_field, use_key_in_widget_constructors, unused_local_variable, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_bab_elrian/screens/emp_chatscreen.dart';
import 'package:hr_bab_elrian/screens/reports.dart';
import 'package:hr_bab_elrian/screens/settings.dart';
import '../controllers/auth_controller.dart';
import 'docorbi.dart';
import 'helloscreen.dart';
import 'chatspage.dart';
import 'login.dart';
import 'package:hr_bab_elrian/translation/translationCTRL.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmpeloyeeCs extends StatelessWidget {
  const EmpeloyeeCs({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 650;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('empeloyee').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Bar(),
              Container(
                height: MediaQuery.of(context).size.height - height,
                child: ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    var imageurl = documentSnapshot['imageurl'];
                    var gname = documentSnapshot['gname'];
                    var desc = documentSnapshot['desc'];
                    var did = documentSnapshot.id;
                    return ListTile(
                      onTap: () async {
                        Get.to(EchatScreen(
                          imageurl: imageurl,
                          gname: gname,
                          did: did,
                        ));
                      },
                      subtitle: Text(
                        '${desc}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      title: Text(
                        '${gname}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        backgroundImage: NetworkImage('${imageurl}'),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        });
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 35, bottom: 10, left: 20, right: 20),
      height: MediaQuery.of(context).size.height - 650,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Bab Elrian hr',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.4,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Get.to(Setting());
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(ChatsS());
                  },
                  child: Text(
                    'mesg'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Get.to(ReportsS());
                  },
                  child: Text(
                    'rep'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Color.fromARGB(255, 33, 72, 104).withOpacity(0.4),
          ),
        ],
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 20, 106, 192),
              Color.fromARGB(255, 30, 120, 203),
              Color.fromARGB(255, 50, 127, 167),
              Color.fromARGB(255, 39, 111, 137)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.2, 0.5, 0.8]),
      ),
    );
  }
}
