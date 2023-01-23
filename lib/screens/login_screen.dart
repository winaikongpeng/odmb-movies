import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';
import 'package:tbc_test/core/widgets/common_widget.dart';
import '../bloc/login_bloc.dart';
import 'home_page_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CommonWidget.textFormfieldStandard(
                  label: 'Email',
                  controller: emailController,
                  validator: ((value) {
                    value ??= '';
                    if (value.isEmpty) return 'Plaese enter your email';
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) return 'Invalid of email.';
                    return null;
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CommonWidget.textFormfieldUseSuffix(
                    label: 'Password',
                    controller: passwordController,
                    validator: ((value) {
                      value ??= '';
                      if (value.isEmpty) return 'Plaese enter your password';
                      return null;
                    }),
                    showPassword: showPassword,
                    onTapIcon: () {
                      setState(() => showPassword = !showPassword);
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //
            Center(
              child: CommonWidget.standardButton(
                  context: context,
                  title: 'Login',
                  onPressed: () {
                    if (!(key.currentState?.validate() ?? false)) {
                      return;
                    } else {
                      context.read<LoginBloc>().add(GetAuthEvent(
                          email: emailController.text,
                          password: passwordController.text));
                    }
                  }),
            ),
            const SizedBox(
              height: 40,
            ),

            BlocBuilder<LoginBloc, MainState>(builder: (context, state) {
              if (state is StateLoading) {
                return CommonWidget.loading();
              } else if (state is GetAuthStateSuccess) {
                return Text(
                  state.success,
                  style: const TextStyle(color: Colors.green),
                );
              } else if (state is StateError) {
                return CommonWidget.textError(
                    ctx: context, message: state.toString());
              }
              return const SizedBox();
            }, buildWhen: ((previous, current) {
              if (current is GetAuthStateSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const HomePage()),
                  ),
                );
              }
              return true;
            })),
          ],
        ),
      ),
    );
  }
}
