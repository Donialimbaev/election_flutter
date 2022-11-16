/* External Dependencies */
import 'dart:async';
import 'package:election_flutter/dummy_data/dummy_data_part.dart';
import 'package:election_flutter/models/party.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

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

        emit(await selectParty(event.partyIndex));
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
  }

  Future<PartyState> _fetchPartyList() async {
    List<Party> _party_list = partyList;
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

  Future<PartyState> selectParty(int partyIndex) async {
    // await Duration(seconds: 5);

    try {
      return state.cloneWith(
        selectedPartyIndex: partyIndex,
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
}
