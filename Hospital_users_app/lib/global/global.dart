import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAHXOWv2s:APA91bEBMWqTIWO9_xPJsa9dVw0HDJF1JskynEWpVUdjTwjQIKF-5glol4GJn67AjwU6AbllW4E_Ii8VXlAxAci1KxCbYlihAaQ_3W8Cj5RigRcUQ0MiTtbLutGr1k7qZEMz5G0OIXuW";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";