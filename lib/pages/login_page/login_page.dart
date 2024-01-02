import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/pages/widgets/floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      decoration: const InputDecoration(
                        labelText: "Syndicate Id",
                        hintText: "######",
                        border: OutlineInputBorder(),
                      ),
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
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "******",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
            CheckboxListTile(
              title: const Text('Remember me'),
              value: false,
              onChanged: (v) {},
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Register'),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingButtons(),
    );
  }
}
