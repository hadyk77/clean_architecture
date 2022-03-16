import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependency_injection.dart' as dendency_injector;
import 'modules/authentication/presentation/bloc/user_bloc.dart';
import 'modules/authentication/presentation/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dendency_injector.init();
  runApp(const CleanCode());
}

class CleanCode extends StatelessWidget {
  const CleanCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dendency_injector.dI<UserBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
