import 'package:doctopia_doctors/models/schedule/schedule.dart';
import 'package:doctopia_doctors/models/weekdays/weekdays.dart';
import 'package:doctopia_doctors/providers/px_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddClinicShiftDialog extends StatefulWidget {
  const AddClinicShiftDialog({super.key});

  @override
  State<AddClinicShiftDialog> createState() => _AddClinicShiftDialogState();
}

class _AddClinicShiftDialogState extends State<AddClinicShiftDialog> {
  final _formKey = GlobalKey<FormState>();
  final _timeList = List.generate(24, (index) => index);
  Weekdays? _weekdays;
  int? _start;
  int? _end;
  int? _slots;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 10,
      title: Row(
        children: [
          const Spacer(),
          FloatingActionButton.small(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            heroTag: 'close-dialog',
            onPressed: () {
              GoRouter.of(context).pop(null);
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            ListTile(
              title: const Text('Select Weekday'),
              subtitle: DropdownButtonFormField<Weekdays>(
                isExpanded: true,
                items: Weekdays.list.map((e) {
                  return DropdownMenuItem<Weekdays>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e.d),
                  );
                }).toList(),
                value: _weekdays,
                validator: (value) {
                  if (_weekdays == null) {
                    return 'Pick a weekday';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _weekdays = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Select Starting Time.'),
              subtitle: DropdownButtonFormField<int>(
                isExpanded: true,
                items: _timeList.map((e) {
                  return DropdownMenuItem<int>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList(),
                value: _start,
                validator: (value) {
                  if (_start == null) {
                    return 'Pick a Starting Time.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _start = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Select Ending Time.'),
              subtitle: DropdownButtonFormField<int>(
                isExpanded: true,
                items: _timeList.map((e) {
                  return DropdownMenuItem<int>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList(),
                value: _end,
                validator: (value) {
                  if (_end == null) {
                    return 'Pick a Ending Time.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _end = value;
                  });
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number of Patients',
                suffix: SizedBox(
                  height: 24,
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Number of Patients';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _slots = int.tryParse(value);
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        FloatingActionButton.small(
          heroTag: 'confirm-dialog',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final _sch = Schedule(
                weekday: _weekdays!.d,
                intday: _weekdays!.i,
                start: _start!,
                end: _end!,
                slots: _slots!,
              );
              context.read<PxSchedule>().setSchedule(
                    weekday: _sch.weekday,
                    intday: _sch.intday,
                    start: _sch.start,
                    end: _sch.end,
                    slots: _sch.slots,
                  );
              GoRouter.of(context).pop<bool>(true);
            }
          },
          child: const Icon(Icons.check),
        ),
        FloatingActionButton.small(
          heroTag: 'cancel-dialog',
          onPressed: () {
            GoRouter.of(context).pop(null);
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
