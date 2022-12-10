import 'dart:convert';import 'package:flutter/material.dart';import 'package:intl/intl.dart';import 'package:shared_preferences/shared_preferences.dart';import '../../../api/repositories/order_repository.dart';import '../../../constants/app_color.dart';import '../../../constants/constants_name.dart';import '../../../constants/font_size.dart';import '../../../constants/font_weight.dart';import '../../../model/response/user_response.dart';import '../../widget/custom_app_bar.dart';class OrderHistoryScreen extends StatefulWidget {  const OrderHistoryScreen({Key? key}) : super(key: key);  @override  State<OrderHistoryScreen> createState() =>      _OrderHistoryScreenState();}class _OrderHistoryScreenState extends State<OrderHistoryScreen> {  late Future<dynamic> orderValue;  List<String> statusList = [    "ALL",    "CONFIRMED",    "PENDING",    "DELIVERED",    "CANCELLED",  ];  @override  void initState() {    orderValue = OrderRepository().getAllOrder();    getUser();    super.initState();  }  UserResponse? user;  getUser() async {    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    String? userData = sharedPreferences.getString('user');    Map<String, dynamic> userMap = json.decode(userData!);    UserResponse userD = UserResponse.fromJson(userMap);    setState(() {      user = userD;    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: appBar(          appBarBackgroupColor: white,          noBackButton: user == null ? false : user!.isStaff == true ? true : false,          navTitle: "Order History",          settingIcon: InkWell(              onTap: openFilterBottomSheet,              child: const Padding(                  padding: EdgeInsets.all(8.0),                  child: Icon(                    Icons.filter_alt_outlined,                    color: black,                  )))),      body: RefreshIndicator(          onRefresh: () async {            setState(() {              orderValue = OrderRepository().getAllOrder();            });          },          child: FutureBuilder<dynamic>(        future: orderValue,          builder: (context, snapshot) {        if (snapshot.hasData) {          return SafeArea(            child: snapshot.data != null ? snapshot.data == 0                ? Text("No order Found")                : ListView.builder(                    padding: EdgeInsets.zero,                    shrinkWrap: true,                    itemCount: snapshot.data!.length,                    itemBuilder: (context, int index) {                      return Card(                        elevation: 0,                        margin: const EdgeInsets.only(                            bottom: 10.0,                            top: 13.0,                            left: 7.0,                            right: 7.0),                        child: Container(                          decoration: BoxDecoration(                              color: cardBgColor,                              borderRadius: BorderRadius.circular(8)),                          child: InkWell(                            child: Padding(                                padding: const EdgeInsets.all(8.0),                                child: Column(                                    crossAxisAlignment:                                        CrossAxisAlignment.start,                                    children: <Widget>[                                      Padding(                                        padding: const EdgeInsets                                                .symmetric(                                            horizontal: 8.0),                                        child: Row(                                          mainAxisSize:                                              MainAxisSize.min,                                          children: <Widget>[                                             Text(                                                "Order No.  ${snapshot.data![index]["id"]}"),                                            const Spacer(),                                            Container(                                              margin: const EdgeInsets                                                  .only(left: 8),                                              padding:                                                  const EdgeInsets                                                          .symmetric(                                                      horizontal: 10,                                                      vertical: 2),                                              decoration: const BoxDecoration(                                                  color: black,                                                  borderRadius:                                                      BorderRadius.all(                                                          Radius.circular(                                                              4.0))),                                              child: Text(                                                snapshot.data[index]["status"].toString(),                                                style: const TextStyle(                                                    color: white),                                              ),                                            )                                          ],                                        ),                                      ),                                      Padding(                                        padding:                                            const EdgeInsets.only(                                          left: 8.0,                                          top: 8.0,                                        ),                                        child: Text(                                          snapshot.data![index]["items"][0]["lift"]["type"].toString(),                                          style: const TextStyle(                                              fontWeight: kW7,                                              fontSize: font_16),                                        ),                                      ),                                      const Divider(),                                      Padding(                                        padding: const EdgeInsets                                                .symmetric(                                            horizontal: 8.0,                                            vertical: 5),                                        child: Row(                                          children: [                                            Flexible(                                              child: Row(                                                children: const [                                                  Icon(Icons.timelapse,                                                      size: 20),                                                  Expanded(                                                    child: Text(                                                      "Ordered Date",                                                      maxLines: 1,                                                      overflow:                                                          TextOverflow                                                              .ellipsis,                                                    ),                                                  ),                                                ],                                              ),                                            ),                                            Text(                                              DateFormat(                                                      'dd MMM yyyy')                                                  .format(                                                DateTime.parse(snapshot.data![index]["ordered_date"].toString()),                                              ),                                              style: const TextStyle(                                                  color:                                                      darkFontColor,                                                  decoration:                                                      TextDecoration                                                          .underline),                                            ),                                          ],                                        ),                                      ),                                      // Padding(                                      //   padding: const EdgeInsets                                      //           .symmetric(                                      //       horizontal: 8.0,                                      //       vertical: 5),                                      //   child: Row(                                      //     children: [                                      //       Row(                                      //         children: const [                                      //           Icon(Icons.money,                                      //               size: 14),                                      //           Text(" Payable: "),                                      //         ],                                      //       ),                                      //       Spacer(),                                      //       Row(                                      //         children: const [                                      //           Icon(Icons.payment,                                      //               size: 14),                                      //           Text(                                      //               "Cash on Delivery"),                                      //         ],                                      //       ),                                      //     ],                                      //   ),                                      // ),                                      // Padding(                                      //   padding: const EdgeInsets                                      //           .symmetric(                                      //       horizontal: 8.0,                                      //       vertical: 5),                                      //   child: Row(                                      //     children: const [                                      //       Icon(Icons.date_range,                                      //           size: 14),                                      //       Text(" Order on: " +                                      //           "2022-09-11"),                                      //     ],                                      //   ),                                      // )                                    ])),                            onTap: () async {},                          ),                        ),                      );                    }): Text("No order Found"),          );        } else if (snapshot.hasError) {          return Center(child: Text("No order Found"));        } else {          return const Center(child: CircularProgressIndicator());        }      })),    );  }  void openFilterBottomSheet() {    showModalBottomSheet(        shape: const RoundedRectangleBorder(            borderRadius: BorderRadius.only(                topLeft: Radius.circular(40.0),                topRight: Radius.circular(40.0))),        isScrollControlled: true,        context: context,        backgroundColor: Colors.transparent,        builder: (BuildContext context) {          return StatefulBuilder(              builder: (BuildContext context, StateSetter setStater) {            return Wrap(              children: [                // bottomSheetHandle(context),                Container(                  decoration: const BoxDecoration(                    borderRadius: BorderRadius.only(                      topLeft: Radius.circular(40.0),                      topRight: Radius.circular(40.0),                    ),                    color: white,                  ),                  padding: EdgeInsets.only(                      bottom:                          MediaQuery.of(context).viewInsets.bottom),                  child: Column(                    mainAxisSize: MainAxisSize.min,                    children: [                      Padding(                        padding:                            EdgeInsets.only(bottom: 20, top: 20.0),                        child: Text(                          FILTER_BY,                          style: Theme.of(context)                              .textTheme                              .subtitle1!                              .copyWith(                                  fontWeight: FontWeight.bold,                                  color: darkFontColor,                                  fontSize: font_16),                        ),                      ),                      Flexible(                        child: SingleChildScrollView(                            padding: const EdgeInsets.only(top: 10.0),                            child: ListView.builder(                                physics: ScrollPhysics(),                                shrinkWrap: true,                                itemCount: statusList.length,                                itemBuilder: (context, int index) {                                  return Padding(                                    padding:                                        const EdgeInsetsDirectional                                                .only(                                            start: 20.0,                                            end: 20.0,                                            bottom: 15.0),                                    child: Container(                                      width: double.infinity,                                      decoration: BoxDecoration(                                        borderRadius:                                            BorderRadius.circular(                                                10.0),                                        color: cardBgColor,                                      ),                                      child: TextButton(                                          child: Text(                                              statusList[index],                                              style: Theme.of(context)                                                  .textTheme                                                  .subtitle1!                                                  .copyWith(                                                      color: darkFontColor                                                          .withOpacity(                                                              0.7))),                                          onPressed: () {}),                                    ),                                  );                                })),                      ),                    ],                  ),                ),              ],            );          });        });  }  Widget bottomSheetHandle(BuildContext context) {    return Container(      alignment: Alignment.center,      padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),      margin: const EdgeInsets.all(13),      child: InkWell(        child: Container(          height: 28,          width: 28,          decoration: BoxDecoration(              color: black,              border: Border.all(                color: black,              ),              borderRadius: BorderRadius.all(Radius.circular(20))),          child: Center(            child: const Icon(              Icons.close,              color: white,              size: 16,            ),          ),        ),        onTap: () {          Navigator.pop(context);        },      ),    );  }}