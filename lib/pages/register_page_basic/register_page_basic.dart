import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_models/models/user_model.dart';
import 'package:provider/provider.dart';

class RegisterPageBasic extends StatefulWidget {
  const RegisterPageBasic({super.key});

  @override
  State<RegisterPageBasic> createState() => _RegisterPageBasicState();
}

class _RegisterPageBasicState extends State<RegisterPageBasic> {
  final _formKey = GlobalKey<FormState>();
  final _syndIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _syndIdController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: _formKey,
          child: ListView(
            cacheExtent: 3000,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 30),
              Hero(
                tag: 'logo',
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(Assets.icon),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                context.loc.proklinik,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Text("#"),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _syndIdController,
                        decoration: InputDecoration(
                          labelText: context.loc.syndId,
                          hintText: "######",
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.loc.syndIdValidator;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Text('E'),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: context.loc.engName,
                          hintText: "A - B - C - D",
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.loc.engNameValidator;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: context.loc.personalPhone,
                          hintText: "###-####-####",
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 11) {
                            return context.loc.personalPhoneValidator;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Text("@"),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: context.loc.email,
                          hintText: "example@domain.com",
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              !EmailValidator.validate(value)) {
                            return context.loc.enterValidEmail;
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
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Text("S"),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(context.loc.selectServiceType),
                  subtitle: Card(
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null) {
                          return context.loc.selectServiceTypeValidator;
                        }
                        return null;
                      },
                      alignment: Alignment.center,
                      isExpanded: true,
                      hint: Text(context.loc.selectServiceTypeHint),
                      items: ["Clinic", "Laboratory", "Radiology", "Pharmacy"]
                          .map((e) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: e,
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      value: _service,
                      onChanged: (value) {
                        setState(() {
                          _service = value;
                        });
                      },
                    ),
                  ),
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
                          labelText: context.loc.password,
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
                            return context.loc.kindlyEnterPassword;
                          }
                          if (value.length < 8) {
                            return context.loc.passwordLengthValidator;
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
                          labelText: context.loc.confirmPassword,
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
                            return context.loc.confirmPasswordEnterValidator;
                          }
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return context.loc.confirmPasswordMatchValidator;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Consumer<PxUserModel>(
                builder: (context, u, _) {
                  return ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt),
                    label: Text(context.loc.register),
                    onPressed: () async {
                      //todo: validate form and create a new user account
                      if (_formKey.currentState!.validate()) {
                        late BuildContext _loadingContext;
                        if (_service != 'Clinic') {
                          //TODO: change later
                          ScaffoldMessenger.of(context).showSnackBar(
                            iInfoSnackbar(
                              context.loc.onlyClinicServices,
                              context,
                              Colors.red,
                            ),
                          );
                          return;
                        }
                        try {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                _loadingContext = context;
                                return const CentralLoading();
                              },
                            );
                          }
                          final UserModel _model = UserModel(
                            id: '',
                            username: _usernameController.text
                                .trim()
                                .toLowerCase()
                                .replaceAll(" ", ""),
                            password: _confirmPasswordController.text,
                            email: _emailController.text.toLowerCase(),
                            service: _service!.toLowerCase(),
                            phone: _phoneController.text,
                            synd_id: int.parse(_syndIdController.text),
                          );
                          await u.createUserAccount(_model);
                          // await EasyLoading.dismiss();
                          if (_loadingContext.mounted) {
                            Navigator.pop(_loadingContext);
                          }
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  context.loc.success,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                            GoRouter.of(context).goNamed(AppRouter.login);
                          }
                        } catch (e) {
                          if (_loadingContext.mounted) {
                            Navigator.pop(_loadingContext);
                          }
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                      }
                    },
                  );
                },
              ),
              const Gap(20),
              Text.rich(
                TextSpan(
                  text: context.loc.alreadyRegistered,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          GoRouter.of(context).goNamed(AppRouter.login);
                        },
                      text: context.loc.login,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).appBarTheme.backgroundColor,
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
