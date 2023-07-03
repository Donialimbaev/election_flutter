import 'package:election_flutter/models/party.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dummy_data/constants.dart';
import 'bloc/party_bloc.dart';
import 'bloc/party_event.dart';
import 'bloc/party_state.dart';

class PartyCard extends StatelessWidget {
  final Party party;
  final int index;
  PartyCard({required this.party, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        int? selectedIndex = state.selectedPartyIndex;

        bool isSelected = selectedIndex != null && index + 1 == selectedIndex;

        return Card(
          child: GestureDetector(
            onTap: () {
              context.read<PartyBloc>().add(
                    SelectPartyEvent(
                        partyIndex: index + 1, partyID: party.id.toString(), ),
                  );

              context.read<PartyBloc>().add(
                    SelectPartyNameEvent(name: party.titleKyrgyz),
                  );
            },
            child: Container(
              height: isSelected ? 130 : 120,
              color: isSelected ? Colors.green : Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4 - 16,
                    child: Image.network(
                      party.image ?? imagePlaceholderUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(party.titleKyrgyz, textAlign: TextAlign.left),
                        Text(party.titleRussian, textAlign: TextAlign.left),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
