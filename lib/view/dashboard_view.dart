import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../sources/sources.dart';
import '../widgets/widgets.dart';

class DashboardView extends StatelessWidget {
  ///Este widget corresponde a la página principal donde se ingresa una vez el usuario está
  ///registrado, se muestra la barra de busqueda y la lista disponible de cliente resgistrados
  ///la cual se puede filtrar, además de esto, se puede cargar rapidamente un nuevo cliente.
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clientProvider = Provider.of<ClientProvider>(context);
    final clientsDataSource = ClientDataTableSources(clientProvider.clients);

    ///Este contenedor muestra todo lo que se ve por debajo de la barra superiror (header).
    return SizedBox(
        width: size.width,
        height: size.height - 100,
        child: Container(
            padding: const EdgeInsets.only(
                left: 100, right: 100, bottom: 15, top: 15),
            child: SingleChildScrollView(

                ///Tabla de datos donde se muestran los clientes.
                child: PaginatedDataTable(
                    dataRowHeight: size.height * 0.065,
                    columnSpacing: 40,
                    horizontalMargin: 10,
                    rowsPerPage: 10,
                    showFirstLastButtons: true,
                    sortAscending: clientProvider.ascending,
                    sortColumnIndex: clientProvider.sortColumIndex,
                    source: clientsDataSource,
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
                        clientProvider
                            .sort<String>((client) => client.enterprise);
                      }),
                  const DataColumn(label: Text('Consultar'))
                ]))));
  }
}
