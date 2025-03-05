import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/core/common/snackbar/my_snackbar.dart';
import 'package:gear_rental/features/auth/presentation/view/register_view.dart';

import '../view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Login To Your Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA8CD00),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginUserEvent(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          } else {
                            showMySnackBar(
                              context: context,
                              message: 'Invalid email or password',
                              color: Colors.red,
                            );
                          }
                          // }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do Not Have An Account?'),
                    TextButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              NavigateRegisterScreenEvent(
                                destination: RegisterView(),
                                context: context,
                              ),
                            );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFFA8CD00)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
