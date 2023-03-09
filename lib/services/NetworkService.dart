import 'dart:convert';

import 'package:colorful/models/ColorScheme.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:colorful/models/NetworkUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/FAConstants.dart' as faConst;
import 'package:http/http.dart' as http;

//TODO: я забыл переписать (это повторится)
class NetworkService {
  NetworkService();
  Future authenticateUser(
      String email, String password, bool authorized) async {
    if (LocalUser.instance == null) throw NullThrownError();
    var res = await http.post(
      Uri.parse("${faConst.BASE_URL}/user"),
      headers: {"content-type": "application/json"},
      body: LocalUser.instance!.toJson(authorized),
    );
    LocalUser.instance!.id = json.decode(res.body);
    return json.decode(res.body) != null;
  }

  Future getColorSchemasListFromNet() async {
    throw UnimplementedError();
  }

  Future saveColorSchemeToNetwork({required ColorScheme scheme}) async {
    throw UnimplementedError();
  }
}
