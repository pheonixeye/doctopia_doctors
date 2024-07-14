import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/page_ref/page_ref.dart';
import 'package:doctopia_doctors/pages/homepage/widgets/floating_buttons_by_index.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
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
            title: const Text("ProKliniK"),
            actions: [
              Consumer2<PxUserModel, PxDoctor>(
                builder: (context, u, d, _) {
                  if (d.doctor == null) {
                    return SizedBox(
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
                            FlickerAnimatedText('Complete Your Profile.'),
                          ],
                          onTap: () {
                            n.navToIndex(2); //doctor profile
                            GoRouter.of(context).goNamed(
                              AppRouter.profile,
                              pathParameters: {"id": u.id!},
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Consumer<PxUserModel>(
                builder: (context, u, _) {
                  return FloatingActionButton.small(
                    heroTag: 'logout-btn',
                    tooltip: "Logout",
                    child: const Icon(Icons.logout),
                    onPressed: () {
                      n.navToIndex(0);
                      if (context.mounted) {
                        u.logout();
                        Scaffold.of(context).closeDrawer();
                        GoRouter.of(context).goNamed(AppRouter.login);
                      }
                    },
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          drawer: Consumer2<PxUserModel, PxTheme>(
            builder: (context, u, t, c) {
              bool isDarkMode = t.mode == ThemeMode.dark;
              return SidebarX(
                animationDuration: const Duration(milliseconds: 300),
                controller: n.controller,
                items: loggedInPages.map((e) {
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
                        n.navToIndex(loggedInPages.indexOf(e));
                        if (n.controller.extended) {
                          n.collapse();
                        }
                        Scaffold.of(context).closeDrawer();
                        GoRouter.of(context).goNamed(
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
                                    "Unknown Error.",
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
                                                    //http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME?thumb=100x300
                                                    image: NetworkImage(
                                                        "${PocketbaseHelper.pb.baseUrl}/api/files/doctors/${d.doctor?.id}/${d.doctor?.avatar}?thumb=200x200"),
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
                                              : d.doctor!.name_en,
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
          floatingActionButton: FloatingButtonsByIndex(
            id: context.read<PxUserModel>().id!,
            index: n.index,
          ),
        );
      },
    );
  }
}
