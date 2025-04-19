import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/constants/static_app_constants.dart';
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

  late final PxReviews _r;
  @override
  void initState() {
    _r = context.read<PxReviews>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollNotificationListener);
    super.initState();
  }

  Future<void> _scrollNotificationListener() async {
    final _toCall = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    if (_toCall) {
      if (_r.isLoading) {
        return;
      }
      await _r.fetchMoreReviews();
    }
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
          title: Text(context.loc.reviews),
          subtitle: const Divider(),
        ),
        Expanded(
          child: Consumer<PxReviews>(
            builder: (context, r, _) {
              while (r.reviews == null) {
                return const Padding(
                  padding: EdgeInsets.only(
                    top: StaticAppConstants.midComponentTopPadding,
                  ),
                  child: CentralLoading(),
                );
              }
              while (r.reviews != null && r.reviews!.isEmpty) {
                return Center(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.noReviewsYet),
                    ),
                  ),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount:
                    r.isLoading ? r.reviews!.length + 1 : r.reviews?.length,
                itemBuilder: (context, index) {
                  if (index < r.reviews!.length) {
                    final item = r.reviews![index];
                    return ReviewCard(
                      review: item,
                      index: index,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
