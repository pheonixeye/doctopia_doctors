import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/bookings_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/clinics_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/documents_page/documents_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/invoices_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/news_feed_page/news_feed_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/notifications_page/notifications_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/profile_page/profile_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/reviews_page/reviews_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/settings_page/settings_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Widget, IconData, Icons;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarPageRef extends Equatable {
  factory SidebarPageRef.newsFeed() {
    return const SidebarPageRef(
      name: 'Feed',
      page: NewsFeedPage(),
      icon: Icons.newspaper,
    );
  }
  factory SidebarPageRef.bookings() {
    return const SidebarPageRef(
      name: 'Bookings',
      page: BookingsPage(),
      icon: Icons.calendar_month_outlined,
    );
  }
  factory SidebarPageRef.clinics() {
    return const SidebarPageRef(
      name: 'Clinics',
      page: ClinicsPage(),
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

  static List<SidebarPageRef> pages(bool isLoggedIn) {
    return isLoggedIn ? loggedInPages : loggedOutPages;
  }

  static final List<SidebarPageRef> loggedInPages = [
    SidebarPageRef.newsFeed(),
    SidebarPageRef.bookings(),
    SidebarPageRef.profile(),
    SidebarPageRef.documents(),
    SidebarPageRef.clinics(),
    SidebarPageRef.notifications(),
    SidebarPageRef.invoices(),
    SidebarPageRef.reviews(),
    SidebarPageRef.settings(),
  ];

  static final List<SidebarPageRef> loggedOutPages = [
    SidebarPageRef.newsFeed(),
    // SidebarPageRef.bookings(),
    // SidebarPageRef.profile(),
    // SidebarPageRef.clinics(),
    // SidebarPageRef.notifications(),
    // SidebarPageRef.invoices(),
    SidebarPageRef.settings(),
  ];

  @override
  List<Object?> get props => [
        name,
        page,
        icon,
      ];
}
