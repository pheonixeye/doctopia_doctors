import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class AppTheme {
  static CardTheme cardTheme = CardTheme(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            bottomStart: Radius.circular(20),
          ),
        ),
        color: colorScheme.primaryContainer,
      );

  static ThemeData theme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      cardTheme: cardTheme,
      listTileTheme: listTileTheme,
      appBarTheme: appBarTheme(colorScheme),
    );
  }

  static SidebarXTheme sidebarXthemeExtendedDark(BuildContext context) =>
      SidebarXTheme(
        width: 250,
        itemPadding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(1, 1),
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        itemTextPadding: const EdgeInsets.symmetric(horizontal: 12),
        selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 12),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  static SidebarXTheme sidebarXthemeRegularDark(BuildContext context) =>
      SidebarXTheme(
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.primaryContainer,
          color: Theme.of(context).appBarTheme.backgroundColor,

          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(1, 1),
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        // textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        // selectedTextStyle: const TextStyle(color: Colors.white),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).canvasColor
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          // color: Colors.white,
          size: 28,
        ),
        itemPadding: const EdgeInsets.all(4),
      );

  static SidebarXTheme sidebarXthemeExtendedLight(BuildContext context) =>
      SidebarXTheme(
        width: 250,
        itemPadding: const EdgeInsets.all(4),
        selectedItemDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.primaryContainer,
          color: Theme.of(context).appBarTheme.backgroundColor,

          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        itemTextPadding: const EdgeInsets.symmetric(horizontal: 12),
        selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 12),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
  static SidebarXTheme sidebarXthemeRegularLight(BuildContext context) =>
      SidebarXTheme(
        iconTheme: const IconThemeData(),
        itemPadding: const EdgeInsets.all(4),
        selectedIconTheme: const IconThemeData(
          size: 28,
        ),
        selectedItemDecoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.primaryContainer,
          color: Theme.of(context).appBarTheme.backgroundColor,

          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        hoverColor: Colors.orange.shade500,
        hoverTextStyle: const TextStyle(
          color: Colors.white,
        ),
      );
}
