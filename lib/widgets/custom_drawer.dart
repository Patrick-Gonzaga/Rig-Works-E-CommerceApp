import 'package:flutter/material.dart';

import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xABC0E8E8), Colors.white],
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
            child: ListView(
              children: [
                Container(height: 170, child: Stack(
                  children: [
                    Positioned(top: 12,
                        left: 0,
                        child: Text("Rig Works", style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),)),
                    Positioned(bottom: 12,
                        left: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Olá,", style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                          Text("Entre ou Cadastre-se >", style: TextStyle(color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold, fontSize: 20))
                        ],)),
                  ],
                ),),
                Divider(color: Colors.white,),
                DrawerTile(icon: Icons.home, text: "Home", pgController: pageController, page: 0,),
                DrawerTile(icon: Icons.list, text: "Pedidos",pgController: pageController, page: 1),
                DrawerTile(icon: Icons.location_on, text: 'Lojas',pgController: pageController, page: 2),
                DrawerTile(icon: Icons.playlist_add_check, text: 'Meus pedidos',pgController: pageController, page: 3)
              ],
            ),
          )
        ],
      ),
    );
  }
}
