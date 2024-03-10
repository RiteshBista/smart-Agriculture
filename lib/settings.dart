import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smartAgriculture/services/notifi_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    bool light0 = true;
bool light1 = true;
  late bool isModeOn;
  late bool checkMotorOn;
  late bool isMotorButtonOn;
  @override
  void initState() {
    super.initState();
    fetchModeValue();
    fetchMotorButton();
    fetchValueOfMotor();
    
  }

Future<void> fetchModeValue() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('manauto')
          .doc('Mode')
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        isModeOn = data['mode'] ?? '';
        setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error fetching ip link: $error');
    }
  }

Future<void> fetchMotorButton() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('manauto')
          .doc('motorbutton')
          .get();


      if (documentSnapshot.exists) {
        // Get the value of the "ip_link" field
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        isMotorButtonOn = data['motorButton'] ?? '';
      
        setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error fetching ip link: $error');
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 50,),
        const SizedBox(height: 50,),
        Row(  
          children: [
             const SizedBox(width: 10,),
            const Text('Auto mode'),
             const SizedBox(width: 10,),
            Switch(
                  value: isModeOn,
                  onChanged: (bool value) async {
                  isModeOn = value;
                  updateMode(isModeOn);
                  setState(() {
                    
                  });
                }
            
              ),
              const SizedBox(width: 10,),
              const Text('Manual mode')
          ],
        ),
        
          const SizedBox(height: 50,),

      isModeOn?Row(
          children: [
            const SizedBox(width: 10,),
            const Text('motor off '),
            Switch(
                value: isMotorButtonOn,
                onChanged: (bool value) async {
                isMotorButtonOn = value;
                updateMotor(isMotorButtonOn);
                setState(() {
                  });
                    if(value == true){
                   NotificationService() .showNotification(title: 'The motor is ', body: "On");

                }
                else {
                    NotificationService() .showNotification(title: 'The motor is ', body: "Off");

                }
                }
        //         if(value == true){
        //            NotificationService()
        // //         .showNotification(title: 'The motor is ', body: checkMotorOn? "On":"off");

        //         }
              ),
              const SizedBox(width: 10,),
             const Text('motor On')
          ],
        ):Container(),
        
        // ElevatedButton(onPressed: (){}, child: const Text('Show motor status'),),
        // SizedBox(height: 20,),
        //     ElevatedButton(
        // onPressed: () {
        //  NotificationService()
        //         .showNotification(title: 'The motor is ', body: checkMotorOn? "On":"off");
        // },
        // child: const Text('Check value'),
        //     ),
          ],
        ),
      ),
    );
  }
    Future<void> updateMotor(bool newMode) async {
    try {
      await FirebaseFirestore.instance.collection('manauto').doc('motorbutton').update({
        'motorButton': newMode,
      });
    } catch (e) {
      print('Error updating mode: $e');
    }
  }
  Future<void> updateMode(bool newMode) async {
    try {
      await FirebaseFirestore.instance.collection('manauto').doc('Mode').update({
        'mode': newMode,
      });
    } catch (e) {
      print('Error updating mode: $e');
    }
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