class ResidenceModel {
  String id;
  String typeResidence;
  String address;
  String neighborhood;
  int rtAddress;
  String nrRooms;
  String nrBathrooms;
  String nrGarages;
  String flPool;
  int rtDetailsResidence;
  String nmSeller;
  String phoneSeller;
  double price;
  int rtSeller;
  DateTime createdAt;
  DateTime? updatedAt;

  ResidenceModel({
    required this.id,
    required this.typeResidence,
    required this.address,
    required this.neighborhood,
    required this.rtAddress,
    required this.nrRooms,
    required this.nrBathrooms,
    required this.nrGarages,
    required this.flPool,
    required this.rtDetailsResidence,
    required this.nmSeller,
    required this.phoneSeller,
    required this.price,
    required this.rtSeller,
    required this.createdAt,
    this.updatedAt,
  });

  factory ResidenceModel.fromMap(Map<String, dynamic> map) {
    return ResidenceModel(
      id: map['id'],
      typeResidence: map['type_residence'],
      address: map['address'],
      neighborhood: map['neighborhood'],
      rtAddress: map['rt_address'],
      nrRooms: map['nr_rooms'],
      nrBathrooms: map['nr_bathrooms'],
      nrGarages: map['nr_garages'],
      flPool: map['fl_pool'],
      rtDetailsResidence: map['rt_details_residence'],
      nmSeller: map['nm_seller'],
      phoneSeller: map['phone_seller'],
      price: map['price'],
      rtSeller: map['rt_seller'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type_residence': typeResidence,
      'address': address,
      'neighborhood': neighborhood,
      'rt_address': rtAddress,
      'nr_rooms': nrRooms,
      'nr_bathrooms': nrBathrooms,
      'nr_garages': nrGarages,
      'fl_pool': flPool,
      'rt_details_residence': rtDetailsResidence,
      'nm_seller': nmSeller,
      'phone_seller': phoneSeller,
      'price': price,
      'rt_seller': rtSeller,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
