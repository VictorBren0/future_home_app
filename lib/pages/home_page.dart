import 'package:flutter/material.dart';
import 'package:future_home_app/providers/auth_provider.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/utils/calculate_scale.dart';
import 'package:future_home_app/widgets/item_card.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';

//https://api.open-meteo.com/v1/forecast?latitude=-10.926979&longitude=-37.071267&current=temperature_2m
//http://www.geoplugin.net/json.gp

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => loadResidences());
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
        title: const Image(
          image: AssetImage('assets/images/logo.png'),
          height: 40,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
