import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../model/number.dart';
import '../shared/sqlite_service.dart';

class Offline extends StatefulWidget {
  const Offline({super.key});

  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  @override
  Widget build(BuildContext context) {
    List<Number> numbers = [];

    getNumbers() async {
      log('Get all numbers from database');
      List<Number>? allNumbers = await SqliteService.getNumbers();
      setState(() {
        numbers = allNumbers;
      });
    }

    insertNumber() async {
      log('Insert a number in the database');
      int number;
      if (numbers.isEmpty) {
        number = 1;
      } else {
        number = numbers[numbers.length - 1].number + 1;
      }
      await SqliteService.insertNumber(number);
      getNumbers();
    }

    deleteNumber(String id) async {
      log('Delete a number from the database');
      await SqliteService.deleteNumber(id);
      getNumbers();
    }

    /*
    Method not used
     updateNumber(Number number) async {
      log('Update a number in the database');
      await SqliteService.updateNumber(number);
      getNumbers();
    }
    */

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline App'),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? const Color(0xFF00EE44) : const Color(0xFFEE4400),
                  child: Center(
                    child: Text(connected ? 'ONLINE' : 'OFFLINE'),
                  ),
                ),
              ),
              Center(
                child: connected
                    ? Center(
                        child: Text(numbers.isEmpty
                            ? 'No numbers saved offline!'
                            : 'Last saved number when tha application was offline: \n'
                                '${numbers[numbers.length - 1].number}!'))
                    : Column(
                        children: [
                          Expanded(
                            child: numbers.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Empty',
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.only(top: 20),
                                    itemCount: numbers.length,
                                    itemBuilder: (build, index) => ListTile(
                                      title: Text('Number ${numbers[index].number}'),
                                      subtitle: Text('ID: (${numbers[index].id})'),
                                      leading: Text('${index + 1}'),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete_forever),
                                        onPressed: () async {
                                          await deleteNumber(numbers[index].id);
                                        },
                                      ),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text('Get all numbers'),
                                  onPressed: () async {
                                    await getNumbers();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text('Add'),
                                  onPressed: () async {
                                    await insertNumber();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
        builder: (BuildContext context) {
          return const SizedBox();
        },
      ),
    );
  }
}
