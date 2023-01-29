import 'package:colorful/models/ColorScheme.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:colorful/models/NetworkUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//TODO: Переписать с хуйни в лютой альфе на нормальную версию
class NetworkService {
  late GoTrueClient authRes;
  Session? session;

  NetworkService() {
    init();
  }
  void init() async {
    authRes = await Supabase.instance.client.auth;
  }

  Future getUserFromNetwork() async {
    throw UnimplementedError();
  }

  Future saveUserToNetwork() async {
    var tmp = await authRes.signUp(
        email: LocalUser.instance!.email,
        password: LocalUser.instance!.password);
    session = tmp.session;
    NetworkUser user = tmp.user;
  }

  Future getColorSchemasListFromNet() async {
    throw UnimplementedError();
  }

  Future saveColorSchemeToNetwork({required ColorScheme scheme}) async {
    throw UnimplementedError();
  }
}
