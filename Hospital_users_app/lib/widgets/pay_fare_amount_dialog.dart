import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:users_app/mainScreens/main_screen.dart';


class PayFareAmountDialog extends StatefulWidget
{




  @override
  State<PayFareAmountDialog> createState() => _PayFareAmountDialogState();
}




class _PayFareAmountDialogState extends State<PayFareAmountDialog>
{
  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: Colors.grey,
      child: Container(
        margin: const EdgeInsets.all(6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 20,),

            const Divider(
              thickness: 4,
              color: Colors.grey,
            ),


            const SizedBox(height: 10,),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "You Have reached you destination, Thank you for using our services.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: ()
                {
                  Future.delayed(const Duration(milliseconds: 2000), ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => MainScreen ()));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "End Trip",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 4,),

          ],
        ),
      ),
    );
  }
}
