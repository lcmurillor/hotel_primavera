import 'package:flutter/material.dart';
import 'package:hotel_primavera_app/widgets/widgets.dart';
import 'package:image_network/image_network.dart';
import '../models/models.dart';
import '../services/services.dart';

///Esta función permite cargar las tablas con los datos de los clientes que se extraen
///de base de datos. Construyenndo una lista de clientes y separando cada columna y definiendo
///que datos muestra en cada una.
class ClientDataTableSources extends DataTableSource {
  final List<Client> clients;

  ClientDataTableSources(this.clients);

  @override
  DataRow getRow(int index) {
    final Client client = clients[index];
    final image = client.imageUrl != "N/A"
        ? ImageNetwork(
            image: client.imageUrl,
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(100.00))
        : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('not_image.png'),
          );

    return DataRow.byIndex(index: index, cells: [
      DataCell(CircleAvatar(
        backgroundColor: Colors.transparent,
        child: image,
      )),
      DataCell(Text(client.name)),
      DataCell(Text(client.identification)),
      DataCell(Text(client.email1)),
      DataCell(Text('${client.number1}')),
      DataCell(Text(client.enterprise)),
      DataCell(SecundaryButton(
          text: 'Consultar cliente',
          onPressed: () {
            NavigationService.navigateTo(
                '/dashboard/clients/${client.identification}');
          }))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => 0;
}
