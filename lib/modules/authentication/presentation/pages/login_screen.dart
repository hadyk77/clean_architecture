import 'package:clean_code/modules/authentication/presentation/bloc/user_bloc.dart';
import 'package:clean_code/modules/authentication/presentation/pages/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserBlocState>(listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message ?? "")));
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthenticatedState) {
          return Center(
            child: Text(state.user.name),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: "email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    controller: password,
                    decoration: const InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(LoginEvent(
                              email: email.text, password: password.text));
                        }
                      },
                      child: const Text("login"),
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    const TextSpan(
                      text: "don't have an account?",
                    ),
                    TextSpan(
                      text: " Sign Up",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                    )
                  ]))
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
