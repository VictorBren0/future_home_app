import 'package:flutter/material.dart';
import 'package:future_home_app/routes.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<ResidenceProvider>(
        context,
        listen: false,
      ).getResidences();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final residenceProvider = Provider.of<ResidenceProvider>(context);
    final residences = residenceProvider.residences;

    return Scaffold(
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
                              : ListView.builder(
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
