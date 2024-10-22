import 'package:doctopia_doctors/api/doctor_feedback_api/doctor_feedback_api.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);
  late final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _controller,
      onClosing: () {},
      elevation: 8,
      builder: (context) {
        return Container(
          height: 400,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Colors.green.shade100,
          ),
          child: ListView(
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(
                  context.loc.shareYourFeedback,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: IconButton.outlined(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  icon: const Icon(Icons.close),
                ),
                subtitle: const Divider(),
              ),
              ListTile(
                title: Text(context.loc.feedback),
                subtitle: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: context.loc.shareFeedbackMsg,
                  ),
                  maxLines: 12,
                  minLines: 8,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_textController.text.isEmpty) {
                        showInfoSnackbar(
                          context,
                          context.loc.emptyInputsNotAllowed,
                        );
                        return;
                      }

                      await shellFunction(
                        context,
                        toExecute: () async {
                          final _api = DoctorFeedbackApi(
                            docId: context.read<PxDoctor>().id,
                          );
                          try {
                            await _api.sendDoctorFeedback(
                                message: _textController.text);
                            if (context.mounted) {
                              Navigator.pop(context, true);
                              showInfoSnackbar(
                                context,
                                context.loc.feedbackSubmittedSuccessfully,
                                Colors.green,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showInfoSnackbar(
                                context,
                                e.toString(),
                              );
                              return;
                            }
                          }
                        },
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: Text(context.loc.confirm),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    icon: const Icon(Icons.close),
                    label: Text(context.loc.cancel),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
