import 'dart:convert';import 'package:shared_preferences/shared_preferences.dart';import '../../../api/api.dart';import '../../../api/endpoints.dart';import '../../../config/preference.config.dart';import 'package:http/http.dart' as http;class IssuesRepository {  API api = API();  final SharedPreferences localStorage = PreferenceUtils.instance;  Future<List<dynamic>> getAllIssue() async {    var client = http.Client();    var issuseModel;    final SharedPreferences sharedPreferences =        await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${domain+Endpoints.issue}");    try {      var response = await client.get(        Uri.parse(domain + Endpoints.issue),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("STATUS CODE::::${response.statusCode}");      print("RESPONSE CODE::::${response.body}");      if (response.statusCode == 200) {        var jsonMap = jsonDecode(response.body);        print("RESPOSE :: " + response.body);        issuseModel = jsonMap;      }    } catch (e) {      print("CCRESPOSE ERR :: " + e.toString());      return issuseModel;    }    return issuseModel;  }  Future<List<dynamic>> getAllStaffIssue() async {    var client = http.Client();    var issuseModel;    final SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${domain+Endpoints.issue}");    try {      var response = await client.get(        Uri.parse(domain + Endpoints.issue),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("RESPOSE111 :: " + response.statusCode.toString());      if (response.statusCode == 200) {        print("RESPOSE22 :: " + response.body);        var jsonMap = jsonDecode(response.body);        issuseModel = jsonMap;      }    } catch (e) {      print("RESPOSE ERR111 :: " + e.toString());      return issuseModel;    }    return issuseModel;  }  Future<dynamic> getQRScanDetails(String id) async {    var client = http.Client();    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[GET:::]:::${domain}/issue/$id/start_progress/");    try {      var response = await client.get(        Uri.parse("${domain}/issue/$id/start_progress/"),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },      );      print("RESPOSE111 :: " + response.statusCode.toString());      if (response.statusCode == 200) {        print("RESPOSE22 :: " + response.body);        return true;      }    } catch (e) {      print("RESPOSE ERR111 :: " + e.toString());      return false;    }  }  Future<dynamic> addComment(String id,String data) async {    var client = http.Client();    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    String? token = sharedPreferences.getString("token");    print("[POST]:::${"$domain${Endpoints.issue}$id/add_comment/"}");    try {      var response = await client.post(        Uri.parse("$domain${Endpoints.issue}$id/add_comment/"),        headers: {          'Authorization': 'Bearer $token',          'Content-Type': 'application/json; charset=utf-8',        },        body: data      );      print("RESPOSE111 :: ${response.statusCode}");      if (response.statusCode == 200) {        print("RESPOSE22 :: ${response.body}");        return true;      }    } catch (e) {      print("RESPOSE ERR111 :: " + e.toString());      return false;    }  }}