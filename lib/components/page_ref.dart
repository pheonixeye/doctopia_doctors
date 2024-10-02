// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarPageRef extends Equatable {
  factory SidebarPageRef.newsFeed(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.home,
      name: context.loc.feed,
      icon: Icons.newspaper,
    );
  }
  factory SidebarPageRef.bookings(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.bookings,
      name: context.loc.bookings,
      icon: Icons.calendar_month_outlined,
    );
  }
  factory SidebarPageRef.clinics(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.clinics,
      name: context.loc.clinics,
      icon: FontAwesomeIcons.houseMedical,
    );
  }
  factory SidebarPageRef.profile(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.profile,
      name: context.loc.profile,
      icon: FontAwesomeIcons.userDoctor,
    );
  }

  factory SidebarPageRef.notifications(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.notifications,
      name: context.loc.notifications,
      icon: FontAwesomeIcons.bell,
    );
  }

  factory SidebarPageRef.invoices(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.invoices,
      name: context.loc.invoices,
      icon: FontAwesomeIcons.fileInvoiceDollar,
    );
  }
  factory SidebarPageRef.reviews(BuildContext context) {
    return SidebarPageRef(
      context: context,
      path: AppRouter.reviews,
      icon: FontAwesomeIcons.message,
      name: context.loc.reviews,
    );
  }
  factory SidebarPageRef.settings(BuildContext context) {
    return SidebarPageRef(
      context: context,
      name: context.loc.settings,
      path: AppRouter.settings,
      icon: Icons.settings,
    );
  }

  final String name;
  final String path;
  final IconData icon;
  final BuildContext context;

  const SidebarPageRef({
    required this.context,
    required this.name,
    required this.path,
    required this.icon,
  });

  static List<SidebarPageRef> homePages(BuildContext context) => [
        SidebarPageRef.newsFeed(context),
        SidebarPageRef.bookings(context),
        SidebarPageRef.profile(context),
        SidebarPageRef.clinics(context),
        SidebarPageRef.notifications(context),
        SidebarPageRef.invoices(context),
        SidebarPageRef.reviews(context),
        SidebarPageRef.settings(context),
      ];

  @override
  List<Object?> get props => [
        context,
        name,
        path,
        icon,
      ];
}
