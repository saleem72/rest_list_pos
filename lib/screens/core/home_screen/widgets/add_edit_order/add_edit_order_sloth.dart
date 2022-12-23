//

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../helpers/styling/lotties_assets.dart';

class AddEditOrderSloth extends StatelessWidget {
  const AddEditOrderSloth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Lottie.asset(LottieAssets.sloth),
      ),
    );
  }
}
