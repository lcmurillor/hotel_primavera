import 'package:flutter/material.dart';
import 'package:hotel_primavera_app/widgets/widgets.dart';

import '../providers/providers.dart';
import '../sources/sources.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clientProvider = Provider.of<ClientProvider>(context);
    final clientsDataSource = ClientDataTableSources(clientProvider.clients);
    return Container(
        width: size.width,
        height: size.height - 100,
        color: Colors.black,
        child: Container(
          width: 800,
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: PaginatedDataTable(
            sortAscending: clientProvider.ascending,
            sortColumnIndex: clientProvider.sortColumIndex,
            columns: [
              const DataColumn(label: Text('Imagen')),
              DataColumn(
                  label: const Text('Nombre'),
                  onSort: (index, __) {
                    clientProvider.sortColumIndex = index;
                    clientProvider.sort<String>((client) => client.name);
                  }),
              DataColumn(
                  label: const Text('Cédula'),
                  onSort: (index, __) {
                    clientProvider.sortColumIndex = index;
                    clientProvider
                        .sort<String>((client) => client.identification);
                  }),
              DataColumn(
                  label: const Text('Correo Electrónico'),
                  onSort: (index, __) {
                    clientProvider.sortColumIndex = index;
                    clientProvider.sort<String>((client) => client.email1);
                  }),
              DataColumn(
                  label: const Text('Teléfono'),
                  onSort: (index, __) {
                    clientProvider.sortColumIndex = index;
                    clientProvider
                        .sort<String>((client) => '${client.number1}');
                  }),
              DataColumn(
                  label: const Text('Empresa'),
                  onSort: (index, __) {
                    clientProvider.sortColumIndex = index;
                    clientProvider.sort<String>((client) => client.enterprise);
                  }),
              // const DataColumn(label: Text('UID')),
              const DataColumn(label: Text('Consultar')),
            ],
            source: clientsDataSource,
            // actions: [
            //   PrimaryButton(
            //       text: "Hola",
            //       onPressed: () {
            //         print('Hola');
            //       })
            // ],
            onPageChanged: (page) {
              //Imprimir la pagina en la que estamos
            },
          ),
        ));
  }
}
