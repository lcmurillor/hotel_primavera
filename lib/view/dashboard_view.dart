import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../services/services.dart';
import '../sources/sources.dart';
import '../themes/themes.dart';
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
          padding:
              const EdgeInsets.only(left: 100, right: 100, bottom: 30, top: 15),
          child: SingleChildScrollView(
            ///Tabla de datos donde se muestran los clientes.
            child: PaginatedDataTable(
              dataRowHeight: size.height * 0.055,
              columnSpacing: 40,
              horizontalMargin: 10,
              rowsPerPage: 10,
              showFirstLastButtons: true,
              sortAscending: clientProvider.ascending,
              sortColumnIndex: clientProvider.sortColumIndex,
              source: clientsDataSource,
              header: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child:

                      ///Este es el botón verde en la parte susperión para agregar nuevos
                      ///clientes al sistema.
                      PrimaryButton(
                          text: 'Agregar cliente',

                          ///Hace llamado al modal para ingresar los datos de un nuevo cliente.
                          onPressed: () => _showDialog(context))),
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
                const DataColumn(label: Text('Consultar')),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 10,
              title: Text("Agregar cliente",
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 35),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("¿Está seguro que desa cerrar la sesión actual?",
                    style: CustomTextStyle.robotoMedium,
                    textAlign: TextAlign.center)
              ]),

              ///Llama a las acciones (botones) para cerrar la sesión o continuar.
              ///Se envia la función para cerrar la sesión.
              actions: _actions(
                  context, () => FirebaseAuthService.signOut(context)));
        });
  }
}

///Esta lista corresponde a los dos botones que se encuentran en la parte inferior del cuadro de dialogo.
List<Widget> _actions(BuildContext context, void Function()? onPressed) {
  return [
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Aceptar',
            style: TextStyle(color: ColorStyle.mainGreen),
          )),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 20),
      child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(color: ColorStyle.errorRed),
          )),
    ),
  ];
}
