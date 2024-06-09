import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/auth/auth_bloc.dart';
import 'package:housr_booking_app/screen/home_page.dart';
import 'package:housr_booking_app/screen/sign_in_screen.dart';
import 'package:housr_booking_app/util/custom_theme.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('HOUSR')),
          automaticallyImplyLeading: false,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              _showErrorDialog(context, state.message);
            } else if (state is AuthSignedIn) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome ${state.name}')));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        'Please Sign Up Here',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Enter Your Name',
                          hintText: 'John Doe',
                          hintStyle: CustomTheme.of(context).bodySmall.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).accent1,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color(0xffE5E5E5),
                          contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Enter Your Email',
                          hintText: 'example@gmail.com',
                          hintStyle: CustomTheme.of(context).bodySmall.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).accent1,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color(0xffE5E5E5),
                          contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Enter Your Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xffE5E5E5),
                          contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = nameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (!_validateFields(
                              context, name, email, password)) {
                            return;
                          }

                          BlocProvider.of<AuthBloc>(context)
                              .add(SignUpEvent(name, email, password));
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                        child: const Text('Go To Sign In'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _validateFields(
      BuildContext context, String name, String email, String password) {
    if (name.isEmpty) {
      _showErrorDialog(context, 'Please enter your name.');
      return false;
    }
    if (email.isEmpty) {
      _showErrorDialog(context, 'Please enter your email.');
      return false;
    }
    if (!_isEmailValid(email)) {
      _showErrorDialog(context, 'Please enter a valid email address.');
      return false;
    }
    if (password.isEmpty) {
      _showErrorDialog(context, 'Please enter a password.');
      return false;
    }
    if (password.length < 4) {
      _showErrorDialog(context, 'Password must be at least 4 characters long.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
