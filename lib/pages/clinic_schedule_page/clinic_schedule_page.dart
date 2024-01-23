import 'package:doctopia_doctors/functions/date_functions.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicSchedulePage extends StatefulWidget {
  const ClinicSchedulePage({super.key});

  @override
  State<ClinicSchedulePage> createState() => _ClinicSchedulePageState();
}

class _ClinicSchedulePageState extends State<ClinicSchedulePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  List<DateTime> _dates = [];

  void _initDates() {
    final _today = DateTime.now();
    final _startingDay = DateTime(_today.year, _today.month, _today.day);
    for (var i = 0; i < 30; i++) {
      _dates.add(_startingDay.add(Duration(days: i)));
    }
  }

  void _updateDates() {
    final _lastDay = _dates.last;
    setState(() {
      for (var i = 0; i < 30; i++) {
        _dates.add(_lastDay.add(Duration(days: i)));
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _scrollController = ScrollController();
    _initDates();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          _updateDates();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Schedule"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                key: GlobalObjectKey('1'),
                text: 'Summary',
                icon: Icon(Icons.calendar_month),
              ),
              Tab(
                key: GlobalObjectKey('2'),
                text: 'Management',
                icon: Icon(Icons.edit_calendar_rounded),
              ),
            ],
            onTap: (value) {
              setState(() {
                _tabController.animateTo(value);
              });
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              alignment: Alignment.center,
              child: Consumer2<PxLocale, PxClinics>(
                builder: (context, l, c, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: _dates.length,
                    itemBuilder: (context, index) {
                      final _d = _dates[index];
                      final isOff = c.clinics[c.selectedIndex!].clinic.off_dates
                          .contains(_d.toIso8601String());
                      return ListTile(
                        leading: const CircleAvatar(),
                        title: Text(getWeekday(_d.weekday)!),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${_d.day} / ${_d.month} / ${_d.year}'),
                        ),
                        trailing: FloatingActionButton.small(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          heroTag: '${_d.day} / ${_d.month} / ${_d.year}',
                          backgroundColor: isOff ? Colors.red : null,
                          onPressed: () async {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                late final Map<String, dynamic> _update;
                                List<String> clinicOffDates = [
                                  ...c.clinics[c.selectedIndex!].clinic
                                      .off_dates
                                ];
                                if (isOff) {
                                  clinicOffDates.remove(_d.toIso8601String());
                                } else {
                                  clinicOffDates.add(_d.toIso8601String());
                                }

                                _update = {
                                  'off_dates': clinicOffDates,
                                };
                                await c.updateClinic(
                                    c.clinics[c.selectedIndex!].id, _update);
                              },
                            );
                          },
                          child: isOff
                              ? const Icon(Icons.airplanemode_active)
                              : const Icon(Icons.airplanemode_inactive_rounded),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text('Management'),
              //TODO: create schedule shifts
            ),
          ],
        ),
      ),
    );
  }
}
