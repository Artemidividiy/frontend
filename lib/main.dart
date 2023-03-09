import 'package:colorful/constants/SupabaseConstants.dart';
import 'package:colorful/core/auth/views/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Colorful());
}

class Colorful extends StatelessWidget {
  const Colorful({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, primaryColor: Colors.black),
        home: SplashView());
  }
}
