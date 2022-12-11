import 'package:elevatormaintance/api/repositories/admin/user_repo.dart';import 'package:flutter/material.dart';import '../../../../constants/app_color.dart';class StaffListScreen extends StatefulWidget {  const StaffListScreen({Key? key}) : super(key: key);  @override  State<StaffListScreen> createState() => _StaffListScreenState();}class _StaffListScreenState extends State<StaffListScreen> {  late Future<List<dynamic>> userList;  @override  initState() {    super.initState();    userList = AdminUserRepository().getStaffList();  }  bool isSwitched = false;  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        automaticallyImplyLeading: false,        backgroundColor: white,        title: const Text("Staff List", style: TextStyle(color: black),),        leading: IconButton(          icon: const Icon(Icons.arrow_back_ios, color: black,),          onPressed: () {            Navigator.pop(context);            Navigator.pop(context);          },        ),      ),      body: FutureBuilder<List<dynamic>>(          future: userList,          builder: (context, snapShot) {            if(snapShot.hasData){              return Padding(                padding: const EdgeInsets.only(bottom: 35.0),                child: SingleChildScrollView(                    child: Padding(                      padding: const EdgeInsets.all(20),                      child: snapShot.data!.isEmpty ? Text("No User Found") : ListView.builder(                          shrinkWrap: true,                          physics: const BouncingScrollPhysics(),                          scrollDirection: Axis.vertical,                          itemCount: snapShot.data!.length,                          itemBuilder: (context, int index) {                            return Padding(                              padding: const EdgeInsets.symmetric(vertical: 10),                              child: Card(                                elevation: 2,                                margin: EdgeInsets.zero,                                child: Container(                                  height: 160,                                  decoration: BoxDecoration(                                    border: Border.all(color: Colors.grey),                                    borderRadius: BorderRadius.circular(10),                                    color: white,                                  ),                                  child: Column(                                    crossAxisAlignment: CrossAxisAlignment.start,                                    children: [                                      Row(                                        mainAxisAlignment: MainAxisAlignment.start,                                        children: [                                          Padding(                                            padding: const EdgeInsets.all(8.0),                                            child: Image.asset( 'assets/images/userlist.png',                                              height: 60,                                              width: 60,                                            ),                                          ),                                          Column(                                            crossAxisAlignment: CrossAxisAlignment.start,                                            children: [                                              Text(snapShot.data![index]["id"].toString(),                                                style: const TextStyle(                                                    color: Colors.black,                                                    fontSize: 16),                                              ),                                              Text(snapShot.data![index]["display_name"].toString(),                                                style: const TextStyle(                                                    color: Colors.black,                                                    fontSize: 16),                                              ),                                              // snapShot.data![index]["first_name"] == null ? Container() :                                              // Text("${snapShot.data![index]["first_name"].toString()} ${snapShot.data![index]["last_name"].toString()}",                                              //   style: const TextStyle(                                              //       color: Colors.black,                                              //       fontSize: 16),                                              // ),                                            ],                                          ),                                          // OutlinedButton(                                          //     onPressed: () {},                                          //     style: OutlinedButton                                          //         .styleFrom(                                          //       side: const BorderSide(                                          //           width: 2,                                          //           color: lightBlue),                                          //       shape:                                          //       const CircleBorder(),                                          //     ),                                          //     child: const Icon(                                          //       Icons.check,                                          //       color: Colors.blue,                                          //       size: 20,                                          //     )),                                          // OutlinedButton(                                          //     onPressed: () {},                                          //     style: OutlinedButton                                          //         .styleFrom(                                          //       side: const BorderSide(                                          //           width: 2,                                          //           color: Colors.red),                                          //       shape: CircleBorder(),                                          //     ),                                          //     child: const Icon(                                          //       Icons.clear,                                          //       color: Colors.red,                                          //       size: 20,                                          //     ))                                        ],                                      ),                                      const SizedBox(height: 5),                                      Column(                                        children: [                                          Padding(                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),                                            child: Row(                                              children: [                                                OutlinedButton(                                                    onPressed: () {                                                      showDialog<String>(                                                        context: context,                                                        builder: (BuildContext                                                        context) =>                                                            AlertDialog(                                                                title: const Text(                                                                    'Delete User'),                                                                content:                                                                SingleChildScrollView(                                                                  child: Column(                                                                    children: [                                                                      const Text(                                                                          'Would you like to delete the user?'),                                                                      Row(                                                                        children: [                                                                          TextButton(                                                                            onPressed: () => Navigator.pop(                                                                                context,                                                                                'Cancel'),                                                                            child: const Text(                                                                                'Cancel'),                                                                          ),                                                                          TextButton(                                                                            onPressed:                                                                                () {},                                                                            child: const Text(                                                                                'OK'),                                                                          ),                                                                        ],                                                                      )                                                                    ],                                                                  ),                                                                )),                                                      );                                                    },                                                    style: OutlinedButton.styleFrom(                                                        backgroundColor:                                                        solidRed2,                                                        shape: CircleBorder(),                                                        padding: EdgeInsets.all(5)),                                                    child: const Icon(                                                      Icons.delete,                                                      color: Colors.white,                                                      size: 30,                                                    )),                                                Column(                                                  children: [                                                    Text("Active"),                                                    Center(                                                      child: Switch(                                                        value: snapShot.data![index]["status"] == "Active" ? true : false,                                                        onChanged: (value) {},                                                        activeTrackColor:                                                        Colors.lightGreenAccent,                                                        activeColor: Colors.green,                                                      ),                                                    ),                                                  ],                                                ),                                                Column(                                                  children: [                                                    const Text("Suspend"),                                                    Center(                                                      child: Switch(                                                        value: false,                                                        onChanged: (value) {},                                                        activeTrackColor:                                                        Colors.lightGreenAccent,                                                        activeColor: Colors.green,                                                      ),                                                    ),                                                  ],                                                )                                              ],                                            ),                                          )                                        ],                                      )                                    ],                                  ),                                ),                              ),                            );                          }),                    )),              );            }            else if(snapShot.hasError){              return Center(child: const Text("Something went wrong"));            }            return const Center(child: CircularProgressIndicator());          }      ),    );  }}