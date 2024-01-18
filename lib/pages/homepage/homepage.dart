import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/page_ref/page_ref.dart';
import 'package:doctopia_doctors/pages/homepage/widgets/drag_account_notifier.dart';
import 'package:doctopia_doctors/pages/homepage/widgets/sidebar_btn.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final SidebarXController _xController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = SidebarXController(
      selectedIndex: 0,
      extended: false,
    );
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
    _xController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.doctopia),
        actions: [
          Consumer<PxDoctor>(
            builder: (context, d, c) {
              if (d.doctor.published) {
                return const SizedBox();
              } else {
                return d.isLoggedIn
                    ? FloatingActionButton.small(
                        heroTag: 'account-not-published',
                        tooltip: 'Account Not Published...',
                        onPressed: () {
                          //TODO: show info about missing attributes till sending publishing request.
                          //TODO: if info is complete, send publishing request
                        },
                        child: const Icon(
                          Icons.info,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox();
              }
            },
          ),
        ],
      ),
      drawer: Consumer2<PxDoctor, PxTheme>(
        builder: (context, d, t, c) {
          bool isDarkMode = t.mode == ThemeMode.dark;
          return SidebarX(
            animationDuration: const Duration(milliseconds: 300),
            controller: _xController,
            items: SidebarPageRef.pages(d.isLoggedIn).map((e) {
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
                      _xController
                          .selectIndex(SidebarPageRef.loggedInPages.indexOf(e));
                      if (_xController.extended) {
                        _xController.setExtended(false);
                      }
                    });
                    Scaffold.of(context).closeDrawer();
                  });
            }).toList(),
            headerBuilder: (context, extended) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Consumer3<PxDoctor, PxLocale, PxDocuments>(
                  builder: (context, d, l, docs, c) {
                    final isEnglish = l.locale.languageCode == 'en';
                    final isLoggedIn = d.isLoggedIn;

                    return Card(
                      child: extended
                          ? SizedBox(
                              width: 250,
                              height: 150,
                              child: GridTile(
                                footer: Text(
                                  isLoggedIn
                                      ? isEnglish
                                          ? "Dr. ${d.doctor.name_en.toUpperCase()}"
                                          : 'د / ${d.doctor.name_ar}'
                                      : "",
                                  textAlign: TextAlign.center,
                                ),
                                child: FutureBuilder(
                                  future: docs.doctorDocuments == null
                                      ? null
                                      : docs.documentsService.fetchImage(
                                          docs.doctorDocuments!.avatar),
                                  builder: (context, snapshot) {
                                    while (!snapshot.hasData ||
                                        snapshot.hasError) {
                                      return const CircleAvatar(
                                        radius: 35,
                                        child: Icon(
                                          FontAwesomeIcons.userDoctor,
                                          size: 50,
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          border: Border.all(),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: MemoryImage(snapshot.data!),
                                          ),
                                        ),
                                        // child: Image.memory(
                                        //   snapshot.data!,
                                        //   width: 150,
                                        //   height: 150,
                                        // ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const CircleAvatar(
                              radius: 35,
                              child: Icon(
                                FontAwesomeIcons.userDoctor,
                                size: 25,
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
            footerBuilder: (context, extended) {
              return Column(
                children: [
                  if (context.read<PxDoctor>().isLoggedIn)
                    SidebarXBtn(
                      isDarkMode: isDarkMode,
                      expanded: extended,
                      icon: const Icon(Icons.share),
                      labelOrTag: 'Share',
                      onPressed: () {},
                    ),
                  if (context.read<PxDoctor>().isLoggedIn)
                    SidebarXBtn(
                      isDarkMode: isDarkMode,
                      expanded: extended,
                      icon: const Icon(Icons.logout),
                      labelOrTag: 'Logout',
                      onPressed: () {
                        if (mounted) {
                          context.read<PxDoctor>().logout();
                          Scaffold.of(context).closeDrawer();
                        }
                      },
                    ),
                  SidebarXBtn(
                    isDarkMode: isDarkMode,
                    expanded: extended,
                    icon: const Icon(Icons.info),
                    labelOrTag: 'About',
                    onPressed: () {},
                  ),
                ],
              );
            },
            theme: isDarkMode
                ? AppTheme.sidebarXthemeRegularDark(context)
                : AppTheme.sidebarXthemeRegularLight(context),
            extendedTheme: isDarkMode
                ? AppTheme.sidebarXthemeExtendedDark(context)
                : AppTheme.sidebarXthemeExtendedLight(context),
            toggleButtonBuilder: (context, extended) {
              return FloatingActionButton.small(
                backgroundColor: isDarkMode ? Colors.grey : Colors.white,
                child: Icon(extended
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    _xController.setExtended(!extended);
                  });
                },
              );
            },
          );
        },
      ),
      body: Consumer<PxDoctor>(
        builder: (context, d, c) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                child: SidebarPageRef.pages(
                        d.isLoggedIn)[_xController.selectedIndex]
                    .page,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _animation,
                    child: child,
                  );
                },
              ),
              //* if no account detected:
              if (!d.isLoggedIn) const AccountStateNotifier(),
              //* if account detected but not complete / published
              // if (d.isLoggedIn && !d.doctor.published)
              //   const AccountPublishNotifier(),
            ],
          );
        },
      ),
      // floatingActionButton: const FloatingButtons(),
    );
  }
}
