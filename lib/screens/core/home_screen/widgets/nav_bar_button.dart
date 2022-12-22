//

import 'package:flutter/material.dart';

import 'fade_in_icon.dart';

class NavBarButton extends StatelessWidget {
  const NavBarButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);
  final String icon;
  final String label;
  final bool isActive;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Color(0xFF707070),
            ),
          ),
        ),
        child: Row(
          children: [
            FadeInIcon(isActive: isActive, icon: icon),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
