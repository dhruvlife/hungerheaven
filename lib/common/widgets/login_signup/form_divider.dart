import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:vision/utils/constants/colors.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:vision/utils/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    
    required this.dividerText,

  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark =THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark
                ? TColors.darkGrey
                : Color.fromARGB(255, 90, 90, 90),
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark
                ? TColors.darkGrey
                : Color.fromARGB(255, 90, 90, 90),
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}

