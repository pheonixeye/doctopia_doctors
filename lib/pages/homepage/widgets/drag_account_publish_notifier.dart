import 'package:flutter/material.dart';

class AccountPublishNotifier extends StatefulWidget {
  const AccountPublishNotifier({super.key});

  @override
  State<AccountPublishNotifier> createState() => _AccountPublishNotifierState();
}

class _AccountPublishNotifierState extends State<AccountPublishNotifier> {
  Offset position = const Offset(20, 500);
  bool expanded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Container(
          width: 250,
          height: expanded ? 120 : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          setState(() {
            if (offset.dy > MediaQuery.sizeOf(context).height - 150) {
              position =
                  Offset(offset.dx, MediaQuery.sizeOf(context).height - 150);
            } else if (offset.dx > MediaQuery.sizeOf(context).width - 150) {
              position =
                  Offset(MediaQuery.sizeOf(context).width - 150, offset.dy);
            } else if (offset.dx < -150) {
              position = Offset(-150, offset.dy);
            } else {
              position = offset;
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 250,
          height: expanded ? 120 : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.grey.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            initiallyExpanded: false,
            onExpansionChanged: (val) {
              setState(() {
                expanded = val;
              });
            },
            title: const Text('Account Not Published...'),
            children: const [
              //TODO: list info for account to be published
              //TODO: if list is empty => request publishing
            ],
          ),
        ),
      ),
    );
  }
}
