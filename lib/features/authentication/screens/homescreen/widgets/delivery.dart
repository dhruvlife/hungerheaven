import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/utils/constants/sizes.dart';

class delivery extends StatelessWidget {
  const delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hey easy location"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.location_add),
                  labelText: "area",
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.location1),
                  labelText: "city",
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.location),
                  labelText: "district",
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Current Location'),
                ),
              ),
          
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
