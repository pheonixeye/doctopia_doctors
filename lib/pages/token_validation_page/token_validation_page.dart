import 'package:doctopia_doctors/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TokenValidationPage extends StatefulWidget {
  const TokenValidationPage({super.key});

  @override
  State<TokenValidationPage> createState() => _TokenValidationPageState();
}

class _TokenValidationPageState extends State<TokenValidationPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _tokenController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  @override
  void initState() {
    _tokenController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool obscurePass = true;
  bool obscureConfirm = true;

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
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                height: 100,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(Assets.icon),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "ProKliniK",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Kindly Enter The Password Reset Token Sent To Your Email Address.",
                        textAlign: TextAlign.center,
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
                      child: Text('T'),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _tokenController,
                        decoration: const InputDecoration(
                          labelText: "Password Reset Token...",
                          hintText: "****-****-****",
                          border: OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Enter Password Reset Token";
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "New Password...",
                          hintText: "****-****-****",
                          border: const OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 32,
                            child: FloatingActionButton.small(
                              heroTag: 'obscure-password',
                              onPressed: () {
                                setState(() {
                                  obscurePass = !obscurePass;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: obscurePass,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Enter Password.";
                          }
                          if (value.length < 8) {
                            return "Password Length Should be atleast 8 Characters.";
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
                        controller: _confirmController,
                        decoration: InputDecoration(
                          labelText: "Confirm New Password...",
                          hintText: "****-****-****",
                          border: const OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 32,
                            child: FloatingActionButton.small(
                              heroTag: 'obscure-confirm',
                              onPressed: () {
                                setState(() {
                                  obscureConfirm = !obscureConfirm;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        ),
                        obscureText: obscureConfirm,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kindly Confirm New Password.";
                          }
                          if (value != _passwordController.text) {
                            return "Passwords Not Matching.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm'),
                  onPressed: () async {
                    // if (_formKey.currentState!.validate() && context.mounted) {
                    //   await shellFunction(context, toExecute: () async {
                    //     await context.read<PxUserModel>().confirmResetPassword(
                    //           token: _tokenController.text,
                    //           password: _passwordController.text,
                    //           confirm: _confirmController.text,
                    //         );
                    //     if (context.mounted) {
                    //       GoRouter.of(context).goNamed(
                    //         AppRouter.login,
                    //       );
                    //     }
                    //   });
                    // }
                  },
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
