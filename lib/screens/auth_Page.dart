import 'package:flutter/material.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  final supabase = Supabase.instance.client;
  User? user;

  Future<void> _getAuth() async {
    setState(() {
      user = supabase.auth.currentUser;
    });
    supabase.auth.onAuthStateChange.listen((event) {
      setState(() {
        user = event.session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null ?  StartPage() : const HomePage();
  }
}
