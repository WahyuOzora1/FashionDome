import 'package:fashiondome/bloc/login/login_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/data/models/request/login_request_model.dart';
import 'package:fashiondome/presentation/auth/signup_page.dart';
import 'package:fashiondome/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(),
            child: Form(
              key: _signInFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: const Duration(seconds: 1),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: const Duration(milliseconds: 1800),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          143, 148, 251, 1)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.email_outlined),
                                          border: InputBorder.none,
                                          hintText: "Masukkan email Anda",
                                          hintStyle:
                                              TextStyle(color: Colors.black45)),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          icon:
                                              Icon(Icons.lock_outline_rounded),
                                          border: InputBorder.none,
                                          hintText: "Masukkan password Anda",
                                          hintStyle:
                                              TextStyle(color: Colors.black45)),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) async {
                              if (state is LoginError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Gagal login, cek data Anda!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              if (state is LoginLoaded) {
                                await AuthLocalDatasource()
                                    .saveAuthData(state.model);
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomePage();
                                      },
                                    ),
                                  );
                                }
                              }
                            }, builder: (context, state) {
                              if (state is LoginLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: GlobalVariables.primaryColor,
                                  ),
                                );
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      final requestModel = LoginRequestModel(
                                        password: _passwordController.text,
                                        identifier: _emailController.text,
                                      );

                                      context.read<LoginBloc>().add(
                                          DoLoginEvent(model: requestModel));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: GlobalVariables.primaryColor),
                                    child: const Center(
                                      child: Text(
                                        "Masuk",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Belum mempunyai akun?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SignUpPage()));
                                    },
                                    child: const Text(
                                      "Daftar",
                                      style: TextStyle(
                                          color: GlobalVariables.primaryColor),
                                    ))
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalVariables.primaryColor),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              },
                              child: const Text(
                                'Continue as a Guest',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
