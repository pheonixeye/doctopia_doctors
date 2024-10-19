import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/components/prompt_dialog.dart';
import 'package:doctopia_doctors/extensions/avatar_url_doctor_ext.dart';
import 'package:doctopia_doctors/extensions/is_mobile_ext.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/components/page_ref.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/widgets/feedback_btm_sheet.dart';
import 'package:doctopia_doctors/pages/homepage/widgets/sharable_dialog.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_nav.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:doctopia_doctors/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.child});
  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 2),
    );
    _animation = Animation.fromValueListenable(_animationController);
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxNav>(
      builder: (context, n, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.loc.proklinik),
            actions: [
              Consumer2<PxUserModel, PxDoctor>(
                builder: (context, u, d, _) {
                  return Row(
                    children: [
                      if (d.doctor == null)
                        SizedBox(
                          width: 150.0,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              // fontSize: 35,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: Colors.white,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FlickerAnimatedText(
                                    context.loc.completeYourProfile),
                              ],
                              onTap: () {
                                n.navToIndex(2); //doctor profile
                                context.goNamed(
                                  AppRouter.profile,
                                  pathParameters: {"id": u.id!},
                                );
                              },
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 20,
                      ),
                      PopupMenuButton<Object>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        position: PopupMenuPosition.under,
                        shadowColor: Colors.green,
                        offset: const Offset(0, 20),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Text(context.loc.share),
                                  const Spacer(),
                                  const Icon(Icons.share)
                                ],
                              ),
                              onTap: () async {
                                //todo: design sharable dialog
                                //940 x 788 px
                                await showDialog(
                                  context: context,
                                  builder: (context) => SharableDialog(
                                    doctor: d.doctor!,
                                    relativeFactor:
                                        (context.isMobile ? (2 / 3) : 1),
                                  ),
                                );
                              },
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Text(context.loc.logout),
                                  const Spacer(),
                                  const Icon(Icons.logout)
                                ],
                              ),
                              onTap: () async {
                                //todo: add confirmation dialog
                                final toLogOut = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => MainPromptDialog(
                                    title: context.loc.confirmLogout,
                                    body: context.loc.confirmLogoutMessage,
                                  ),
                                );
                                if (toLogOut == true) {
                                  n.navToIndex(0);
                                  if (context.mounted) {
                                    u.logout();
                                    Scaffold.of(context).closeDrawer();
                                    context.goNamed(AppRouter.login);
                                  }
                                } else {
                                  return;
                                }
                              },
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              child: const Row(
                                children: [
                                  Text('feedback'),
                                  Spacer(),
                                  Icon(Icons.feedback)
                                ],
                              ),
                              onTap: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const FeedbackBottomSheet();
                                  },
                                );
                              },
                            ),
                          ];
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  );
                },
              ),
            ],
          ),
          drawer: Consumer3<PxUserModel, PxTheme, PxLocale>(
            builder: (context, u, t, l, _) {
              bool isDarkMode = t.mode == ThemeMode.dark;
              final _pages = SidebarPageRef.homePages(context);
              return SidebarX(
                animationDuration: const Duration(milliseconds: 300),
                controller: n.controller,
                items: _pages.map((e) {
                  return SidebarXItem(
                      label: e.name,
                      icon: e.icon,
                      onTap: () {
                        setState(() {
                          if (!_animationController.isCompleted) {
                            _animationController.forward();
                          } else {
                            _animationController.reset();
                            _animationController.forward();
                          }
                        });
                        n.navToIndex(_pages.indexOf(e));
                        if (n.controller.extended) {
                          n.collapse();
                        }
                        Scaffold.of(context).closeDrawer();
                        context.goNamed(
                          e.path,
                          pathParameters: {"id": u.id!},
                        );
                      });
                }).toList(),
                headerBuilder: (context, extended) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Consumer2<PxUserModel, PxDoctor>(
                      builder: (context, u, d, _) {
                        return InkWell(
                          onTap: () async {
                            FilePickerResult? _image;
                            try {
                              _image = await FilePicker.platform.pickFiles(
                                dialogTitle: "Select Avatar",
                                allowMultiple: false,
                                type: FileType.image,
                                withData: true,
                              );
                              if (_image != null && context.mounted) {
                                if (kDebugMode) {
                                  print(_image.names);
                                }
                                await shellFunction(context,
                                    toExecute: () async {
                                  await d.updateDoctorAvatar(
                                    fileBytes: _image!.files.first.bytes!,
                                    fileName: "${d.id}_${_image.names[0]}",
                                  );
                                });
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  iInfoSnackbar(
                                    context.loc.unknownError,
                                    context,
                                    Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Card(
                            child: extended
                                ? SizedBox(
                                    width: 250,
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(height: 10),
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              while (d.doctor!.avatar == null) {
                                                return const CircleAvatar(
                                                  radius: 35,
                                                  child: Icon(
                                                    FontAwesomeIcons.userDoctor,
                                                    size: 50,
                                                  ),
                                                );
                                              }
                                              return Container(
                                                width: 200,
                                                height: 200,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      d.doctor!.avatarUrl!,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          d.doctor == null
                                              ? ""
                                              : l.isEnglish
                                                  ? d.doctor!.name_en
                                                  : d.doctor!.name_ar,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 35,
                                    child: Icon(
                                      FontAwesomeIcons.userDoctor,
                                      size: 25,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  );
                },
                headerDivider: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 5,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                theme: isDarkMode
                    ? AppTheme.sidebarXthemeRegularDark(context)
                    : AppTheme.sidebarXthemeRegularLight(context),
                extendedTheme: isDarkMode
                    ? AppTheme.sidebarXthemeExtendedDark(context)
                    : AppTheme.sidebarXthemeExtendedLight(context),
                toggleButtonBuilder: (context, extended) {
                  return FloatingActionButton.small(
                    child: Icon(extended
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    onPressed: () {
                      n.expandCollapse();
                    },
                  );
                },
              );
            },
          ),
          body: AnimatedBuilder(
            animation: _animationController,
            child: widget.child,
            builder: (context, child) {
              return FadeTransition(
                opacity: _animation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
