import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final _u = context.read<PxUserModel>();
    if (_u.isLoggedIn) {
      GoRouter.of(context).goNamed(
        AppRouter.home,
        pathParameters: {
          "id": _u.id!,
        },
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  bool rememberMe = false;
  bool obscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(Assets.icon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Text("@"),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        key: _emailFieldKey,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "example@domain.com",
                          border: OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              !EmailValidator.validate(value)) {
                            return "Kindly Enter a Valid Email Address.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.password),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "********",
                          border: const OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 32,
                            child: FloatingActionButton.small(
                              heroTag: 'obscure-password',
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: obscure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Enter Password.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CheckboxListTile(
              //     title: const Text('Remember me'),
              //     value: rememberMe,
              //     onChanged: (v) {
              //       setState(() {
              //         rememberMe = v!;
              //       });
              //     },
              //   ),
              // ),
              const Gap(10),
              Consumer<PxUserModel>(
                builder: (context, u, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await EasyLoading.show(status: "Loading...");
                            final _id = await u.loginUserByEmailAndPassword(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                            await EasyLoading.showSuccess("Success...");
                            if (context.mounted) {
                              GoRouter.of(context).goNamed(
                                AppRouter.home,
                                pathParameters: {"id": _id},
                                queryParameters: {"page": "1"},
                              );
                            }
                          } catch (e) {
                            await EasyLoading.dismiss();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 10),
                                  content: Text(e.toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  );
                },
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4.0,
                ),
                child: Consumer<PxUserModel>(
                  builder: (context, u, _) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.lock_reset),
                      label: const Text('Forgot Password'),
                      onPressed: () async {
                        //todo: email field is not empty
                        if (_emailFieldKey.currentState != null &&
                            _emailFieldKey.currentState!.validate()) {
                          await shellFunction(context, toExecute: () async {
                            //todo: validate doctor exists => done automatically
                            //todo: send token to doctor via mail
                            await u.requestPasswordReset(
                                _emailController.text.trim());
                            if (context.mounted) {
                              GoRouter.of(context)
                                  .goNamed(AppRouter.tokenvalidation);
                            }
                          });
                        }
                        //deferred / no need: send generate doctor token request
                      },
                    );
                  },
                ),
              ),
              const Gap(20),
              Text.rich(
                TextSpan(
                  text: "Not Registered Yet ?  ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          GoRouter.of(context).goNamed(AppRouter.register);
                        },
                      text: "Create An Account.",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
