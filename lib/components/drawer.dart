import 'package:flutter/material.dart';
import 'package:socialtap/components/profile_list.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 70,
            ),
            ),

            MyList(icon: Icons.home, text: "H O M E",
            onTap: () => Navigator.pop(context)  ),

            MyList(icon: Icons.person, text: "P R O F I L E", 
            onTap: onProfileTap ,
            ),

            const SizedBox(
             height: 370,
            ),

             MyList(icon: Icons.person, text: "L O G O U T", 
            onTap: onSignOut ,
            )
          
          
        ],
      ),
      
    );
  }
}