import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_location.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card/widgets/clinic_location_picker_dialog.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card/widgets/schedule_management_tab.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card/widgets/schedule_summary_tab.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card/widgets/edit_tab.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicCard extends StatefulWidget {
  const ClinicCard({
    super.key,
    required this.clinic,
  });
  final Clinic clinic;

  @override
  State<ClinicCard> createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxClinics>(
      builder: (context, l, c, _) {
        return Card.outlined(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              maintainState: true,
              showTrailingIcon: false,
              initiallyExpanded: false,
              onExpansionChanged: (value) {
                setState(() {
                  _isExpanded = value;
                });
              },
              tilePadding: const EdgeInsets.all(0),
              childrenPadding: const EdgeInsets.all(0),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      l.isEnglish
                          ? widget.clinic.name_en
                          : widget.clinic.name_ar,
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: () async {
                      //todo: update clinic location
                      final _location = await showDialog(
                        context: context,
                        builder: (context) {
                          return ClinicLocationPickerDialog(
                            clinic: widget.clinic,
                          );
                        },
                      );
                      if (_location == null) {
                        return;
                      }
                      if (context.mounted) {
                        await shellFunction(
                          context,
                          toExecute: () async {
                            await c.updateClinic(
                              widget.clinic.id,
                              {
                                'location': _location.toMap(),
                              },
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      widget.clinic.location == ClinicLocation.initial()
                          ? Icons.location_off
                          : Icons.location_on,
                      color: widget.clinic.location == ClinicLocation.initial()
                          ? Colors.amber
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              subtitle: TabBar(
                controller: _tabController,
                indicatorColor: Colors.amber,
                onTap: (value) {
                  if (_isExpanded) {
                    _tabController.animateTo(value);
                  }
                },
                tabs: [
                  Tab(
                    key: const GlobalObjectKey('1'),
                    text: context.loc.summary,
                    icon: const Icon(Icons.calendar_month),
                  ),
                  Tab(
                    key: const GlobalObjectKey('2'),
                    text: context.loc.management,
                    icon: const Icon(Icons.edit_calendar_rounded),
                  ),
                  Tab(
                    key: const GlobalObjectKey('3'),
                    text: context.loc.update,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ],
              ),
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height -
                      (MediaQuery.sizeOf(context).height * 0.4),
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ScheduleSummaryTab(),
                      ScheduleManagementTab(),
                      EditClinicDataTab(
                        clinic: widget.clinic,
                      ),
                    ],
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
