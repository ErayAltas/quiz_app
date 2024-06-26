import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:quiz_app/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/presentation/auth/sign_in/sign_in.dart';
import 'package:quiz_app/presentation/dashboard/dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App"), backgroundColor: Colors.green),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(state.currentUser)));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: "Full Name",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.isEmpty ? "Enter your name" : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(hintText: "Email", border: OutlineInputBorder()),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && !EmailValidator.validate(value) ? 'Enter a valid email' : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(hintText: "Password", border: OutlineInputBorder()),
                                obscureText: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6 ? "Enter min. 6 characters" : null;
                                },
                              ),
                              const SizedBox(height: 40),
                              SignInButtonBuilder(
                                icon: Icons.login,
                                text: "Sign up",
                                onPressed: () {
                                  _createAccountWithEmailAndPassword(context);
                                },
                                backgroundColor: Colors.green,
                                width: 100,
                                height: 43,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text("or", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      SignInButtonBuilder(
                        text: 'Already have an account?',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignIn()),
                          );
                        },
                        backgroundColor: Colors.blueGrey[700]!,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }
}
