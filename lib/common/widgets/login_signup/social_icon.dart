import 'package:flutter/material.dart';
import 'package:vision/utils/constants/image_strings.dart';
import 'package:vision/utils/constants/sizes.dart';

class TSocialicon extends StatelessWidget {
  const TSocialicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 200, 200, 255)),
            borderRadius: BorderRadius.circular(150),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.google)),
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 200, 200, 255)),
            borderRadius: BorderRadius.circular(150),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.facebook)),
          ),
        ),
      ],
    );
  }
}
