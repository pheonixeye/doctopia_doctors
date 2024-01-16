import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/functions/password_hash_fns.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPagePassword extends StatefulWidget {
  const RegisterPagePassword({
    super.key,
    this.isRegister = true,
  });
  final bool isRegister;

  @override
  State<RegisterPagePassword> createState() => _RegisterPagePasswordState();
}

class _RegisterPagePasswordState extends State<RegisterPagePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              Hero(
                tag: 'logo',
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(AppAssets.icon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Text('P'),
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
                                  isPasswordObscure = !isPasswordObscure;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: isPasswordObscure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Enter Password.";
                          }
                          if (value.length < 8) {
                            return "Minimum Required Length is 8 Characters.";
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
                      child: Text('P'),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "********",
                          border: const OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 32,
                            child: FloatingActionButton.small(
                              heroTag: 'obscure--confirm-password',
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordObscure =
                                      !isConfirmPasswordObscure;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: isConfirmPasswordObscure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Confirm Password.";
                          }
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return "Password Not Matching.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final sp = generatePasswordHash(_passwordController.text);
                    if (mounted) {
                      context.read<PxDoctor>().setDoctor(
                            password: sp.password,
                            salt: sp.salt,
                          );
                    }
                    await shellFunction(context, toExecute: () async {
                      if (mounted) {
                        widget.isRegister
                            ? await context.read<PxDoctor>().createDoctor()
                            : await context.read<PxDoctor>().updateDoctor();
                      }
                      if (mounted) {
                        GoRouter.of(context)
                            .goNamed(RoutePage.loginPage().name);
                      }
                    });
                  }
                },
              ),
              const Gap(10),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back_ios),
                label: const Text('Back'),
                onPressed: () async {
                  GoRouter.of(context).pop();
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
