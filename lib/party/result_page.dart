import 'package:election_flutter/models/party.dart';
import 'package:election_flutter/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/party_bloc.dart';
import 'bloc/party_event.dart';
import 'bloc/party_state.dart';

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late PartyBloc partyBloc;

  @override
  void initState() {
    partyBloc = BlocProvider.of<PartyBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Ваш выбор',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          'Партия: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          state.partyName!,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          'Кандидат: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          state.candidateName!,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Назад'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 29,
                        ),
                        Container(
                          height: 55,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<PartyBloc>()
                                  .add(SendResultToServerEvent());

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));

                              final snackBar = SnackBar(
                                content: const Text('Спасибо за участие'),
                              );

                              print(state.selectedPartyID);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: const Text('Подтвердить'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
