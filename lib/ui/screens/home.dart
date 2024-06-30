import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_teste/ui/screens/assets.dart';

import '../widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de unidades para serem exibidas como botões
  final List<String> units = ['jaguar', 'tobias', 'apex'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
          leading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: Column(
            children: units.map((unit) => _buildUnitButton(context, unit)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton(BuildContext context, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AssetsScreen(
                      unit: unit,
                    )),
          );
        },
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          backgroundColor: WidgetStateProperty.all(const Color(0xFF2188FF)),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 76)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            SvgPicture.asset(
              'assets/icons/AssetsIcon.svg',
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 16),
            Text(
              "${unit[0].toUpperCase()}${unit.substring(1)} Unit",
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
