import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_reviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> with AfterLayoutMixin {
  final Map<String, bool> _isEditing = {};
  final Map<String, TextEditingController> _controllers = {};
  late final ScrollController _scrollController;

  @override
  void initState() {
    // _initScheduleProviders();
    _scrollController = ScrollController();
    // context.read<PxDates>().initDates(_onDates);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          //TODO: FETCH next batch of reviews
        }
      }
    });
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context
        .read<PxReviews>()
        .fetchReviews(context.read<PxDoctor>().doctor!.id)
        .whenComplete(() {
      if (mounted) {
        setState(() {
          context.read<PxReviews>().reviews.map((e) {
            _isEditing[e.id] = false;
            _controllers[e.id] = TextEditingController();
          }).toList();
        });
      }
    });
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
            builder: (context, r, c) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      if (r.reviews.isEmpty)
                        const Text('No Reviews Yet.')
                      else
                        ...r.reviews.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              leading: CircleAvatar(
                                child: e.review.doc_reply.trim().isEmpty
                                    ? const Icon(Icons.info_outline)
                                    : const Icon(Icons.check),
                              ),
                              title: Text(e.review.date),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                ...e.review.toJson().entries.map((x) {
                                  if (x.key == 'doc_reply') {
                                    return (_isEditing[e.id] != null &&
                                            _isEditing[e.id]!)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              onTapOutside: (event) {
                                                setState(() {
                                                  _isEditing[e.id] = false;
                                                });
                                                // print('tapped outside');
                                              },
                                              controller: _controllers[e.id]!
                                                ..text = e.review.doc_reply,
                                              maxLength: 400,
                                              decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText: x.key,
                                                suffix:
                                                    FloatingActionButton.small(
                                                  heroTag: '${e.id}-editing',
                                                  onPressed: () async {
                                                    await shellFunction(
                                                      context,
                                                      toExecute: () async {
                                                        await r.updateReview(
                                                          context
                                                              .read<PxDoctor>()
                                                              .doctor!
                                                              .id,
                                                          e.id,
                                                          _controllers[e.id]!
                                                              .text,
                                                        );
                                                      },
                                                    );
                                                    setState(() {
                                                      _isEditing[e.id] = false;
                                                    });
                                                  },
                                                  child: const Icon(Icons.send),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text('${x.key} :\n${x.value}'),
                                                const Spacer(),
                                                if (x.value.trim().isEmpty)
                                                  FloatingActionButton.small(
                                                    heroTag: e.id,
                                                    onPressed: () {
                                                      setState(() {
                                                        _isEditing[e.id] = true;
                                                      });
                                                    },
                                                    child:
                                                        const Icon(Icons.reply),
                                                  ),
                                              ],
                                            ),
                                          );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${x.key} :\n${x.value}'),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
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
