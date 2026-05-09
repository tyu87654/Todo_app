import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

Future<Database> initDB() async {
  return openDatabase(
    'users.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
      );
    },
  );
}

Future<void> addUser(Database db, String name, int age) async {
  await db.insert(
    'users',
    {
      'name': name,
      'age': age,
    },
  );
}

Future<List<Map<String, dynamic>>> getUsers(Database db) async {
  return await db.query('users');
}

Future<void> updateUser(Database db, int id) async {
  await db.update(
    'users',
    {
      'name': 'Оновлений користувач',
      'age': 30,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> deleteUser(Database db, int id) async {
  await db.delete(
    'users',
    where: 'id = ?',
    whereArgs: [id],
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'Іван',
      'age': 20,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SQLite CRUD'),
        ),
        body: Column(
          children: [

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                Database db = await initDB();

                await addUser(db, 'Іван', 20);

                setState(() {
                  users.add({
                    'id': users.length + 1,
                    'name': 'Іван',
                    'age': 20,
                  });
                });
              },
              child: const Text('Додати користувача'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {

                  return ListTile(
                    title: Text(users[index]['name']),
                    subtitle: Text(
                      'Вік: ${users[index]['age']}',
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                          icon: const Icon(Icons.edit),

                          onPressed: () async {

                            Database db = await initDB();

                            await updateUser(
                              db,
                              users[index]['id'],
                            );

                            setState(() {
                              users[index]['name'] =
                                  'Оновлений користувач';

                              users[index]['age'] = 30;
                            });
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete),

                          onPressed: () async {

                            Database db = await initDB();

                            await deleteUser(
                              db,
                              users[index]['id'],
                            );

                            setState(() {
                              users.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}