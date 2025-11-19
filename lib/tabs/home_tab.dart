import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late dynamic snapshot;

  Future<dynamic> _getFirebaseData() async{
    final ref = FirebaseDatabase.instance.ref();
    snapshot = await ref.child('Home').get();
    return snapshot.value;
  }

  Widget _backgroundContainer() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange, Colors.deepOrangeAccent],
        begin: AlignmentGeometry.topLeft,
        end: AlignmentGeometry.bottomRight,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundContainer(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: _getFirebaseData(),
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none){
                  return SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  );
                }

                print(snapshot.data.length);
                return SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ],
    );
  }
}
