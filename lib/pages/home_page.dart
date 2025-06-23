import 'package:flutter/material.dart';
import 'package:future_home_app/providers/auth_provider.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/services/weather_service.dart';
import 'package:future_home_app/utils/calculate_scale.dart';
import 'package:future_home_app/widgets/item_card.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String? currentTemperature;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await loadResidences();
      await loadTemperature();
    });
  }

  Future<void> loadTemperature() async {
    final weatherService = WeatherService();
    final location = await weatherService.getLocationInfo();

    if (location == null) return;

    final lat = double.tryParse(location['geoplugin_latitude'] ?? '');
    final lon = double.tryParse(location['geoplugin_longitude'] ?? '');

    if (lat != null && lon != null) {
      final temp = await weatherService.getCurrentTemperature(lat, lon);
      if (temp != null && mounted) {
        setState(() {
          currentTemperature = '${temp.toStringAsFixed(1)}°C';
        });
      }
    }
  }

  Future<void> loadResidences() async {
    await Provider.of<ResidenceProvider>(
      context,
      listen: false,
    ).getResidences();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final residenceProvider = Provider.of<ResidenceProvider>(context);
    final residences = residenceProvider.residences;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          authProvider.logout();
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, Routes.LOGIN);
        },
        backgroundColor: Colors.redAccent,
        tooltip: 'Sair',
        child: const Icon(Icons.logout, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 40,
            ),
            const SizedBox(width: 10),
            if (currentTemperature != null)
              Text(
                currentTemperature!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            color: Colors.white,
            onPressed: () async {
              await Navigator.pushNamed(context, Routes.FORM);
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                decoration: const BoxDecoration(color: Colors.white10),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sua lista de Residencias',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child:
                          residences.isEmpty
                              ? const Center(
                                child: Text('Nenhuma residência cadastrada.'),
                              )
                              : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          orientation == Orientation.portrait
                                              ? 1
                                              : 2,
                                      //mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 3.5,
                                    ),
                                itemCount: residences.length,
                                itemBuilder: (context, index) {
                                  final item = residences[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: ItemCard(
                                      title: item.address,
                                      subtitle: item.neighborhood,
                                      value: item.price,
                                      scaleId: calculateScale([
                                        item.rtAddress,
                                        item.rtDetailsResidence,
                                        item.rtSeller,
                                      ]),
                                      date: item.createdAt,
                                      isHome: item.typeResidence == 'casa',
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.DETAILS,
                                          arguments: item,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
    );
  }
}
