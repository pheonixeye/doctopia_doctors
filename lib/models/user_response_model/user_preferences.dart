import 'package:equatable/equatable.dart';

class UserPreferences extends Equatable {
  //TODO: to be extended
  final bool mailBookings;
  final bool mailInvoices;
  final bool mailNews;

  const UserPreferences({
    required this.mailBookings,
    required this.mailInvoices,
    required this.mailNews,
  });

  UserPreferences copyWith({
    bool? mailBookings,
    bool? mailInvoices,
    bool? mailNews,
  }) {
    return UserPreferences(
      mailBookings: mailBookings ?? this.mailBookings,
      mailInvoices: mailInvoices ?? this.mailInvoices,
      mailNews: mailNews ?? this.mailNews,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mail_bookings': mailBookings,
      'mail_invoices': mailInvoices,
      'mail_news': mailNews,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> map) {
    return UserPreferences(
      mailBookings: map['mail_bookings'] as bool,
      mailInvoices: map['mail_invoices'] as bool,
      mailNews: map['mail_news'] as bool,
    );
  }

  factory UserPreferences.initial() {
    return const UserPreferences(
      mailBookings: true,
      mailInvoices: true,
      mailNews: true,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        mailBookings,
        mailInvoices,
        mailNews,
      ];
}
