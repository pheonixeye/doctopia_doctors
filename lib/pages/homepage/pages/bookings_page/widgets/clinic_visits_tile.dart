import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClinicVisitsTile extends StatefulWidget {
  const ClinicVisitsTile({
    super.key,
    required this.visit,
    required this.index,
  });
  final Visit visit;
  final int index;
  @override
  State<ClinicVisitsTile> createState() => _ClinicVisitsTileState();
}

class _ClinicVisitsTileState extends State<ClinicVisitsTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer4<PxClinicVisits, PxClinics, PxLocale, PxAppConstants>(
      builder: (context, v, c, l, a, _) {
        while (c.clinics == null || a.model == null) {
          return const CentralLoading();
        }
        while (c.clinics != null && c.clinics!.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          );
        }
        final clinic =
            c.clinics!.firstWhere((e) => e.id == widget.visit.clinic_id);
        final clinicName = l.isEnglish ? clinic.name_en : clinic.name_ar;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card.outlined(
            child: ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.patient_name),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.patient_phone),
              ),
              leading: CircleAvatar(
                child: Text("${widget.index + 1}"),
              ),
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(clinicName),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('dd / MM / yyyy', l.locale.languageCode)
                              .format(
                            widget.visit.visit_date,
                          ),
                        ),
                      ],
                    ),
                  ), //fetch clinic from id
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(context.loc.from),
                            Text(': '),
                            Text(
                              TimeOfDay(
                                hour: widget.visit.visit_shift.start_hour,
                                minute: widget.visit.visit_shift.start_minute,
                              ).format(context),
                            ),
                            Text(context.loc.to),
                            Text(': '),
                            Text(
                              TimeOfDay(
                                hour: widget.visit.visit_shift.end_hour,
                                minute: widget.visit.visit_shift.end_minute,
                              ).format(context),
                            ),
                            const SizedBox(width: 20),
                            FilterChip.elevated(
                              label: Text(l.isEnglish
                                  ? widget.visit.visit_type.name_en
                                  : widget.visit.visit_type.name_ar),
                              onSelected: null,
                            ),
                          ],
                        ),
                        Card.outlined(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                ...a.model!.visit_status.map((status) {
                                  if (status.name_en == 'attended' ||
                                      status.name_en == 'not attended' ||
                                      status.name_en == 'rescheduled') {
                                    return FilterChip.elevated(
                                      label: Text(
                                        l.isEnglish
                                            ? status.name_en
                                            : status.name_ar,
                                      ),
                                      selected: widget.visit.visit_status.id ==
                                          status.id,
                                      onSelected: (value) async {
                                        if (widget.visit.month !=
                                                DateTime.now().month ||
                                            widget.visit.year !=
                                                DateTime.now().year) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      context.loc
                                                          .cannotUpdateVisitNotInSameMonth,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              duration:
                                                  const Duration(seconds: 5),
                                            ),
                                          );
                                          return;
                                        }
                                        await shellFunction(
                                          context,
                                          toExecute: () async {
                                            await v.updateClinicVisit(
                                              widget.visit.id,
                                              {
                                                'visit_status_id': status.id,
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                  return const SizedBox();
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
