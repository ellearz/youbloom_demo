import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart'; 
import 'package:youbloom/bloc/details_bloc.dart';
import 'package:youbloom/events/details_event.dart';
import 'package:youbloom/states/details_state.dart';

class DetailsPage extends StatelessWidget {
  final String concertTitle;

  const DetailsPage({super.key, required this.concertTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc(Dio())..add(FetchDetailsEvent(concertTitle)),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoaded) {
                return Text(
                  state.concert.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              } else {
                return const Text(
                  "Concert Details",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          backgroundColor: const Color.fromARGB(255, 99, 17, 11),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsLoaded) {
              final details = state.concert;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        details.imagePath,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      details.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      details.date,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      details.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            } else if (state is DetailsError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No concert data found.'));
            }
          },
        ),
      ),
    );
  }
}
