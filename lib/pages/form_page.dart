import 'package:flutter/material.dart';
import 'package:future_home_app/models/residence_model.dart';
import 'package:future_home_app/utils/generate_unique_id.dart';
import 'package:future_home_app/widgets/list_type_residence.dart';
import 'package:future_home_app/widgets/location_button.dart';
import 'package:future_home_app/widgets/select.dart';
import 'package:future_home_app/widgets/stars_rating.dart';
import 'package:intl/intl.dart';
import '../widgets/input.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';
import 'package:vb_formatters/vb_formatters.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final ResidenceModel residence = ResidenceModel(
    id: '',
    typeResidence: 'casa',
    address: '',
    neighborhood: '',
    rtAddress: 0,
    nrRooms: '',
    nrBathrooms: '',
    nrGarages: '',
    flPool: '',
    rtDetailsResidence: 0,
    nmSeller: '',
    phoneSeller: '',
    price: 0.0,
    rtSeller: 0,
    createdAt: DateTime.now(),
    updatedAt: null,
  );
  final _formKey = GlobalKey<FormState>();
  final List<String> _options = ["Não Possui", "1", "2", "3", "4", "5"];

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _nmSellerController = TextEditingController();
  final TextEditingController _phoneSellerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool isLoaded = false;

  @override
  void dispose() {
    _addressController.dispose();
    _neighborhoodController.dispose();
    _nmSellerController.dispose();
    _phoneSellerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> handleSave() async {
    if (residence.id.isEmpty) {
      residence.id = generateUniqueId();
      Provider.of<ResidenceProvider>(
        context,
        listen: false,
      ).postResidence(residence);
      Navigator.pop(context);
      return;
    }
    Provider.of<ResidenceProvider>(
      context,
      listen: false,
    ).putResidence(residence);
    Navigator.pop(context, residence);
  }

  @override
  Widget build(BuildContext context) {
    final residenceEdit =
        ModalRoute.of(context)!.settings.arguments as ResidenceModel?;
    if (residenceEdit != null && !isLoaded) {
      residence.id = residenceEdit.id;
      residence.typeResidence = residenceEdit.typeResidence;
      residence.address = residenceEdit.address;
      residence.neighborhood = residenceEdit.neighborhood;
      residence.rtAddress = residenceEdit.rtAddress;
      residence.nrRooms = residenceEdit.nrRooms;
      residence.nrBathrooms = residenceEdit.nrBathrooms;
      residence.nrGarages = residenceEdit.nrGarages;
      residence.flPool = residenceEdit.flPool;
      residence.rtDetailsResidence = residenceEdit.rtDetailsResidence;
      residence.nmSeller = residenceEdit.nmSeller;
      residence.phoneSeller = residenceEdit.phoneSeller;
      residence.price = residenceEdit.price;
      residence.rtSeller = residenceEdit.rtSeller;
      residence.createdAt = residenceEdit.createdAt;
      residence.updatedAt = DateTime.now();

      _addressController.text = residence.address;
      _neighborhoodController.text = residence.neighborhood;
      _nmSellerController.text = residence.nmSeller;
      _phoneSellerController.text = residence.phoneSeller;
      _priceController.text = NumberFormat.simpleCurrency(
        locale: 'pt_BR',
      ).format(residence.price);

      isLoaded = true;
    }

    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          residenceEdit != null ? "Editar Avaliação" : 'Criar Avaliação',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white10),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Escolha o tipo de Residência:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                ListTypeResidence(
                  onChange: (value) {
                    setState(() {
                      residence.typeResidence = value;
                    });
                  },
                  selected: residence.typeResidence,
                ),
                const SizedBox(height: 16),
                Text(
                  'Endereço da Residência:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                LocationButton(
                  addressController: _addressController,
                  neighborhoodController: _neighborhoodController,
                  residence: residence,
                ),
                orientation == Orientation.landscape
                    ? Row(
                      children: [
                        Expanded(
                          child: Input(
                            controller: _addressController,
                            label: "Endereço",
                            isRequired: true,
                            onChange: (value) {
                              residence.address = value;
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Input(
                            controller: _neighborhoodController,
                            label: "Bairro",
                            isRequired: true,
                            onChange: (value) {
                              residence.neighborhood = value;
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
                    : Column(
                      children: [
                        Input(
                          controller: _addressController,
                          label: "Endereço",
                          isRequired: true,
                          onChange: (value) {
                            residence.address = value;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Input(
                          controller: _neighborhoodController,
                          label: "Bairro",
                          isRequired: true,
                          onChange: (value) {
                            residence.neighborhood = value;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Avaliação:",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    StarsRating(
                      rating: residence.rtAddress,
                      onChange: (value) {
                        setState(() {
                          residence.rtAddress = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Detalhes da Residência:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Select(
                        label: "Nº de Quartos",
                        isRequired: true,
                        options: _options,
                        value: residence.nrRooms,
                        onChange: (value) {
                          residence.nrRooms = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Select(
                        label: "Nº de Banheiros",
                        isRequired: true,
                        options: _options,
                        value: residence.nrBathrooms,
                        onChange: (value) {
                          residence.nrBathrooms = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Select(
                        label: "Vaga na Garagem",
                        isRequired: true,
                        options: _options,
                        value: residence.nrGarages,
                        onChange: (value) {
                          residence.nrGarages = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Select(
                        label: "Possui Piscina",
                        isRequired: true,
                        options: ["Sim", "Não"],
                        value: residence.flPool,
                        onChange: (value) {
                          residence.flPool = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Avaliação:",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    StarsRating(
                      rating: residence.rtDetailsResidence,
                      onChange: (value) {
                        setState(() {
                          residence.rtDetailsResidence = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Informações da Venda:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                orientation == Orientation.landscape ?
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Input(
                        controller: _nmSellerController,
                        label: "Nome do Vendedor",
                        onChange: (value) {
                          residence.nmSeller = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Input(
                        controller: _phoneSellerController,
                        label: "Telefone",
                        inputFormatters: [phoneInputFormatter()],
                        keyboardType: TextInputType.phone,
                        onChange: (value) {
                          residence.phoneSeller = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Input(
                        controller: _priceController,
                        label: "Preço",
                        inputFormatters: [moneyInputFormatter()],
                        keyboardType: TextInputType.number,
                        onChange: (value) {
                          final cleaned = value.replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );
                          if (cleaned.isNotEmpty) {
                            residence.price = double.parse(cleaned) / 100;
                          }
                        },
                      ),
                    ),
                  ],
                )
                : Column(
                  children: [
                    Input(
                      controller: _nmSellerController,
                      label: "Nome do Vendedor",
                      onChange: (value) {
                        residence.nmSeller = value;
                      },
                    ),
                    const SizedBox(height: 12),
                    Input(
                      controller: _phoneSellerController,
                      label: "Telefone",
                      inputFormatters: [phoneInputFormatter()],
                      keyboardType: TextInputType.phone,
                      onChange: (value) {
                        residence.phoneSeller = value;
                      },
                    ),
                    const SizedBox(height: 12),
                    Input(
                      controller: _priceController,
                      label: "Preço",
                      inputFormatters: [moneyInputFormatter()],
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        final cleaned = value.replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        );
                        if (cleaned.isNotEmpty) {
                          residence.price = double.parse(cleaned) / 100;
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Avaliação:",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    StarsRating(
                      rating: residence.rtSeller,
                      onChange: (value) {
                        setState(() {
                          residence.rtSeller = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        handleSave();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
