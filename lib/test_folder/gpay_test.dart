import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tataisdbd extends StatefulWidget {
  const Tataisdbd({super.key});

  @override
  State<Tataisdbd> createState() => _TataisdbdState();
}

class _TataisdbdState extends State<Tataisdbd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<GetFeaturedBoatsBloc>(context)
                    .add(GetFeaturedBoatsEvent.getFeaturedBoats());
              },
              child: Text(
                "Call",
              ),
            ),
            BlocBuilder<GetFeaturedBoatsBloc, GetFeaturedBoatsState>(
              builder: (context, state) {
                return state.map(
                  initial: (value) {
                    return Text("fdfd${value}");
                  },
                  loading: (value) {
                    return Text("fdfd${value}");
                  },
                  getFeaturedBoats: (value) {
                    return Text("fdfd${value}");
                  },
                  getFeaturedBoatsFailure: (value) {
                    return Text("fdfd${value}");
                  },
                  noInternet: (value) {
                    return Text("fdfd${value}");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
