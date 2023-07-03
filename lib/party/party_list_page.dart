import 'package:election_flutter/party/party_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/party_bloc.dart';
import 'bloc/party_event.dart';

class PartyListPage extends StatefulWidget {
  const PartyListPage({super.key});

  @override
  State<PartyListPage> createState() => _PartyListPageState();
}

class _PartyListPageState extends State<PartyListPage> {
  @override
  void initState() {
    context.read<PartyBloc>().add(FetchPartyListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PartyBloc>().add(FetchPartyListEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Партиялар тизмеги'),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<PartyBloc>(context),
        child: BlocProvider.value(
          value: BlocProvider.of<PartyBloc>(context),
          child: PartyList(),
        ),
      ),
    );
  }
}
