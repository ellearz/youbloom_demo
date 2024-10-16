import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom/bloc/main_bloc.dart';
import 'package:youbloom/events/main_event.dart';
import 'package:youbloom/pages/details_page.dart';
import 'package:youbloom/states/main_state.dart';
import 'package:dio/dio.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Youbloom', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 99, 17, 11),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
       create: (context) => MainBloc(Dio())..add(FetchEvents()),
        child: ConcertList(),
      ),
    );
  }
}

class ConcertList extends StatefulWidget {
  const ConcertList({super.key});

  @override
  _ConcertListState createState() => _ConcertListState();
}

class _ConcertListState extends State<ConcertList> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              context.read<MainBloc>().add(SearchEvents(value));
            },
            decoration: const InputDecoration(
              labelText: 'Search concerts',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is MainLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MainLoaded) {
                return ListView.builder(
                  itemCount: state.concerts.length,
                  itemBuilder: (context, index) {
                    final concert = state.concerts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(concertTitle: concert.title)
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                concert.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                concert.date,
                                style: const TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is MainError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}