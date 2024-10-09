import 'dart:typed_data';

import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/download_image.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_models/models/review.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
    required this.review,
    required this.index,
  });
  final Review review;
  final int index;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late final DateTime _d;
  late final ScreenshotController _controller;
  Uint8List? _image;

  @override
  void initState() {
    _d = DateTime.parse(widget.review.date_time);
    _controller = ScreenshotController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _controller,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card.outlined(
          child: Consumer<PxLocale>(
            builder: (context, l, _) {
              return ExpansionTile(
                expandedAlignment:
                    l.isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(widget.review.user_name),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat(
                              'dd/MM/yyyy',
                              l.locale.languageCode,
                            ).format(
                              DateTime(_d.year, _d.month, _d.day),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const Spacer(),
                          ...List.generate(
                            widget.review.stars,
                            (index) => const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.star, color: Colors.amber),
                            ),
                          ),
                          ...List.generate(
                            (5 - widget.review.stars),
                            (index) => const Padding(
                              padding: EdgeInsets.all(4.0),
                              child:
                                  Icon(Icons.star_outline, color: Colors.amber),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Text(
                        "${context.loc.waitingTime} : ${widget.review.waiting_time.toString().toArabicNumber(context)} ${context.loc.minutes}",
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                trailing: IconButton.outlined(
                  onPressed: () async {
                    //todo: save review as a screenshot
                    _image = await _controller.capture();
                    if (_image != null) {
                      await ImageDownloader.download(uInt8List: _image!);
                    }
                  },
                  icon: const Icon(Icons.save),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      widget.review.body,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
