import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.icon,
    required this.text,
    required this.pgController,
    required this.page,
  });

  final PageController pgController;
  final int page;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pgController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(icon, size: 32, color: pgController.page!.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],),
              SizedBox(width: 22),
              Text(
                text,
                style: TextStyle(fontSize: 16, color: pgController.page!.round() == page ? Theme.of(context).primaryColor : Colors.grey[700], fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
