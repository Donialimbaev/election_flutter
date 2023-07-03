import 'package:election_flutter/models/party.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dummy_data/constants.dart';
import 'bloc/party_bloc.dart';
import 'bloc/party_event.dart';
import 'bloc/party_state.dart';

class CandidateCard extends StatelessWidget {
  final int index;
  final candidate;

  CandidateCard({required this.index, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        int? selectedIndex = state.selectedCandidateIndex;

        bool isSelected = selectedIndex != null && index + 1 == selectedIndex;

        return Card(
          child: GestureDetector(
            onTap: () {
              context.read<PartyBloc>().add(
                    SelectCandidateEvent(candidateIndex: index + 1),
                  );

              context.read<PartyBloc>().add(
                    SelectCandidateNameEvent(
                        name:
                            '${candidate['firstname']} ${candidate['lastname']}'),
                  );
            },
            child: Container(
              height: isSelected ? 80 : 60,
              color: isSelected ? Colors.green : Colors.white,
              child: Container(
                child: ListTile(
                  leading: Text(
                    '${candidate['number']}',
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${candidate['firstname']}',
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${candidate['lastname']}',
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
