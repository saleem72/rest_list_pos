// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/styling/assets.dart';

@immutable
class ObjectTitle extends Equatable {
  final int id;
  final String title;
  const ObjectTitle({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}

class AppAutoComplete extends StatefulWidget {
  const AppAutoComplete(
      {Key? key,
      required this.objectsList,
      required this.onSelected,
      this.initialValue,
      this.hint,
      this.onChange})
      : super(key: key);

  final List<ObjectTitle> objectsList;
  final String? hint;
  final String? initialValue;
  final Function(ObjectTitle) onSelected;
  final Function(String)? onChange;

  @override
  State<AppAutoComplete> createState() => _AppAutoCompleteState();
}

class _AppAutoCompleteState extends State<AppAutoComplete> {
  late TextEditingValue _initialValue;
  TextEditingController? _controller;
  @override
  void initState() {
    super.initState();
    _initialValue = TextEditingValue(text: widget.initialValue ?? '');
  }

  @override
  Widget build(BuildContext context) {
    String displayStringForOption(ObjectTitle option) => option.title;
    return Row(
      children: [
        Expanded(
          child: Autocomplete<ObjectTitle>(
            initialValue: _initialValue,
            displayStringForOption: displayStringForOption,
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              _controller = textEditingController;
              return TextFormField(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    ),
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (value) => onFieldSubmitted(),
                onChanged: (value) {
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintText: widget.hint,

                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.arrow_drop_down_outlined),
                  // ),
                ),
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<ObjectTitle>.empty();
              }
              return widget.objectsList.where((element) {
                return element.title
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final ObjectTitle option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () => onSelected(option),
                          child: ListTile(
                            title: Text(
                              option.title,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (ObjectTitle selection) {
              widget.onSelected(selection);
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
          ),
        ),
        GestureDetector(
          onTap: () => _controller?.text = ' ',
          child: SizedBox(
            height: 32,
            width: 32,
            child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(Assets.coloredDownArrow)),
          ),
        ),
      ],
    );
  }
}
