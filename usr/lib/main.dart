import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ütopik Bina Projesi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        scaffoldBackgroundColor: const Color(0xFF000F24),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      home: const UtopianBuildingScreen(),
    );
  }
}

class UtopianBuildingScreen extends StatefulWidget {
  const UtopianBuildingScreen({super.key});

  @override
  State<UtopianBuildingScreen> createState() => _UtopianBuildingScreenState();
}

class _UtopianBuildingScreenState extends State<UtopianBuildingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            backgroundColor: Colors.transparent,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Arcology Nova'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.tealAccent.withOpacity(0.5),
                      Colors.purpleAccent.withOpacity(0.5),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_city,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildBuildingSection(
                  icon: Icons.eco,
                  title: 'Gökyüzü Bahçeleri',
                  description: 'Kendi kendine yeten, dikey tarım ve rekreasyon alanları.',
                  color: Colors.green,
                  delay: 0.2,
                ),
                _buildBuildingSection(
                  icon: Icons.power,
                  title: 'Enerji Çekirdeği',
                  description: 'Füzyon ve yenilenebilir kaynaklarla tüm binaya temiz enerji sağlar.',
                  color: Colors.amber,
                  delay: 0.4,
                ),
                _buildBuildingSection(
                  icon: Icons.water,
                  title: 'Su Geri Dönüşüm Sistemi',
                  description: 'Atmosferik nemden su toplayan ve %100 geri dönüşüm sağlayan sistem.',
                  color: Colors.blue,
                  delay: 0.6,
                ),
                _buildBuildingSection(
                  icon: Icons.groups,
                  title: 'Topluluk Alanları',
                  description: 'Sanat, kültür ve sosyal etkileşim için tasarlanmış ortak yaşam alanları.',
                  color: Colors.orange,
                  delay: 0.8,
                ),
                _buildBuildingSection(
                  icon: Icons.home_work,
                  title: 'Yaşam Kapsülleri',
                  description: 'Modüler ve kişiselleştirilebilir, doğa manzaralı konut birimleri.',
                  color: Colors.purple,
                  delay: 1.0,
                ),
                 _buildBuildingSection(
                  icon: Icons.science,
                  title: 'Araştırma Laboratuvarları',
                  description: 'Geleceğin teknolojilerinin geliştirildiği inovasyon merkezleri.',
                  color: Colors.cyan,
                  delay: 1.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuildingSection({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required double delay,
  }) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, 1.0, curve: Curves.easeOut),
        )),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: color.withOpacity(0.7), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: color,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(description, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
