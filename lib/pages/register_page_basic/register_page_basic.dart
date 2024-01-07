import 'package:flutter/widgets.dart';

class RegisterPageBasic extends StatefulWidget {
  const RegisterPageBasic({super.key});

  @override
  State<RegisterPageBasic> createState() => _RegisterPageBasicState();
}

class _RegisterPageBasicState extends State<RegisterPageBasic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('register_page_basic'),
      ),
    );
  }
}
