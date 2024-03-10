import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String ipLink = '';
  late Uri websiteUri;
  @override
  void initState() {
    super.initState();
    fetchIpLink();
    _launchURL();
  }

Future<void> fetchIpLink() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Esp32cam')
          .doc('cam_ip')
          .get();
      if (documentSnapshot.exists) {
        // Get the value of the "ip_link" field
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        ipLink = data['ip_link'] ?? '';
         websiteUri = Uri.parse(ipLink);
      setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error fetching ip link: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                       onTap: _launchURL,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: 300.w,
                  height: 240.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                    8
                    ),
                    color: Colors.black,
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                       const Text('Live Camera',
                        
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                        Container(
                          color: Colors.red,
                          child: const Icon(Icons.camera)),
                      ],
                    ),
                   
                
                  ]),
                
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    _launchURL() async {
    final Uri url = Uri.parse('http://192.168.137.123/mjpeg/1');
    if (!await launch(url.toString())) {
      throw 'Could not launch $url';
    }
  }

}