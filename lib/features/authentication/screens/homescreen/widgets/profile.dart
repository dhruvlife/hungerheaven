import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/utils/constants/sizes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var sharedPref = GetStorage();

    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    String userId = "";

    name.text = sharedPref.read("name") ?? 'Hunger Heaven';
    email.text = sharedPref.read("email") ?? 'hunger.heaven@gmail.com';
    phone.text = sharedPref.read("phone") ?? '1234567890';
    userId = sharedPref.read("userId") ?? '12345678901234567890';

    Future<void> updateUserData(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(updatedData);
      sharedPref.write("name", name.text);
      sharedPref.write("email", email.text);
      sharedPref.write("phone", phone.text);
      Fluttertoast.showToast(msg: "Details Updated SuccessFully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error while updating your details");
      print("Error updating user data: $e");
      // Handle the error accordingly
    }
  }


    void updateUserInfo(String userId) {
      // Define the updated data
      Map<String, dynamic> updatedData = {
        "fullname": name.text,
        "email": email.text,
        "phone": phone.text,
        // Add other fields as needed
      };

      // Call the function to update the user data
      updateUserData(userId, updatedData);
    }
    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        //key: loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections / 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2.5,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Full Name",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  controller: email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    labelText: "Email",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  // initialValue: ,
                  controller: phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android_rounded),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                     updateUserInfo(userId);
                    },
                    child: const Text('Update Profile'),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

// Usage
}
