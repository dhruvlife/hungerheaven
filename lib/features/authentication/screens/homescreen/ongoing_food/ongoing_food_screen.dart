import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class OnGoingOrderScreen extends StatelessWidget {
  final String restaurantId;

  const OnGoingOrderScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('food_details')
            .where('restaurantId', isEqualTo: restaurantId)
            .where('status', isEqualTo: 'ongoing')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show shimmer effect while loading
            return _buildShimmerEffect();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No ongoing orders found.'),
            );
          } else {
            // Data is loaded, build the UI
            return _buildOngoingOrdersList(snapshot.data!.docs);
          }
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // Number of shimmer items
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 56.0,
              height: 56.0,
              color: Colors.white,
            ),
            title: Container(
              height: 16.0,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 16.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildOngoingOrdersList(List<QueryDocumentSnapshot> documents) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        // Extract data from the document
        String imageLink = documents[index]['imagePath'];
        String itemName = documents[index]['foodName'];
        String itemCat = documents[index]['foodCategory'];
        String orderStatus = documents[index]['status'];

        return Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.black,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(imageLink,fit: BoxFit.cover,)
              ),
              ListTile(
                title: Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Text('Status: $orderStatus'),
                subtitle: Text(
                  itemCat,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
