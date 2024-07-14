import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doctopia_doctors/pages/homepage/pages/news_feed_page/widgets/article_card.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_nav.dart';
import 'package:doctopia_doctors/providers/px_scrapper.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  //todo: build UI && Logic
  @override
  Widget build(BuildContext context) {
    return Consumer4<PxUserModel, PxDoctor, PxScrapper, PxNav>(
      builder: (context, u, d, s, n, _) {
        while (d.doctor == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 18,
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
                        ColorizeAnimatedText(
                          'Complete Your Profile To Get A Customized News Feed Of Medical Articles.',
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.white,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          colors: [
                            Colors.green,
                            Colors.white,
                            Colors.orange,
                            Colors.purple,
                            Colors.black,
                          ],
                        ),
                      ],
                      onTap: () {
                        n.navToIndex(2);
                        GoRouter.of(context).goNamed(
                          AppRouter.profile,
                          pathParameters: {"id": u.id!},
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        while (s.pageResults == null) {
          return Center(
            child: SpinKitHourGlass(
              color: Theme.of(context).appBarTheme.backgroundColor!,
            ),
          );
        }
        return ListView(
          children: [
            const ListTile(
              leading: CircleAvatar(),
              title: Text("Latest From Medscape"),
            ),
            ...s.pageResults!.map((e) => ArticleCard(item: e)).toList(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      final _page = s.page <= 1 ? s.page : s.page - 1;
                      GoRouter.of(context).goNamed(
                        AppRouter.home,
                        pathParameters: {"id": u.id!},
                        queryParameters: {"page": "$_page"},
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text("${s.page}"),
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      GoRouter.of(context).goNamed(
                        AppRouter.home,
                        pathParameters: {"id": u.id!},
                        queryParameters: {"page": "${s.page + 1}"},
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
