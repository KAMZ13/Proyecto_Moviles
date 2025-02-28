import 'package:flutter/material.dart';
import 'package:proyecto/pages/agenda.dart';
import 'package:proyecto/pages/bloc/tutoapp_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgendarTutoria extends StatefulWidget {
  const AgendarTutoria({super.key});

  @override
  State<AgendarTutoria> createState() => _AgendarTutoriaState();
}

class _AgendarTutoriaState extends State<AgendarTutoria> {
  final List<String> _horario = [
    '0900-1100',
    '1100-1300',
    '1300-1500',
    '1500-1700',
    '1700-1900',
    '1900-2100'
  ];
  String _hour = "Escoge el horario";
  String _date = "Escoge la fecha";
  var _help = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TutoApp - Agenda Una Tutoria",
          style: TextStyle(
              fontFamily: 'Chewy-Regular',
              fontSize: 24,
              color: Colors.amber[600]),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Icon(
                Icons.account_circle_rounded,
                size: 40,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TutoappBloc, TutoappState>(
          listener: (context, state) {
            if (state is TutoappSeeAgendState) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Agenda()));
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is TutoappAgendaChoiceState) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _data("Grado", state.grade),
                        _data("Materia", state.subject),
                      ],
                    ),
                  ),
                  _choices('Fecha', state.data_list, context),
                  _choices('Horario', _horario, context),
                  _description(),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TutoappBloc>(context).add(
                          TutoappCompleteAgendEvent(
                              hour: _hour,
                              date: _date,
                              description: _help.value.text));
                    },
                    child: Text("Agendar Tutoria"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Container _description() {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "En Que Necesitas Ayuda?",
            style: TextStyle(
                fontFamily: 'Chewy-Regular',
                fontSize: 32,
                color: Colors.blue[600]),
          ),
        ),
        TextField(
          controller: _help,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe una breve descripcion de tus dudas'),
        ),
      ]),
    );
  }

  Container _choices(String title, List<String> list_choice, context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Chewy-Regular',
                fontSize: 32,
                color: Colors.blue[600]),
            textAlign: TextAlign.left,
          ),
          Divider(
            thickness: 2,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                DropdownButton(
                  items: list_choice.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {
                    _hour = title == "Horario" ? value! : _hour;
                    _date = title == "Fecha" ? value! : _date;
                    setState(() {});
                  },
                  hint: Text(
                    title == "Horario" ? _hour : _date,
                    style: TextStyle(
                        fontFamily: 'Chewy-Regular',
                        color: Colors.amber[600],
                        fontSize: 20),
                  ),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: TextStyle(
                      fontFamily: 'Chewy-Regular', color: Colors.amber[600]),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.red,
          )
        ],
      ),
    );
  }

  Container _data(String title, dynamic data) {
    return Container(
        child: Column(children: [
      Text(
        title,
        style: TextStyle(
            fontFamily: 'Chewy-Regular', fontSize: 32, color: Colors.blue[600]),
        textAlign: TextAlign.left,
      ),
      Divider(
        thickness: 2,
        color: Colors.red,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Text(
              data,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Chewy-Regular',
                  fontSize: 24,
                  color: Colors.amber[600]),
            ),
          ],
        ),
      ),
    ]));
  }
}
