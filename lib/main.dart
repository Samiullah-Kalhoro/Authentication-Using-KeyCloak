import 'package:auth_keycloak/auth/logic/cubit/auth_cubit.dart';
import 'package:auth_keycloak/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/presentation/screens/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: darkColorScheme
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme
        ),
        home: const AuthScreen(),
      ),
    );
  }
}
