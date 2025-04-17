import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_response_model.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditClinicDataTab extends StatefulWidget {
  const EditClinicDataTab({super.key, required this.clinic});
  final Clinic clinic;

  @override
  State<EditClinicDataTab> createState() => _EditClinicDataTabState();
}

class _EditClinicDataTabState extends State<EditClinicDataTab> {
  late final Map<String, TextEditingController> _controllers;
  late final Map<String, bool> _isEditing;

  @override
  void didChangeDependencies() {
    _controllers = Map.fromEntries(
      ClinicResponseModel.editableStrings(context).entries.map(
            (e) => MapEntry<String, TextEditingController>(
                e.key, TextEditingController()),
          ),
    );
    _isEditing = Map.fromEntries(
      ClinicResponseModel.editableStrings(context).entries.map(
            (e) => MapEntry<String, bool>(e.key, false),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  int? _maxLength(String key) {
    return switch (key) {
      'mobile' => 11,
      'landline' => 8,
      _ => null,
    };
  }

  TextInputType? _keyboardType(String key) {
    return switch (key) {
      'mobile' ||
      'landline' ||
      'consultation_fees' ||
      'followup_fees' ||
      'followup_duration' ||
      'discount' =>
        TextInputType.number,
      _ => TextInputType.text,
    };
  }

  bool _inputFormatters(String key) {
    return switch (key) {
      'mobile' ||
      'landline' ||
      'consultation_fees' ||
      'followup_fees' ||
      'followup_duration' ||
      'discount' =>
        true,
      _ => false,
    };
  }

  bool _isIntegerValue(String key) {
    return switch (key) {
      'consultation_fees' ||
      'followup_fees' ||
      'followup_duration' ||
      'discount' =>
        true,
      _ => false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxClinics>(
      builder: (context, c, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: ListView(
            cacheExtent: 3000,
            shrinkWrap: true,
            children: [
              ...ClinicResponseModel.editableStrings(context)
                  .entries
                  .map((entry) {
                return Card.outlined(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry.value),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            if (_isEditing[entry.key] == false) ...[
                              Expanded(
                                child: Text(widget.clinic
                                    .toJson()[entry.key]
                                    .toString()),
                              ),
                              IconButton.outlined(
                                onPressed: () {
                                  setState(() {
                                    _isEditing[entry.key] == true
                                        ? _isEditing[entry.key] = false
                                        : _isEditing[entry.key] = true;
                                  });
                                },
                                icon: Icon(_isEditing[entry.key] == true
                                    ? Icons.close
                                    : Icons.edit),
                              ),
                              const SizedBox(width: 5),
                            ] else ...[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLength: _maxLength(entry.key),
                                  maxLines:
                                      entry.key.contains('address') ? 3 : null,
                                  keyboardType: _keyboardType(entry.key),
                                  inputFormatters: [
                                    if (_inputFormatters(entry.key))
                                      FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: _controllers[entry.key]
                                    ?..text = widget.clinic
                                        .toJson()[entry.key]
                                        .toString(),
                                ),
                              ),
                              IconButton.outlined(
                                onPressed: () async {
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await c.updateClinic(
                                        widget.clinic.id,
                                        {
                                          entry.key: _isIntegerValue(entry.key)
                                              ? int.tryParse(
                                                  _controllers[entry.key]!.text,
                                                )
                                              : _controllers[entry.key]!.text,
                                        },
                                      );
                                      setState(() {
                                        _isEditing[entry.key] = false;
                                      });
                                    },
                                  );
                                },
                                icon: const Icon(Icons.save),
                              ),
                              const SizedBox(width: 2),
                              IconButton.outlined(
                                onPressed: () {
                                  setState(() {
                                    _isEditing[entry.key] == true
                                        ? _isEditing[entry.key] = false
                                        : _isEditing[entry.key] = true;
                                  });
                                },
                                icon: Icon(_isEditing[entry.key] == true
                                    ? Icons.close
                                    : Icons.edit),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
