import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:users_app/widgets/my_drawer.dart';

import 'main_screen.dart';


class AboutScreen extends StatefulWidget
{
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}




class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(

        children: [

          //image
           Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/Ambulance2.png",
                width: 260,
              ),
            ),
          ),

          Column(
            children: [

              //company name
              const Text(
                "Medical Care Services",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //about you & your company - write some info
              const Text(
                "This app has been developed by Softtechz Technology, "
                "This is the Africa's number 1 Ambulance Requesting app. Available for all. "
                ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "This app has been developed by Softtechz Technology, "
                    "TThis is the Africa's number 1 Ambulance Requesting app. Available for all. "
                    ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //close
              ElevatedButton(
                onPressed: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => MainScreen ()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white54,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),

        ],

      ),
    );
  }
}
