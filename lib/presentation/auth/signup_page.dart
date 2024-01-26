import 'package:fashiondome/bloc/register/register_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/data/models/request/register_request_model.dart';
import 'package:fashiondome/presentation/auth/login_page.dart';
import 'package:fashiondome/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(),
            child: Form(
              key: _signUpFormKey,
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
                                    "SignUp",
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
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.person_2_outlined),
                                          border: InputBorder.none,
                                          hintText: "Masukkan username Anda",
                                          hintStyle:
                                              TextStyle(color: Colors.black45)),
                                    ),
                                  ),
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
                            child: BlocConsumer<RegisterBloc, RegisterState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  error: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Gagal mendaftar, coba lagi!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  loaded: (model) async {
                                    await AuthLocalDatasource()
                                        .saveAuthData(model);
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
                                  },
                                );
                              },
                              builder: (context, state) {
                                return state.maybeWhen(orElse: () {
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (_signUpFormKey.currentState!
                                          .validate()) {
                                        final requestModel =
                                            RegisterRequestModel(
                                          name: _usernameController.text,
                                          password: _passwordController.text,
                                          email: _emailController.text,
                                          username: _usernameController.text,
                                        );

                                        context.read<RegisterBloc>().add(
                                            RegisterEvent.register(
                                                requestModel));
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: GlobalVariables.primaryColor),
                                      child: const Center(
                                        child: Text(
                                          "Daftar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  );
                                }, loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: GlobalVariables.primaryColor,
                                    ),
                                  );
                                });
                              },
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sudah mempunyai akun?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const LoginPage()));
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: GlobalVariables.primaryColor),
                                    ))
                              ],
                            )),
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
