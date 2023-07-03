/* External Dependencies */
import 'package:election_flutter/models/party.dart';

class PartyState {
  List party_list = [];
  int? selectedPartyIndex;
  int? selectedCandidateIndex;
  bool? loading;
  String? candidateName;
  String? selectedPartyID;
  String? partyName;

  PartyState({
    this.party_list = const [],
    this.selectedPartyIndex,
    this.selectedCandidateIndex,
    this.loading = false,
    this.candidateName,
    this.partyName,
    this.selectedPartyID,
  });

  PartyState cloneWith({
    List<Party>? party_list,
    int? selectedPartyIndex,
    String? candidateName,
    String? partyName,
    String? selectedPartyID,
    int? selectedCandidateIndex,
    bool? loading,
  }) =>
      PartyState(
        selectedPartyIndex: selectedPartyIndex ?? this.selectedPartyIndex,
        selectedCandidateIndex:
            selectedCandidateIndex ?? this.selectedCandidateIndex,
        party_list: party_list ?? this.party_list,
        loading: loading ?? this.loading,
        candidateName: candidateName ?? this.candidateName,
        partyName: partyName ?? this.partyName,
        selectedPartyID: selectedPartyID ?? this.selectedPartyID,
      );
}
