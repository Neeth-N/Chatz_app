import 'package:flutter/material.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  void logout(){
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                          children: [
                          Icon(Icons.person_3_outlined),
                      SizedBox(width: 20,),
                      Text("Hello, ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                      Text("You", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                      ]
                    ),
                  ),
                  ),
                ],
              ),
              ),

          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text("H O M E"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(),)
                );
              },
            ),
          ),
    ],
    ),

          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),

        ],
      ),
    );
  }
}
