import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: CircleAvatar(),
          title: Text('Settings'),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Language'),
              trailing: Consumer<PxLocale>(
                builder: (context, l, c) {
                  return FloatingActionButton(
                    heroTag: 'language',
                    child: Text(l.locale.languageCode == 'en' ? "AR" : "EN"),
                    onPressed: () async {
                      await l.changeLocale();
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Theme'),
              trailing: FloatingActionButton(
                heroTag: 'theme',
                child: const Icon(Icons.theater_comedy),
                onPressed: () {
                  context.read<PxTheme>().changeThemeMode();
                },
              ),
            ),
          ),
        ),
        Consumer<PxDoctor>(
          builder: (context, d, c) {
            if (d.isLoggedIn) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      //TODO: change password logic
                    },
                    icon: const Icon(Icons.password),
                    label: const Text('Change Password'),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
