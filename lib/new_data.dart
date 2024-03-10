import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartAgriculture/camera_page.dart';
import 'package:smartAgriculture/services/notifi_service.dart';
import 'package:smartAgriculture/settings.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SmartDashBoard extends StatefulWidget {
  const SmartDashBoard({super.key});
  @override
  State<SmartDashBoard> createState() => _SmartDashBoardState();
}

class _SmartDashBoardState extends State<SmartDashBoard> {

   int _currentIndex = 0;
  final List<Widget> _pages = [
    const Dashboard(),
    const CameraPage(),
  
    Container(child:  Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Developed By Ritesh Bista'),
        ElevatedButton(onPressed: (){
 FirebaseAuth.instance.signOut();
        }, child: const Text('Sign Out'))
      ],
    ),)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      
      (backgroundColor: Colors.white,
        title: const Text('Smart Agriculture'),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, 
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                // Navigate to the home screen
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CameraPage()),
  );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to the settings screen
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SettingsPage()),
  );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Navigate to the about screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
       body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

 
}


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late bool checkMotorOn;
    @override
  void initState() {
    super.initState();

    fetchValueOfMotor();
    listenForFieldChanges();    
  }

 double sliderValue = 30;
  @override
  Widget build(BuildContext context) {
    return ListView(
  children: [
   
   
    StreamBuilder(
      stream: FirebaseFirestore.instance.collection('smartAgriculture').doc('farm1').snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }  
        var data = snapshot.data!;
        var humidity = data['humidity'];
        var isMotorOn = data['isMotorOn'];
        var soilMoisture = data['soil_moisture'];
        var temperature = data['temperature'];
        var waterLevel = data['water_level'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
        
              child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                _buildGridItem('Humidity', humidity, 'images/humidity.png', false),
                _buildGridItem('Motor Status', isMotorOn ? 1 : 0, 'images/motor.png', true),
                _buildGridItem('Soil Moisture(in %)', soilMoisture, 'images/moisture.png', false),
                _buildGridItem('Temperature', temperature, 'images/temperature.jpeg', false),
                _buildGridItem('water Level(in %)', waterLevel, 'images/water_level.jpeg', false),
              ],
            ),),
           
          ],
        );
      },
    ),
      
  ],
);

  }
   Widget _buildGridItem(String title, double value, String imagePath, bool isMotor) {
    return Container(
     
      child: Card(
    //  margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
       isMotor?SizedBox(
        width: 90,
        child: Image.asset('images/motor.png')): SizedBox(
              height: 130,
              child: SfRadialGauge(
                      axes: <RadialAxis>[
              RadialAxis(
                pointers: <GaugePointer>[
                  RangePointer(
                    value:value ,
                    width: 0.15,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.blue,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    animationDuration: 1500,
                  ),
                ],
              ), 
                      ],
                    ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 5.h),
            Text(
             isMotor? ( value == 0 )?'off':'on' : value.toString(),
              style: const TextStyle(fontSize: 13),
            ),
      
            SizedBox(height: 5.w),
         
      
          ],
        )),
    );
  }
  void listenForFieldChanges() {
    FirebaseFirestore.instance
        .collection('smartAgriculture')
        .doc('farm1')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
          var getWaterLevel = snapshot.get('water_level');
      var fieldValue = snapshot.get('isMotorOn'); // Replace 'fieldName' with your field name
      // Call your function based on the fieldValue
      if (fieldValue == true) {
         // Call your function here
         NotificationService()
                .showNotification(title: 'The motor is ', body:  "On");
      }
      else if (getWaterLevel<20){
         NotificationService()
                .showNotification(title: 'Water level is less than ', body:  "20%");
      }

    });
  }

Future<void> fetchValueOfMotor() async {
  
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('smartAgriculture')
          .doc('farm1')
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    checkMotorOn = data['isMotorOn'] ?? '';
        setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error fetching ip link: $error');
    }
  }
}