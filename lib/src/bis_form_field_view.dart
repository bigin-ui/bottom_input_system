import 'package:bottom_input_system/bottom_input_system.dart';
import 'package:bottom_input_system/src/extensions/sentro_icon_icons.dart';
import 'package:flutter/material.dart';

class BisFormFieldView extends StatelessWidget {
  final BisFormBuilderState? formBuilderState;
  final String name;
  final dynamic value;
  final String? hintText;
  final FieldType type;

  const BisFormFieldView({
    super.key,
    required this.formBuilderState,
    required this.name,
    required this.value,
    required this.hintText,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = name == formBuilderState?.currentFieldName;
    IconData iconData() {
      switch (type) {
        case FieldType.selection:
          return SentroIcon.field_selection;
        case FieldType.datepicker:
          return SentroIcon.field_date;
        default:
          return SentroIcon.field_text;
      }
    }

    return GestureDetector(
      onTap: () {
        formBuilderState?.activateBottomsheet(name);
      },
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.85)
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
              ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isActive ? const Color(0xffffffff) : const Color(0xfff2f2f2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Icon(
                  iconData(),
                  size: 28,
                  color: isActive
                      ? Theme.of(context).primaryColor
                      : const Color(0xff808080),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isActive
                            ? Theme.of(context).primaryColor
                            : value == null || value == ''
                                ? const Color(0xff333333)
                                : const Color(0xff808080),
                      ),
                    ),
                    value == null || value == ''
                        ? Text(
                            hintText ?? 'Enter a value',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff808080),
                            ),
                          )
                        : Text(
                            value.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff333333),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
