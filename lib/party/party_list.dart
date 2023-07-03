import 'package:election_flutter/dummy_data/constants.dart';
import 'package:election_flutter/dummy_data/dummy_data_part.dart';
import 'package:election_flutter/models/party.dart';
import 'package:election_flutter/party/candidate_page.dart';
import 'package:election_flutter/party/party_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/party_bloc.dart';
import 'bloc/party_event.dart';
import 'bloc/party_state.dart';

class PartyList extends StatefulWidget {
  const PartyList({super.key});

  @override
  State<PartyList> createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        bool isSelected = state.selectedPartyIndex != null;

        List party_list = state.party_list;
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        print(state.selectedCandidateIndex!);
        print(isSelected);

        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemCount: party_list.length,
                  itemBuilder: (context, index) {
                    Party party = state.party_list[index];

                    return BlocProvider.value(
                      value: BlocProvider.of<PartyBloc>(context),
                      child: PartyCard(party: party, index: index),
                    );
                  },
                ),
              ),
              if (isSelected == true)
                Container(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 55,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: state.selectedPartyIndex == null
                                ? () {}
                                : () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: BlocProvider.of<PartyBloc>(
                                              context),
                                          child: CandidatteListPage(
                                            number: state.selectedPartyIndex
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                            child: const Text('Следующий'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
