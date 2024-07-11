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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: CircleAvatar(),
          title: Text('My Reviews'),
        ),
        Expanded(
          child: Consumer<PxReviews>(
            builder: (context, r, _) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: r.reviews.length,
                    itemBuilder: (context, index) {
                      final item = r.reviews[index];
                      final _d = DateTime.parse(item.date_time);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card.outlined(
                          child: ExpansionTile(
                            title: Text(item.user_name),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${_d.day}-${_d.month}-${_d.year}",
                                        textAlign: TextAlign.start,
                                      ),
                                      const Spacer(),
                                      ...List.generate(
                                        item.stars,
                                        (index) => const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.star,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      ...List.generate(
                                        (5 - item.stars),
                                        (index) => const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.star_outline,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                  Text(
                                    "Waiting Time : ${item.waiting_time} Minutes",
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton.outlined(
                              onPressed: () {
                                //TODO: save review as a screenshot
                              },
                              icon: const Icon(Icons.save),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.body,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
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
