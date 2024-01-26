import 'package:fashiondome/bloc/checkout/checkout_bloc.dart';
import 'package:fashiondome/bloc/get_products/get_products_bloc.dart';
import 'package:fashiondome/bloc/list_order/list_order_bloc.dart';
import 'package:fashiondome/bloc/login/login_bloc.dart';
import 'package:fashiondome/bloc/order/order_bloc.dart';
import 'package:fashiondome/bloc/register/register_bloc.dart';
import 'package:fashiondome/bloc/search/search_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/data/datasource/auth_remote_datasource.dart';
import 'package:fashiondome/data/datasource/order_remote_datasource.dart';
import 'package:fashiondome/data/datasource/product_remote_datasource.dart';
import 'package:fashiondome/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ListOrderBloc(OrderRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: GlobalVariables.primaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
