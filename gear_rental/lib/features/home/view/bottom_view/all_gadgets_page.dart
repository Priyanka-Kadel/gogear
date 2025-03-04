// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';

// class AllGadgetsPage extends StatefulWidget {
//   const AllGadgetsPage({super.key});

//   @override
//   State<AllGadgetsPage> createState() => _AllGadgetsPageState();
// }

// class _AllGadgetsPageState extends State<AllGadgetsPage> {
//   late Future<List<dynamic>> _gadgetsFuture;
//   final AuthRemoteDataSource authDataSource = AuthRemoteDataSource(Dio());

//   @override
//   void initState() {
//     super.initState();
//     _gadgetsFuture = authDataSource.getProducts();
//     ();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       appBar: AppBar(
//         title: const Text("Explore All Gears",
//             style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: _gadgetsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, color: Colors.red, size: 50),
//                   SizedBox(height: 10),
//                   Text(
//                     "Failed to load gadgets cc",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     "Please try again later.",
//                     style: TextStyle(color: Colors.white70, fontSize: 14),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text("No gadgets available",
//                   style: TextStyle(color: Colors.white)),
//             );
//           }
//           print(snapshot.data);
//           List<dynamic> gadgets = snapshot.data!;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // 2 items per row
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.8,
//               ),
//               itemCount: gadgets.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     gadgets[index]['imageUrl'] = gadgets[index]['imageUrl']!
//                         .replaceAll('localhost', '10.0.2.2');
//                     _showGadgetDetails(context, gadgets[index]);
//                   },
//                   child: GadgetCard(
//                     imagePath: gadgets[index]['imageUrl']!,
//                     name: gadgets[index]['name']!,
//                     price: gadgets[index]['price'].toString(),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showGadgetDetails(BuildContext context, dynamic gadget) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           title: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               gadget['name']!,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           content: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Display product image
//                 Image.network(
//                   gadget['imageUrl']!,
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(height: 16),

//                 // Display product description
//                 Text(
//                   gadget['description'] ?? 'No description available.',
//                   style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 16),

//                 // Display product price
//                 Text(
//                   'NPR ${gadget['price']}',
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 24),

//                 // "Add to Cart" button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 14, horizontal: 32),
//                     backgroundColor: Colors.green[700], // Cart button color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // Close the dialog
//                     // Show cart added notification
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('${gadget['name']} added to cart'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Add to Cart',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // void _showGadgetDetails(BuildContext context, dynamic gadget) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: Text(gadget['name']!),
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Image.network(gadget['imageUrl']!, height: 150),
//   //             const SizedBox(height: 10),
//   //             Text(gadget['price'].toString(),
//   //                 style: const TextStyle(fontSize: 18)),
//   //           ],
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context),
//   //             child: const Text("Close"),
//   //           )
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }

// class GadgetCard extends StatelessWidget {
//   final String imagePath;
//   final String name;
//   final String price;

//   const GadgetCard({
//     super.key,
//     required this.imagePath,
//     required this.name,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         children: [
//           Expanded(
//             child: Image.network(
//               imagePath.replaceAll('localhost', '10.0.2.2'),
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.broken_image, size: 50, color: Colors.grey),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text(name,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold)),
//                 Text(price,
//                     style: const TextStyle(fontSize: 14, color: Colors.grey)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async'; // For inactivity timer

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:proximity_sensor/proximity_sensor.dart'; // Import proximity sensor package

class AllGadgetsPage extends StatefulWidget {
  const AllGadgetsPage({super.key});

  @override
  State<AllGadgetsPage> createState() => _AllGadgetsPageState();
}

class _AllGadgetsPageState extends State<AllGadgetsPage> {
  late Future<List<dynamic>> _gadgetsFuture;
  final AuthRemoteDataSource authDataSource = AuthRemoteDataSource(Dio());

  Timer? _inactiveTimer; // Timer for inactivity
  bool _isInactive = false; // Flag to track inactivity

  @override
  void initState() {
    super.initState();
    _gadgetsFuture = authDataSource.getProducts();

    // Initialize proximity sensor and listener for activity detection
    ProximitySensor.events.listen((event) {
      if (event == false) {
        // User is far from the sensor, reset inactivity timer
        _resetInactivityTimer();
      }
    });

    // Start inactivity timer when the page is loaded
    _resetInactivityTimer();
  }

  @override
  void dispose() {
    _inactiveTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Method to reset the inactivity timer
  void _resetInactivityTimer() {
    // Cancel any existing timers
    _inactiveTimer?.cancel();

    // Start a new timer
    _inactiveTimer = Timer(const Duration(seconds: 10), _showInactivityAlert);
  }

  // Method to show an inactivity alert
  void _showInactivityAlert() {
    if (!_isInactive) {
      setState(() {
        _isInactive = true;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Inactive User'),
            content:
                const Text('You have been inactive for more than 10 seconds!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isInactive = false;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Explore All Gears",
            style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _gadgetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Failed to load gadgets",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please try again later.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No gadgets available",
                  style: TextStyle(color: Colors.white)),
            );
          }

          List<dynamic> gadgets = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: gadgets.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    gadgets[index]['imageUrl'] = gadgets[index]['imageUrl']!
                        .replaceAll('localhost', '10.0.2.2');
                    _showGadgetDetails(context, gadgets[index]);
                  },
                  child: GadgetCard(
                    imagePath: gadgets[index]['imageUrl']!,
                    name: gadgets[index]['name']!,
                    price: gadgets[index]['price'].toString(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showGadgetDetails(BuildContext context, dynamic gadget) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gadget['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display product image
                Image.network(
                  gadget['imageUrl']!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                // Display product description
                Text(
                  gadget['description'] ?? 'No description available.',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Display product price
                Text(
                  'NPR ${gadget['price']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // "Add to Cart" button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    backgroundColor: Colors.green[700], // Cart button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    // Show cart added notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${gadget['name']} added to cart'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GadgetCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const GadgetCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imagePath.replaceAll('localhost', '10.0.2.2'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(price,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
