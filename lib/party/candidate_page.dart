import 'package:election_flutter/dummy_data/candidates_from_party.dart';
import 'package:election_flutter/models/party.dart';
import 'package:election_flutter/party/candidate_card.dart';
import 'package:election_flutter/party/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/party_bloc.dart';
import 'bloc/party_state.dart';

class CandidatteListPage extends StatefulWidget {
  final String number;
  CandidatteListPage({
    required this.number,
  });

  @override
  State<CandidatteListPage> createState() => _CandidatteListPageState();
}

class _CandidatteListPageState extends State<CandidatteListPage> {
  @override
  Widget build(BuildContext context) {
    var candidates = candidates_form_party['party${widget.number}'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите кандидита'),
      ),
      body: BlocBuilder<PartyBloc, PartyState>(
        builder: (context, state) {
          bool isSelected = state.selectedCandidateIndex != null;
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemCount: candidates!.length,
                  itemBuilder: ((context, index) {
                    var candidate = candidates!.values.elementAt(index);

                    return BlocProvider.value(
                      value: BlocProvider.of<PartyBloc>(context),
                      child: CandidateCard(index: index, candidate: candidate),
                    );
                  }),
                ),
              ),
              if (isSelected == true)
                Container(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        Container(
                          height: 55,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: state.selectedPartyIndex == null
                                ? null
                                : () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: BlocProvider.of<PartyBloc>(
                                              context),
                                          child: ResultPage(),
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
          );
        },
      ),
    );
  }
}
