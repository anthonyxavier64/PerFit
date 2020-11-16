import 'package:flutter/material.dart';

class OfferStatusEmployerScreen extends StatelessWidget {
  static const routeName = './offer_status_employer_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PerFit!'),
      ),
      /* body: ListView.builder(itemBuilder: (ctx, index) {
        return JobWidget();
        }
        )
      */
      body: Center(
        child: Text('offer'),
      ),
    );
  }
}
