import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @proklinik.
  ///
  /// In en, this message translates to:
  /// **'ProKliniK'**
  String get proklinik;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter a Valid Email Address.'**
  String get enterValidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @kindlyEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Password.'**
  String get kindlyEnterPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @linkSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'A Password Reset Link Was Sent To Your Email Address.'**
  String get linkSentToEmail;

  /// No description provided for @notRegisteredYet.
  ///
  /// In en, this message translates to:
  /// **'Not Registered Yet ?  '**
  String get notRegisteredYet;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create An Account.'**
  String get createAccount;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @syndId.
  ///
  /// In en, this message translates to:
  /// **'Syndicate Id'**
  String get syndId;

  /// No description provided for @syndIdValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Syndicate Id Number.'**
  String get syndIdValidator;

  /// No description provided for @engName.
  ///
  /// In en, this message translates to:
  /// **'English Name'**
  String get engName;

  /// No description provided for @engNameValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter English Name.'**
  String get engNameValidator;

  /// No description provided for @personalPhone.
  ///
  /// In en, this message translates to:
  /// **'Personal Phone'**
  String get personalPhone;

  /// No description provided for @personalPhoneValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Personal Mobile Number.'**
  String get personalPhoneValidator;

  /// No description provided for @selectServiceType.
  ///
  /// In en, this message translates to:
  /// **'Select Service Type'**
  String get selectServiceType;

  /// No description provided for @selectServiceTypeValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Select Service Type.'**
  String get selectServiceTypeValidator;

  /// No description provided for @selectServiceTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Service Type...'**
  String get selectServiceTypeHint;

  /// No description provided for @passwordLengthValidator.
  ///
  /// In en, this message translates to:
  /// **'Minimum Required Length is 8 Characters.'**
  String get passwordLengthValidator;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordEnterValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Confirm Password.'**
  String get confirmPasswordEnterValidator;

  /// No description provided for @confirmPasswordMatchValidator.
  ///
  /// In en, this message translates to:
  /// **'Password Not Matching.'**
  String get confirmPasswordMatchValidator;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Sucess...'**
  String get success;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @onlyClinicServices.
  ///
  /// In en, this message translates to:
  /// **'Sorry For The Inconvenience, We Only Provide Clinic Services At The Moment.'**
  String get onlyClinicServices;

  /// No description provided for @alreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Already Registered ?  '**
  String get alreadyRegistered;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile.'**
  String get completeYourProfile;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want To Logout ?'**
  String get confirmLogoutMessage;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error.'**
  String get unknownError;

  /// No description provided for @feed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get feed;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @clinics.
  ///
  /// In en, this message translates to:
  /// **'Clinics'**
  String get clinics;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @completeProfileForArticles.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile To Get A Customized News Feed Of Medical Articles.'**
  String get completeProfileForArticles;

  /// No description provided for @latestFromMedscape.
  ///
  /// In en, this message translates to:
  /// **'Latest From Medscape'**
  String get latestFromMedscape;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookings;

  /// No description provided for @todayBookings.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Bookings'**
  String get todayBookings;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @allMonthBookings.
  ///
  /// In en, this message translates to:
  /// **'All Month Bookings'**
  String get allMonthBookings;

  /// No description provided for @noVisitsInSelectedDate.
  ///
  /// In en, this message translates to:
  /// **'No Visits In Selected Date'**
  String get noVisitsInSelectedDate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @contractAndDocuments.
  ///
  /// In en, this message translates to:
  /// **'Contract & Documents'**
  String get contractAndDocuments;

  /// No description provided for @signContract.
  ///
  /// In en, this message translates to:
  /// **'Sign Contract'**
  String get signContract;

  /// No description provided for @submitDocuments.
  ///
  /// In en, this message translates to:
  /// **'Submit Documents'**
  String get submitDocuments;

  /// No description provided for @emailNotificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Email Notification Settings'**
  String get emailNotificationSettings;

  /// No description provided for @newsletter.
  ///
  /// In en, this message translates to:
  /// **'Newsletter'**
  String get newsletter;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'version'**
  String get version;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
