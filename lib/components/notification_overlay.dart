import 'dart:async';

import 'package:doctopia_doctors/models/msg.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_overlay.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationOverlayCard extends StatefulWidget implements EquatableMixin {
  const NotificationOverlayCard({super.key, required this.notification});
  final NotMsg notification;
  @override
  State<NotificationOverlayCard> createState() =>
      _NotificationOverlayCardState();

  @override
  List<Object?> get props => [notification];

  @override
  bool? get stringify => true;
}

class _NotificationOverlayCardState extends State<NotificationOverlayCard> {
  late final Timer? timer;
  static const _duration = Duration(milliseconds: 10);
  double _progress = 0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(_duration, (timer) {
      setState(() {
        _progress += 0.001;
        if (_progress >= 1.0) {
          context.read<PxOverlay>().removeOverlay(widget.notification.id);
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxOverlay, PxLocale>(
      builder: (context, o, l, _) {
        final index = o.overlays.keys
            .toList()
            .indexWhere((e) => e == widget.notification.id);
        return Padding(
          padding: EdgeInsets.only(
              top: (index * 120.0) + 12,
              left: l.isEnglish ? 12 : 0,
              right: l.isEnglish ? 12 : 0),
          child: Align(
            alignment: l.isEnglish ? Alignment.topLeft : Alignment.topRight,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    trailing: FloatingActionButton.small(
                      heroTag: DateTime.now().toIso8601String(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        timer?.cancel();
                        o.toggleOverlay(
                          id: widget.notification.id,
                          child: widget,
                          context: context,
                        );
                      },
                      child: const Icon(Icons.check),
                    ),
                    leading: const CircleAvatar(
                      child: Icon(Icons.info),
                    ),
                    title: Text(
                      widget.notification.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context)
                            .appBarTheme
                            .backgroundColor!
                            .withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).appBarTheme.backgroundColor!,
                        ),
                        value: _progress,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          widget.notification.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
