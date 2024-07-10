import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TokenValidationPage extends StatefulWidget {
  const TokenValidationPage({super.key});

  @override
  State<TokenValidationPage> createState() => _TokenValidationPageState();
}

class _TokenValidationPageState extends State<TokenValidationPage> {
  final _formKey = GlobalKey<FormState>();

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
                  child: Image.asset(Assets.icon),
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
                        decoration: const InputDecoration(
                          labelText: "Password Reset Token...",
                          hintText: "****-****-****",
                          border: OutlineInputBorder(),
                          suffix: SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
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
              const Gap(10),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Validate'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //TODO: check token entered against doctor id
                    //TODO: navigate to password reset page
                    GoRouter.of(context).goNamed(
                      RoutePage.forgotPassword(
                        isRegister: false,
                      ).name,
                    );
                  }
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
