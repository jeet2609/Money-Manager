import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/bloc/cubit/add_transaction_cubit.dart';
import 'package:money_manager/bloc/transaction_bloc.dart';
import 'package:money_manager/pages/splash_page.dart';
import 'package:money_manager/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialse data base
  await Hive.initFlutter();
  await Hive.openBox("money");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider<AddTransactionCubit>(
          create: (context) => AddTransactionCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Manager',
        theme: myTheme,
        home: const Splash(),
      ),
    );
  }
}
