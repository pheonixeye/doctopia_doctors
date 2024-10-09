import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/reviews_page/widgets/review_card.dart';
import 'package:doctopia_doctors/providers/px_reviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: Text(context.loc.reviews),
        ),
        Expanded(
          child: Consumer<PxReviews>(
            builder: (context, r, _) {
              while (r.reviews.isEmpty) {
                return Center(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.noReviewsYet),
                    ),
                  ),
                );
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: r.reviews.length,
                    itemBuilder: (context, index) {
                      final item = r.reviews[index];
                      return ReviewCard(
                        review: item,
                        index: index,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
