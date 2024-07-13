// ignore_for_file: prefer_final_fields

import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/_px_dates.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/management_tab.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/summary_tab.dart';
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

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
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
              _tabController.animateTo(value);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //schedule management tab page
          ChangeNotifierProvider(
            create: (_) => PxDates(),
            builder: (context, child) {
              return const ScheduleSummaryTab();
            },
          ),
          //schedule management tab page
          const ScheduleManagementTab(),
        ],
      ),
    );
  }
}
