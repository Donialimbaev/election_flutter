/* External Dependencies */
import 'dart:async';
import 'dart:convert';
import 'package:election_flutter/dummy_data/candidates_from_party.dart';
import 'package:election_flutter/dummy_data/dummy_data_part.dart';
import 'package:election_flutter/models/party.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;

/* Local Dependencies */
import './party_event.dart';
import './party_state.dart';

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  PartyBloc() : super(PartyState()) {
    on<FetchPartyListEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await _fetchPartyList());
      },
      transformer: droppable(),
    );

    on<SelectPartyEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await selectParty(event.partyIndex, event.partyID));
      },
      transformer: droppable(),
    );

    on<SelectCandidateEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await selectCandidate(event.candidateIndex));
      },
      transformer: droppable(),
    );

    on<SelectCandidateNameEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await selectCandidateName(event.name));
      },
      transformer: droppable(),
    );

    on<SelectPartyNameEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await selectPartyName(event.name));
      },
      transformer: droppable(),
    );

    on<SendResultToServerEvent>(
      (event, emit) async {
        emit(state.cloneWith(
          loading: true,
        ));

        emit(await uploadData());
      },
      transformer: droppable(),
    );
  }

  Future<PartyState> _fetchPartyList() async {
    // candidates_form_party.forEach((key, value) {
    //   value.forEach((key, value1) async {
    //     await http.post(
    //       Uri.parse(
    //           'https://electionflutter-default-rtdb.asia-southeast1.firebasedatabase.app/candidates_list.json'),
    //       body: json.encode({
    //         'firstname': value1['firstname'],
    //         'lastname': value1['lastname'],
    //         'number': value1['number'],
    //         'count': '0',
    //       }),
    //     );
    //   });l
    // });

    final response = await http.get(
      Uri.parse(
          'https://electionflutter-default-rtdb.asia-southeast1.firebasedatabase.app/party_list.json'),
    );

    final Map _party = json.decode(response.body);
    print(_party);
    List<Party> _party_list = [];

    _party.forEach((key, value) {
      _party_list.add(Party(
        number: int.parse(value['number']),
        titleKyrgyz: value['partyName'],
        titleRussian: value['partyName'],
        id: value['id'],
        image: value['image'],
      ));
    });

    try {
      return state.cloneWith(
        party_list: _party_list,
        loading: false,
      );
    } catch (err) {
      print(err);

      return state.cloneWith(
        loading: false,
      );
    }
  }

  Future<PartyState> selectParty(int partyIndex, String partyID) async {
    try {
      return state.cloneWith(
        selectedPartyIndex: partyIndex,
        selectedPartyID: partyID,
        loading: false,
      );
    } catch (err) {
      print(err);
      return state.cloneWith(
        loading: false,
      );
    }
  }

  Future<PartyState> selectCandidate(int candidateIndex) async {
    // await Duration(seconds: 5);

    try {
      return state.cloneWith(
        selectedCandidateIndex: candidateIndex,
        loading: false,
      );
    } catch (err) {
      print(err);
      return state.cloneWith(
        loading: false,
      );
    }
  }

  Future<PartyState> selectCandidateName(String name) async {
    // await Duration(seconds: 5);

    try {
      return state.cloneWith(
        candidateName: name,
        loading: false,
      );
    } catch (err) {
      print(err);
      return state.cloneWith(
        loading: false,
      );
    }
  }

  Future<PartyState> selectPartyName(String name) async {
    // await Duration(seconds: 5);

    try {
      return state.cloneWith(
        partyName: name,
        loading: false,
      );
    } catch (err) {
      print(err);
      return state.cloneWith(
        loading: false,
      );
    }
  }

  Future<PartyState> uploadData() async {
    print(state.candidateName);
    print(state.partyName);

    http.post(
        Uri.parse(
            'https://electionflutter-default-rtdb.asia-southeast1.firebasedatabase.app/party_list.json'),
        body: json.encode({
          'partyName': state.partyName,
          'count': '133',
        }));

    try {
      return state.cloneWith(
        partyName: null,
        candidateName: null,
        selectedCandidateIndex: 200,
        selectedPartyIndex: 200,
        loading: false,
      );
    } catch (err) {
      print(err);
      return state.cloneWith(
        loading: false,
      );
    }
  }
}
