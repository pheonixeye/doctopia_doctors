import 'package:flutter/widgets.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('bookings_page'),
      ),
    );
  }
}
