//

import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/styling/pallet.dart';

import '../helpers/styling/styling.dart';
import 'app_autocomplete.dart';

class AppDropDownButton extends StatefulWidget {
  const AppDropDownButton(
      {super.key, required this.items, this.selected, required this.onChanged});
  final List<ObjectTitle> items;
  final ObjectTitle? selected;
  final Function(ObjectTitle) onChanged;

  @override
  State<AppDropDownButton> createState() => _AppDropDownButtonState();
}

class _AppDropDownButtonState extends State<AppDropDownButton> {
  ObjectTitle? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant AppDropDownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // setState(() {
    //   _selected = widget.selected;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<ObjectTitle?>(
        // value: widget.cell.subject,
        isExpanded: true,
        icon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(Assets.coloredDownArrow),
        ),
        dropdownColor: Pallet.cardColors,
        focusColor: Colors.transparent,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Pallet.darkAppBar,
            ),
        value: _selected,
        items: widget.items
            .map((e) => DropdownMenuItem<ObjectTitle>(
                  value: e,
                  child: Text(
                    e.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            widget.onChanged(value);
            setState(() {
              _selected = value;
            });
          }
        },
      ),
    );
  }
}
