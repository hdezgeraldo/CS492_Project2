import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) async {
  var file_contents = '';

  final file = File('bin/planetarySystem.json');

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      file_contents += line.toString();
    }
  } catch (e) {
    print('Error: $e');
  }

  // Create map with JSON info
  Map<String, dynamic> json_file = jsonDecode(file_contents);

  String json_system = json_file['name'];
  List<dynamic> json_planets = json_file['planets'];
  num json_planets_amount = json_planets.length;

  print('Welcome to the $json_system!\n'
      'There are $json_planets_amount planets to explore.\n'
      'What is your name?');

  var user_name = stdin.readLineSync();

  print(
      'Nice to meet you, $user_name. My name is Eliza, I\'m an old friend of Alexa\n'
      'Let\'s go on an adventure!\n'
      'Shall I randomly choose a planet for you to visit? (Y or N)');

  bool run_program = true;

  while (run_program) {
    var user_input = stdin.readLineSync();

    if (user_input == 'Y') {
      print('hello');

      // generate random number
      var rng = new Random();
      var ran_index = rng.nextInt(8);

      // select random planet
      String ran_planet = json_planets[ran_index]['name'];
      String ran_description = json_planets[ran_index]['description'];

      print('Traveling to $ran_planet...\n'
          'Arrived at $ran_planet. $ran_description');

      run_program = false;
    } else if (user_input == 'N') {
      print('Name the planet you would like to visit.');
      var user_planet = stdin.readLineSync();
      String target_planet = 'null';
      String target_description = 'null';

      json_planets.forEach((element) {
        if (element['name'] == user_planet) {
          target_planet = element['name'];
          target_description = element['description'];
        }
      });

      print('Traveling to $target_planet...\n'
          'Arrived at $target_planet. $target_description');
      run_program = false;
    } else {
      print('Sorry, I didn\'t get that.');
    }
  }
}

printGreeting() {}
