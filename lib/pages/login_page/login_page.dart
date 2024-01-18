import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/login_page/logic/login.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool obscure = true;
  final _syndidController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _syndidController.dispose();
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
                width: 150,
                height: 150,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(AppAssets.icon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.numbers),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _syndidController,
                        decoration: const InputDecoration(
                          labelText: "Syndicate Id",
                          hintText: "######",
                          border: OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Enter Syndicate Id Number.";
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
              CheckboxListTile(
                title: const Text('Remember me'),
                value: rememberMe,
                onChanged: (v) {
                  setState(() {
                    rememberMe = v!;
                  });
                },
              ),
              const Gap(10),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    await shellFunction(context, toExecute: () async {
                      await loginLogic(
                        context: context,
                        synd_id: int.parse(_syndidController.text),
                        password: _passwordController.text,
                      );

                      if (rememberMe && mounted) {
                        await context.read<PxLocalDatabase>().saveDocIdToDb(
                              int.parse(_syndidController.text),
                              _passwordController.text,
                            );
                        if (mounted) {
                          GoRouter.of(context)
                              .goNamed(RoutePage.homePage().name);
                        }
                      }
                    });
                    //validate doctor exists
                    //validate password matches
                    //save doctor synd_id  & password in local storage if remember me
                  }
                },
              ),
              const Gap(10),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock_reset),
                label: const Text('Forgot Password'),
                onPressed: () async {
                  //TODO: synd id field is not empty
                  //TODO: validate doctor exists
                  //TODO: send generate doctor token request
                  //TODO: send token to doctor via mail
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
