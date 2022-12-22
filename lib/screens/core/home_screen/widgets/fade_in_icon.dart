//

import 'package:flutter/material.dart';

class FadeInIcon extends StatelessWidget {
  const FadeInIcon({
    Key? key,
    required this.isActive,
    required this.icon,
  }) : super(key: key);

  final bool isActive;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isActive
          ? SizedBox(
              key: const ValueKey<bool>(true),
              width: 25,
              height: 25,
              child: Image.asset(icon, color: Theme.of(context).primaryColor),
            )
          : SizedBox(
              key: const ValueKey<bool>(false),
              width: 25,
              height: 25,
              child: Image.asset(icon,
                  color: Theme.of(context).primaryColor.withOpacity(0.5)),
            ),
    );
  }
}
