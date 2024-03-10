// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:prasisapp/soil_model.dart';

// class AgricultureData extends StatefulWidget {
//   const AgricultureData({super.key, Key});

//   @override
//   _AgricultureDataState createState() => _AgricultureDataState();
// }

// class _AgricultureDataState extends State<AgricultureData> {
//   final Stream<QuerySnapshot> _gpsStream =
//       FirebaseFirestore.instance.collection('smartAgriculture').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _gpsStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           print('Error: ${snapshot.error}');
//           return const Scaffold(
//             body: Center(child: Text('Something went wrong')),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Agriculture Data'),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.all(16),
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data()! as Map<String, dynamic>;

//               double humidity = data['humidity'] != null
//                   ? double.parse(data['humidity'].toString())
//                   : 0.0;
//               double soilMoisture = data['soil_moisture'] != null
//                   ? double.parse(data['soil_moisture'].toString())
//                   : 0.0;
//   double temperature = data['temperature'] != null
//                   ? double.parse(data['temperature'].toString())
//                   : 0.0;
//                     double motorOn = data['motorOn'] != null
//                   ? double.parse(data['motorOn'].toString())
//                   : 0.0;

//                    SoilModel.soilModel.add(SoilModel(humidity, soilMoisture, motorOn, temperature));
//               return Container(
//                 height: 500,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 padding: const EdgeInsets.all(16),
//                 child:GridView.builder(

//           itemCount: 3,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 0.2,
//             crossAxisCount: 3,
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 12.0,
//           ),
//           itemBuilder: (context, index) {
//             final appSoilModel =
//                 SoilModel.soilModel[index];
//             return _buildGridViewContainer(appSoilModel);
//           },
//         ),
//     //              GridView.count(
//     //   crossAxisCount: 2, // Number of columns
//     //   children: List.generate(1, (index) {
//     //     return _buildGridViewContainer(SoilModel.soilModel[index]);
//     //     // Card(
//     //     //   elevation: 5,
//     //     //   margin: EdgeInsets.all(10),
//     //     //   child: Center(
//     //     //     child: Text(
//     //     //      humidity.toString(),
//     //     //       style: TextStyle(fontSize: 20),
//     //     //     ),
//     //     //   ),
//     //     // );
//     //   }),
//     // )
        
                
//   //                Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.center,
//   //                 children: [
//   //                   Container(
//   //                     width: 50,
//   //                     height: 50,
//   //                     child: Image.asset('images/humidity.png')),
//   //                   Text(
//   //                     'Humidity: $humidity',
//   //                     style: TextStyle(fontSize: 18),
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                    Container(
//   //                       width: 50,
//   //                     height: 50,
//   //                     child: Image.asset('images/soil_moisture.png')),
//   //                   Text(
//   //                     'Soil Moisture: $soilMoisture',
//   //                     style: TextStyle(fontSize: 18),
//   //                   ),
//   // Container(
//   //     width: 50,
//   //                     height: 50,
//   //   child: Image.asset('images/motor_icon.png')),
//   //                   Text(
//   //                     'Motor on: $soilMoisture',
//   //                     style: TextStyle(fontSize: 18),
//   //                   ),

//   //                   Container(
//   //     width: 50,
//   //                     height: 50,
//   //   child: Image.asset('images/temp.jpeg')),
//   //                   Text(
//   //                     'temperature: $temperature',
//   //                     style: TextStyle(fontSize: 18),
//   //                   ),
//   //                 ],
//   //               ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );


    
//   }
//  Widget _buildGridViewContainer(SoilModel soil){
//   return SizedBox(
//     height: 200,
//     child: GridView(
       
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//   ),
//   children: [
//    Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
   
//         child: Center(child: Text(soil.humidity.toString()))),
//        Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
  
//         child: Center(child: Text(soil.motorOn.toString()))),
//            Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    
//         child: Center(child: Text(soil.soiliMoisture.toString()))),
//            Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    
//         child: Center(child: Text(soil.temperature.toString()))),

//   ],
// )
    
//     // GridView(
//     //   child: Container(
//     //     decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//     //     width: 100,
//     //   height: 100,
//     //     child: Center(child: Text(soil.humidity.toString()))),
//     // ),
//   );
//  }
// }
