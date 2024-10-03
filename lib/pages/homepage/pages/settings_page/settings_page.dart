import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/user_preferences.dart';
import 'package:provider/provider.dart';

import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PxUserModel>(
      builder: (context, u, _) {
        bool isCheckboxTristate = u.model!.preferences == null;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.generalSettings),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.outlined(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(context.loc.language),
                    trailing: Consumer<PxLocale>(
                      builder: (context, l, c) {
                        return FloatingActionButton(
                          heroTag: 'language',
                          child:
                              Text(l.locale.languageCode == 'en' ? "AR" : "EN"),
                          onPressed: () async {
                            await l.changeLocale();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.outlined(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(context.loc.theme),
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
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.accountSettings),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    onPressed: () async {
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await u.requestPasswordReset(u.model!.email!);
                        },
                        sucessMsg: context.loc.linkSentToEmail,
                        duration: const Duration(seconds: 15),
                      );
                    },
                    icon: Icon(
                      Icons.password,
                      color: Theme.of(context).textTheme.headlineMedium?.color,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12,
                      ),
                      child: Text(
                        context.loc.changePassword,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.headlineMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.contractAndDocuments),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  onPressed: () async {
                    //todo: Create Contract if first time
                    //todo: open signature webapp
                    html.window.open(
                        'https://contracts-proklinik.pages.dev/#/contract/${u.id}',
                        '_blank');
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12,
                    ),
                    child: Text(
                      context.loc.signContract,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).textTheme.headlineMedium?.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  onPressed: () async {
                    html.window.open(
                        'https://contracts-proklinik.pages.dev/#/document/${u.id}',
                        '_blank');
                  },
                  icon: Icon(
                    Icons.file_copy,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12,
                    ),
                    child: Text(
                      context.loc.submitDocuments,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).textTheme.headlineMedium?.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.emailNotificationSettings),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.outlined(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    tristate: isCheckboxTristate,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.myBookings),
                    ),
                    value: u.model?.preferences?.mailBookings,
                    onChanged: (value) async {
                      late UserPreferences _prefs;
                      if (u.model!.preferences == null) {
                        _prefs = UserPreferences.initial().copyWith(
                          mailBookings: value,
                        );
                      } else {
                        _prefs = u.model!.preferences!.copyWith(
                          mailBookings: value,
                        );
                      }
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await u.updateUserModel({
                            'preferences': _prefs.toJson(),
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.outlined(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    tristate: isCheckboxTristate,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.invoices),
                    ),
                    value: u.model?.preferences?.mailInvoices,
                    onChanged: (value) async {
                      late UserPreferences _prefs;
                      if (u.model!.preferences == null) {
                        _prefs = UserPreferences.initial().copyWith(
                          mailInvoices: value,
                        );
                      } else {
                        _prefs = u.model!.preferences!.copyWith(
                          mailInvoices: value,
                        );
                      }
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await u.updateUserModel({
                            'preferences': _prefs.toJson(),
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.outlined(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    tristate: isCheckboxTristate,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.newsletter),
                    ),
                    value: u.model?.preferences?.mailNews,
                    onChanged: (value) async {
                      late UserPreferences _prefs;
                      if (u.model!.preferences == null) {
                        if (value != null) {
                          _prefs = UserPreferences.initial().copyWith(
                            mailNews: value,
                          );
                        }
                      } else {
                        if (value != null) {
                          _prefs = u.model!.preferences!.copyWith(
                            mailNews: value,
                          );
                        }
                      }
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await u.updateUserModel({
                            'preferences': _prefs.toJson(),
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${context.loc.version} - (0.0.1)',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
