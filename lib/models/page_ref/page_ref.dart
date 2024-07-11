// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/api/clinic_visits_api/hx_clinic_visits.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/bookings_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/clinics_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/documents_page/documents_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/invoices_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/news_feed_page/news_feed_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/notifications_page/notifications_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/profile_page/profile_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/reviews_page/reviews_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/settings_page/settings_page.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Widget, IconData, Icons;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SidebarPageRef extends Equatable {
  factory SidebarPageRef.newsFeed() {
    return const SidebarPageRef(
      name: 'Feed',
      page: NewsFeedPage(),
      icon: Icons.newspaper,
    );
  }
  factory SidebarPageRef.bookings(String doc_id) {
    return SidebarPageRef(
      name: 'Bookings',
      page: ChangeNotifierProvider(
        create: (context) => PxClinicVisits(
          doc_id: doc_id,
          visitsService: HxClinicVisits(),
        ),
        child: BookingsPage(),
      ),
      icon: Icons.calendar_month_outlined,
    );
  }
  factory SidebarPageRef.clinics(String id) {
    final key = ValueKey(id);
    return SidebarPageRef(
      name: 'Clinics',
      page: ChangeNotifierProvider(
        key: key,
        create: (context) => PxClinics(
          id: id,
          clinicService: HxClinic(),
        ),
        child: ClinicsPage(
          key: ValueKey(id),
        ),
      ),
      icon: FontAwesomeIcons.houseMedical,
    );
  }
  factory SidebarPageRef.profile() {
    return const SidebarPageRef(
      name: 'Profile',
      page: ProfilePage(),
      icon: FontAwesomeIcons.userDoctor,
    );
  }
  factory SidebarPageRef.documents() {
    return const SidebarPageRef(
      name: 'Documents',
      page: DocumentsPage(),
      icon: FontAwesomeIcons.stamp,
    );
  }

  factory SidebarPageRef.notifications() {
    return const SidebarPageRef(
      name: 'Notifications',
      page: NotificationsPage(),
      icon: FontAwesomeIcons.bell,
    );
  }

  factory SidebarPageRef.invoices() {
    return const SidebarPageRef(
      name: 'Invoices',
      page: InvoicesPage(),
      icon: FontAwesomeIcons.fileInvoiceDollar,
    );
  }
  factory SidebarPageRef.reviews() {
    return const SidebarPageRef(
      name: 'Reviews',
      page: ReviewsPage(),
      icon: FontAwesomeIcons.message,
    );
  }
  factory SidebarPageRef.settings() {
    return const SidebarPageRef(
      name: 'Settings',
      page: SettingsPage(),
      icon: Icons.settings,
    );
  }

  final Widget page;
  final String name;
  final IconData icon;

  const SidebarPageRef({
    required this.name,
    required this.page,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        name,
        page,
        icon,
      ];
}

List<SidebarPageRef> loggedInPages(String id) => [
      SidebarPageRef.newsFeed(),
      SidebarPageRef.bookings(id),
      SidebarPageRef.profile(),
      // SidebarPageRef.documents(),
      SidebarPageRef.clinics(id),
      SidebarPageRef.notifications(),
      SidebarPageRef.invoices(),
      SidebarPageRef.reviews(),
      SidebarPageRef.settings(),
    ];
