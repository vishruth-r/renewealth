import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  NavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)), // Adjust the radius as needed
      child: BottomAppBar(
        color: Colors.white,
        notchMargin: 10,
        child: Container(
          height: 81,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem(
                context: context,
                index: 0,
                icon: Icons.home,
                label: 'Home',
              ),
              buildTabItem(
                context: context,
                index: 1,
                icon: Icons.list,
                label: 'Listing',
              ),
              SizedBox.shrink(), // This is for the center empty space
              buildTabItem(
                context: context,
                index: 2,
                icon: Icons.chat,
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    Color color = currentIndex == index ? Color(0xFF65B741) : Color(0xFFA2A2A2);
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              onTap(index);
              Navigator.pushNamed(context, '/${index+1}');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: color),
                Text(
                  label,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}