import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tg_app/screens/acccount.dart';
import 'package:tg_app/screens/appointment.dart';
import 'package:tg_app/screens/favorite.dart';
import 'package:tg_app/screens/home_page.dart';
import 'package:tg_app/screens/programme.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage2(),
    Programme(),
    const Favorite(),
    const Appointment(),
    const Acccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Color violet = const Color(0xff514eb6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: violet,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            final icons = [
              IconsaxPlusBroken.home_1,
              IconsaxPlusBroken.note,
              IconsaxPlusBroken.heart,
              IconsaxPlusBroken.message,
              IconsaxPlusBroken.profile,
            ];

            final isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons[index],
                  size: 25.sp,
                  color: isSelected ? violet : Colors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
