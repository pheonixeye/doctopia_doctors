import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/pages/register_page_basic/widgets/degree_selector.dart';
import 'package:doctopia_doctors/pages/register_page_basic/widgets/speciality_selector.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPageBasic extends StatefulWidget {
  const RegisterPageBasic({super.key});

  @override
  State<RegisterPageBasic> createState() => _RegisterPageBasicState();
}

class _RegisterPageBasicState extends State<RegisterPageBasic> {
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
                    child: Text("#"),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
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
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              synd_id: int.parse(value),
                            );
                      },
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
                    child: Text('E'),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "English Name",
                        hintText: "A - B - C - D",
                        border: OutlineInputBorder(),
                        suffix: SizedBox(
                          height: 24,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              name_en: value.trim().toLowerCase(),
                            );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kindly Enter English Name.";
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
                    child: Text('A'),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Arabic Name",
                        hintText: "ا - ب - ت - ث",
                        border: OutlineInputBorder(),
                        suffix: SizedBox(
                          height: 24,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              name_ar: value.trim().toLowerCase(),
                            );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kindly Enter Arabic Name.";
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
                    child: Icon(Icons.phone),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Personal Phone",
                        hintText: "###-####-####",
                        border: OutlineInputBorder(),
                        suffix: SizedBox(
                          height: 24,
                        ),
                      ),
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              personal_phone: value.trim().toLowerCase(),
                            );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kindly Enter Personal Mobile Number.";
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
                    child: Icon(Icons.phone),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Assisstant Phone",
                        hintText: "###-####-####",
                        border: OutlineInputBorder(),
                        suffix: SizedBox(
                          height: 24,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              assistant_phone: value.trim().toLowerCase(),
                            );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kindly Enter Assisstant Mobile Number.";
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
                    child: Text("@"),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "abcd@xzy.com",
                        border: OutlineInputBorder(),
                        suffix: SizedBox(
                          height: 24,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        context.read<PxDoctor>().setDoctor(
                              email: value.trim().toLowerCase(),
                            );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kindly Enter Email Address.";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const SpecialitySelector(),
            const Gap(10),
            const DegreeSelector(),
            const Gap(10),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward_ios),
              label: const Text('Next'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  GoRouter.of(context)
                      .goNamed(RoutePage.registerPagePassword().name);
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
    );
  }
}
