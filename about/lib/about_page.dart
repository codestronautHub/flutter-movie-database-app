import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF1E1E29),
                  child: Center(
                    child: Text(
                      'MDB',
                      style: TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Color(0xFF1E1E29),
                  child: Text(
                    'Movie Database (MDB) is a movie and tv series catalog app developed by Aditya Rohman sebagai as a project submission for Flutter Developer Expert course on Dicoding Indonesia.',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
