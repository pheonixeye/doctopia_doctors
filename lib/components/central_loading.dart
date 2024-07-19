import 'package:flutter/material.dart';

class CentralLoading extends StatelessWidget {
  const CentralLoading({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: modulate to show specialities svg icons spinning
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.green.shade500,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}
