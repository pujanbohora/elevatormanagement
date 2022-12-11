import 'dart:convert';import 'package:shared_preferences/shared_preferences.dart';import '../../../api/api.dart';import '../../../api/endpoints.dart';import '../../../config/preference.config.dart';import 'package:http/http.dart' as http;class AdminUserRepository {  API api = API();  final SharedPreferences localStorage = PreferenceUtils.instance;  Future<List<dynamic>> getuserList() async {    var client = http.Client();    var issuseModel;    final SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${domain+Endpoints.userList}");    try {      var response = await client.get(        Uri.parse(domain + Endpoints.userList),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("STATUS CODE::::${response.statusCode}");      print("RESPONSE CODE::::${response.body}");      if (response.statusCode == 200) {        var jsonMap = jsonDecode(response.body);        print("RESPOSE :: " + response.body);        issuseModel = jsonMap;      }    } catch (e) {      print("CCRESPOSE ERR :: " + e.toString());      return issuseModel;    }    return issuseModel;  }  Future<List<dynamic>> getuserById(String id) async {    var client = http.Client();    var issuseModel;    final SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${domain+Endpoints.user}$id");    try {      var response = await client.get(        Uri.parse(domain + Endpoints.user),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("STATUS CODE::::${response.statusCode}");      print("RESPONSE CODE::::${response.body}");      if (response.statusCode == 200) {        var jsonMap = jsonDecode(response.body);        print("RESPOSE :: " + response.body);        issuseModel = jsonMap;      }    } catch (e) {      print("CCRESPOSE ERR :: " + e.toString());      return issuseModel;    }    return issuseModel;  }  Future<List<dynamic>> getStaffList() async {    var client = http.Client();    var issuseModel;    final SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${domain+Endpoints.staffList}");    try {      var response = await client.get(        Uri.parse(domain + Endpoints.staffList),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("STATUS CODE::::${response.statusCode}");      print("RESPONSE CODE::::${response.body}");      if (response.statusCode == 200) {        var jsonMap = jsonDecode(response.body);        print("RESPOSE :: " + response.body);        issuseModel = jsonMap;      }    } catch (e) {      print("CCRESPOSE ERR :: " + e.toString());      return issuseModel;    }    return issuseModel;  }  Future<dynamic> assignTechnician(String data, String id) async {    var client = http.Client();    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${"$domain${Endpoints.issue}$id/assign/"}");    print(data);    try {      var response = await client.post(          Uri.parse("$domain${Endpoints.issue}$id/assign/"),          headers: {            'Authorization': 'Bearer $token',            'Content-Type': 'application/json; charset=utf-8',          },          body: data      );      print("RESPOSE111 :: ${response.statusCode}");      if (response.statusCode == 200) {        print("RESPOSE22 :: ${response.body}");        return true;      }    } catch (e) {      print("RESPOSE ERR111 :: " + e.toString());      return false;    }  }}