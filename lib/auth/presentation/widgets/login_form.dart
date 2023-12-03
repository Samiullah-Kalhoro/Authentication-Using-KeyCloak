import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {super.key,
      required TextEditingController usernameController,
      required TextEditingController passwordController});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            _userNameController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Project X',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/projectx.png',
                width: 200,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter a username'
                      : value.length < 3
                          ? 'Username must be at least 3 characters long'
                          : null,
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter a password'
                      : value.length < 3
                          ? 'Password must be at least 3 characters long'
                          : null,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  obscureText: true,
                  onEditingComplete: _login,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  if(context.read<AuthCubit>().state is AuthLoading)
                    const CircularProgressIndicator()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
