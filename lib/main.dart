
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom/bloc/login_bloc.dart';
import 'package:youbloom/pages/login_page.dart';




void main()  {
  WidgetsFlutterBinding.ensureInitialized();
 
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
          )
      ], 
      child: MyApp(),
    ),
  );
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      title: 'Youbloom',
    );
  }
}