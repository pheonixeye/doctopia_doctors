import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseOverlayEntry extends StatefulWidget {
  BaseOverlayEntry({
    super.key,
    required this.message,
    this.color,
    this.onTap,
  });
  final String message;
  final Color? color;
  VoidCallback? onTap;

  @override
  State<BaseOverlayEntry> createState() => _BaseOverlayEntryState();
}

class _BaseOverlayEntryState extends State<BaseOverlayEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _duration = const Duration(seconds: 5);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).primaryColor.withValues(alpha: 0.5),
      onTap: widget.onTap,
      title: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.message,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.info,
            color: widget.color ?? Theme.of(context).primaryColor,
          ),
        ],
      ),
      subtitle: AnimatedBuilder(
        animation: _controller.view,
        builder: (context, child) {
          return LinearProgressIndicator(
            value: _controller.value,
            color: Colors.amber,
            backgroundColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          );
        },
      ),
    );
  }
}

OverlayEntry _overlay(
  String message, [
  Color? color,
]) {
  final _overlay = BaseOverlayEntry(
    message: message,
    color: color,
  );

  final _entry = OverlayEntry(
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - 10,
            height: 60,
            child: Card.outlined(
              child: _overlay,
            ),
          ),
        ),
      );
    },
  );

  _overlay.onTap = () {
    _entry.remove();
  };
  return _entry;
}

///Shell function encapsulating loading & error handling logic in the UI
Future<void> shellFunction(
  BuildContext context, {
  required Function toExecute,
  String sucessMsg = '',
  Function? onCatch,
  Duration duration = const Duration(seconds: 5),
}) async {
  late BuildContext loadingContext;
  try {
    if (sucessMsg.isEmpty) {
      sucessMsg = context.loc.success;
    }
    if (context.mounted) {
      //todo: change to overlay logic
      showDialog(
          context: context,
          builder: (context) {
            loadingContext = context;
            return const CentralLoading();
          });
    }
    await Future.delayed(const Duration(milliseconds: 500));
    await toExecute();
    if (loadingContext.mounted) {
      Navigator.pop(loadingContext);
    }
    if (context.mounted) {
      final _overlay1 = _overlay(sucessMsg);
      Overlay.of(context).insert(_overlay1);
      await Future.delayed(duration);
      // ignore: unnecessary_null_comparison
      try {
        _overlay1.remove();
      } catch (e) {
        return;
      }
    }
  } catch (e) {
    if (loadingContext.mounted) {
      Navigator.pop(loadingContext);
    }
    if (context.mounted) {
      final _overlay2 = _overlay(e.toString(), Colors.red);
      Overlay.of(context).insert(_overlay2);
      await Future.delayed(duration);
      // ignore: unnecessary_null_comparison
      try {
        _overlay2.remove();
      } catch (e) {
        return;
      }

      debugPrint(e.toString());
      if (onCatch != null) {
        onCatch();
      }
    }
  }
}
