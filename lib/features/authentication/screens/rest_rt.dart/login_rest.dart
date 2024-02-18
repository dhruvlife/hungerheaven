import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/screens/login/widgets/login_header.dart';
import 'package:vision/navigation_menu.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';

class RestLogin extends StatelessWidget {
  const RestLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold( // Scaffold is recommended for material design
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Restaurant Detail"),
          centerTitle: true,
        ),
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.sm),
                Text(
                  'Restaurant Detail',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Owner Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Owner Phone Number',
                    prefixIcon: Icon(Iconsax.call),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Restaurant E-mail Address',
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(NavigationMenu());
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
