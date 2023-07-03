class PartyEvent {}

class FetchPartyListEvent extends PartyEvent {}

class SelectPartyEvent extends PartyEvent {
  int partyIndex;
  String partyID;
  SelectPartyEvent({required this.partyIndex, required this.partyID});
}

class SelectPartyNameEvent extends PartyEvent {
  String name;
  SelectPartyNameEvent({required this.name});
}

class SelectCandidateEvent extends PartyEvent {
  int candidateIndex;
  SelectCandidateEvent({required this.candidateIndex});
}

class SelectCandidateNameEvent extends PartyEvent {
  String name;
  SelectCandidateNameEvent({required this.name});
}

class SendResultToServerEvent extends PartyEvent {}
