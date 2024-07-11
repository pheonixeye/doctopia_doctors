// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/routes/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarPageRef extends Equatable {
  factory SidebarPageRef.newsFeed() {
    return const SidebarPageRef(
      path: AppRouter.home,
      name: "Feed",
      icon: Icons.newspaper,
    );
  }
  factory SidebarPageRef.bookings() {
    return const SidebarPageRef(
      path: AppRouter.bookings,
      name: "Bookings",
      icon: Icons.calendar_month_outlined,
    );
  }
  factory SidebarPageRef.clinics() {
    return const SidebarPageRef(
      path: AppRouter.clinics,
      name: "Clinics",
      icon: FontAwesomeIcons.houseMedical,
    );
  }
  factory SidebarPageRef.profile() {
    return const SidebarPageRef(
      path: AppRouter.profile,
      name: "Profile",
      icon: FontAwesomeIcons.userDoctor,
    );
  }

  factory SidebarPageRef.notifications() {
    return const SidebarPageRef(
      path: AppRouter.notifications,
      name: "Notifications",
      icon: FontAwesomeIcons.bell,
    );
  }

  factory SidebarPageRef.invoices() {
    return const SidebarPageRef(
      path: AppRouter.invoices,
      name: "Invoices",
      icon: FontAwesomeIcons.fileInvoiceDollar,
    );
  }
  factory SidebarPageRef.reviews() {
    return const SidebarPageRef(
      path: AppRouter.reviews,
      icon: FontAwesomeIcons.message,
      name: "Reviews",
    );
  }
  factory SidebarPageRef.settings() {
    return const SidebarPageRef(
      name: "Settings",
      path: AppRouter.settings,
      icon: Icons.settings,
    );
  }

  final String name;
  final String path;
  final IconData icon;

  const SidebarPageRef({
    required this.name,
    required this.path,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        name,
        path,
        icon,
      ];
}

final List<SidebarPageRef> loggedInPages = [
  SidebarPageRef.newsFeed(),
  SidebarPageRef.bookings(),
  SidebarPageRef.profile(),
  SidebarPageRef.clinics(),
  SidebarPageRef.notifications(),
  SidebarPageRef.invoices(),
  SidebarPageRef.reviews(),
  SidebarPageRef.settings(),
];
