import 'package:clean_code/modules/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          context.watch<UserBloc>().state is AuthenticatedState
              ? IconButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutEvent());
                  },
                  icon: const Icon(Icons.exit_to_app),
                )
              : const SizedBox()
        ],
      ),
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
                  TextField(
                    controller: username,
                    decoration: const InputDecoration(
                      hintText: "username",
                      prefixIcon: Icon(Icons.usb_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                                RegisterEvent(
                                  email: email.text,
                                  password: password.text,
                                  name: username.text,
                                ),
                              );
                        }
                      },
                      child: const Text("login"),
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    const TextSpan(
                      text: "already have an account ?",
                    ),
                    TextSpan(
                      text: " login",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
