import 'dart:async';

import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/constants/static_app_constants.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit_filter.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/widgets/clinic_visits_tile.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/widgets/visits_filter_section.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late final ScrollController _visitsScrollController;

  late final PxClinicVisits cv;

  @override
  void initState() {
    super.initState();
    cv = context.read<PxClinicVisits>();
    _visitsScrollController = ScrollController();
    _visitsScrollController.addListener(_visitsScrollListenter);
  }

  Future<void> _visitsScrollListenter() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final _toCall = _visitsScrollController.position.pixels ==
        _visitsScrollController.position.maxScrollExtent;
    if (_toCall && !cv.isLoading) {
      print(
          '_visitsScrollListener(toCall: $_toCall, isLoading: ${cv.isLoading})');
      await cv.fetchMoreVisits();
    }
  }

  @override
  void dispose() {
    _visitsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxClinicVisits, PxLocale>(
      builder: (context, v, l, _) {
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Text(context.loc.myBookings),
                    Expanded(
                      child: Text(
                        switch (v.filter) {
                          VisitFilter.year_month_day =>
                            DateFormat('dd / MM / yyyy', l.locale.languageCode)
                                .format(DateTime(v.year, v.month!, v.day!)),
                          VisitFilter.year_month =>
                            DateFormat('MM / yyyy', l.locale.languageCode)
                                .format(DateTime(v.year, v.month!)),
                          VisitFilter.year =>
                            DateFormat('yyyy', l.locale.languageCode)
                                .format(DateTime(v.year)),
                        },
                        textAlign: TextAlign.center,
                      ),
                    ),
                    v.dataTotalCount == null
                        ? const CircularProgressIndicator(
                            padding: EdgeInsets.all(0),
                          )
                        : Text('(${v.dataTotalCount ?? ''})'),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              subtitle: const VisitsFilterSection(),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  while (v.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(
                        top: StaticAppConstants.midComponentTopPadding,
                      ),
                      child: CentralLoading(),
                    );
                  }
                  while (v.data != null && v.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: StaticAppConstants.midComponentTopPadding,
                      ),
                      child: Center(
                        child: Text(context.loc.noVisitsInSelectedDate),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: _visitsScrollController,
                    cacheExtent: 3000,
                    itemCount:
                        v.isLoading ? v.data!.length + 1 : v.data?.length,
                    itemBuilder: (context, index) {
                      if (index < v.data!.length) {
                        final _item = v.data![index];
                        return ClinicVisitsTile(
                          index: index,
                          visit: _item,
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
