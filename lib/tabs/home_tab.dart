import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late dynamic getSnapshot;

  Future<dynamic> _getFirebaseData() async {
    final ref = FirebaseDatabase.instance.ref();
    getSnapshot = await ref.child('Home').get();

    final data = Map<String, Map<dynamic, dynamic>>.from(
      getSnapshot.value as Map,
    );

    final List<Map<dynamic, dynamic>> dataList = [];

    data.forEach((key, data) {
      final itemData = Map<dynamic, dynamic>.from(data);
      itemData['id'] = key;
      dataList.add(itemData);
    });

    dataList.sort((a, b) {
      final aPos = a['pos'] as num;
      final bPos = b['pos'] as num;
      return aPos.compareTo(bPos);
    });

    return dataList;
  }

  Widget _backgroundContainer() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xABE6FFFF), Colors.white],
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
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                /*
                print(snapshot.data.values);

                final list = map.values.toList();*/

                if (!snapshot.hasData || snapshot.data == null) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Nenhum dado encontrado')),
                  );
                }

                print(snapshot.data);

                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(
                      snapshot.data[index]['x'],
                      (snapshot.data[index]['y'] as num).toDouble(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return FadeInImage.memoryNetwork(
                      key: ValueKey(snapshot.data[index]['id']),
                      placeholder: kTransparentImage,
                      image: snapshot.data[index]['image'],
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: snapshot.data.length,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
