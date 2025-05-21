import 'package:flutter/material.dart';
import 'package:future_home_app/models/residence_model.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/utils/calculate_scale.dart';
import 'package:future_home_app/widgets/scale_card.dart';
import 'package:future_home_app/widgets/session_details.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ResidenceModel? _residence;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isLoading) {
      final residenceArg =
          ModalRoute.of(context)!.settings.arguments as ResidenceModel?;
      if (residenceArg != null) {
        final residenceProvider = Provider.of<ResidenceProvider>(
          context,
          listen: false,
        );
        residenceProvider.getResidenceId(residenceArg.id).then((
          updatedResidence,
        ) {
          setState(() {
            _residence = updatedResidence;
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> handleDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: const Text(
              'Tem certeza que deseja excluir esta residência?',
            ),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (!mounted) return;

    if (shouldDelete == true && _residence != null) {
      await Provider.of<ResidenceProvider>(
        context,
        listen: false,
      ).deleteResidence(_residence!.id);

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  Future<void> _navigateToEdit() async {
    if (_residence == null) return;

    await Navigator.pushNamed(context, Routes.FORM, arguments: _residence);

    if (!mounted) return;

    final updated = await Provider.of<ResidenceProvider>(
      context,
      listen: false,
    ).getResidenceId(_residence!.id);

    if (!mounted) return;

    setState(() {
      _residence = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_residence == null) {
      return const Scaffold(
        body: Center(child: Text('Residência não encontrada')),
      );
    }

    final residence = _residence!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _navigateToEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: handleDelete),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: Column(
                    children: [
                      Icon(
                        residence.typeResidence == "casa"
                            ? Icons.home
                            : residence.typeResidence == "apartamento"
                            ? Icons.apartment
                            : Icons.error,
                        size: 80,
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        residence.typeResidence == "casa"
                            ? "Casa"
                            : residence.typeResidence == "apartamento"
                            ? "Apartamento"
                            : "Tipo não disponível",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Criado em: ${DateFormat('dd/MM/yyyy - kk:mm').format(residence.createdAt)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                          if (residence.updatedAt != null)
                            Text(
                              'Atualizado em: ${DateFormat('dd/MM/yyyy - kk:mm').format(residence.updatedAt!)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ScaleCard(
                        calculateScale([
                          residence.rtAddress,
                          residence.rtDetailsResidence,
                          residence.rtSeller,
                        ]),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SessionCardDetails(
                          rating: residence.rtAddress,
                          title: 'Avaliação do Endereço:',
                          details: [
                            {'label': 'Endereço', 'value': residence.address},
                            {
                              'label': 'Bairro',
                              'value': residence.neighborhood,
                            },
                          ],
                        ),
                        const SizedBox(height: 16),
                        SessionCardDetails(
                          rating: residence.rtDetailsResidence,
                          title: 'Avaliação dos Detalhes:',
                          details: [
                            {
                              'label': 'Nº de Quartos',
                              'value': residence.nrRooms,
                            },
                            {
                              'label': 'Nº de Banheiros',
                              'value': residence.nrBathrooms,
                            },
                            {
                              'label': 'Vaga na Garagem',
                              'value': residence.nrGarages,
                            },
                            {
                              'label': 'Possui Piscina',
                              'value': residence.flPool,
                            },
                          ],
                        ),
                        const SizedBox(height: 16),
                        SessionCardDetails(
                          rating: residence.rtSeller,
                          title: 'Avaliação da Venda:',
                          details: [
                            {
                              'label': 'Nome do Vendedor',
                              'value':
                                  residence.nmSeller.isNotEmpty
                                      ? residence.nmSeller
                                      : '-',
                            },
                            {
                              'label': 'Telefone do Vendedor',
                              'value':
                                  residence.phoneSeller.isNotEmpty
                                      ? residence.phoneSeller
                                      : '-',
                            },
                            {
                              'label': 'Preço',
                              'value': NumberFormat.simpleCurrency(
                                locale: 'pt_BR',
                              ).format(residence.price),
                            },
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Criado em: ${DateFormat('dd/MM/yyyy - kk:mm').format(residence.createdAt)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        if (residence.updatedAt != null)
                          Text(
                            'Atualizado em: ${DateFormat('dd/MM/yyyy - kk:mm').format(residence.updatedAt!)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                      ],
                    ),
                    ScaleCard(
                      calculateScale([
                        residence.rtAddress,
                        residence.rtDetailsResidence,
                        residence.rtSeller,
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Center(
                  child: Column(
                    children: [
                      Icon(
                        residence.typeResidence == "casa"
                            ? Icons.home
                            : residence.typeResidence == "apartamento"
                            ? Icons.apartment
                            : Icons.error,
                        size: 80,
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        residence.typeResidence == "casa"
                            ? "Casa"
                            : residence.typeResidence == "apartamento"
                            ? "Apartamento"
                            : "Tipo de residência não disponível",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SessionCardDetails(
                  rating: residence.rtAddress,
                  title: 'Avaliação do Endereço:',
                  details: [
                    {'label': 'Endereço', 'value': residence.address},
                    {'label': 'Bairro', 'value': residence.neighborhood},
                  ],
                ),
                const SizedBox(height: 16),
                SessionCardDetails(
                  rating: residence.rtDetailsResidence,
                  title: 'Avaliação dos Detalhes:',
                  details: [
                    {'label': 'Nº de Quartos', 'value': residence.nrRooms},
                    {
                      'label': 'Nº de Banheiros',
                      'value': residence.nrBathrooms,
                    },
                    {'label': 'Vaga na Garagem', 'value': residence.nrGarages},
                    {'label': 'Possui Piscina', 'value': residence.flPool},
                  ],
                ),
                const SizedBox(height: 16),
                SessionCardDetails(
                  rating: residence.rtSeller,
                  title: 'Avaliação da Venda:',
                  details: [
                    {
                      'label': 'Nome do Vendedor',
                      'value':
                          residence.nmSeller.isNotEmpty
                              ? residence.nmSeller
                              : '-',
                    },
                    {
                      'label': 'Telefone do Vendedor',
                      'value':
                          residence.phoneSeller.isNotEmpty
                              ? residence.phoneSeller
                              : '-',
                    },
                    {
                      'label': 'Preço',
                      'value': NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                      ).format(residence.price),
                    },
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
