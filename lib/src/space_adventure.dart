import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'planetary_system.dart';

import 'package:main/dart_space_adventure.dart';

class SpaceAdventure {
  PlanetarySystem planetarySystem;

  SpaceAdventure({required this.planetarySystem});

  void start() async {
    // Create map with JSON info
    Map<String, dynamic> json_file =
        jsonDecode(await getFileContents('bin/planetarySystem.json'));

    // Parse map
    // String json_system = json_file['name'];
    List<dynamic> json_planets = json_file['planets'];
    num json_planets_amount = json_planets.length;

    printGreeting(json_planets_amount);

    printIntroduction(responseToPrompt('What is your name?'));

    print('Let\'s go on an adventure!');

    travel(
        json_planets,
        promptForRandomOrSpecificDestination(json_planets,
            'Shall I randomly choose a planet for you to visit? (Y or N)'));
  }

  Future<String> getFileContents(String file_name) async {
    var file_contents = '';

    final file = File(file_name);

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

    return file_contents;
  }

  void printGreeting(num planet_numbers) {
    print('Welcome to the ${planetarySystem.name}!\n'
        'There are $planet_numbers planets to explore.');
  }

  void printIntroduction(String user_name) {
    print(
        'Nice to meet you, $user_name. My name is Eliza, I\'m an old friend of Alexa');
  }

  String responseToPrompt(String prompt) {
    print(prompt);
    return stdin.readLineSync().toString();
  }

  bool promptForRandomOrSpecificDestination(
      List<dynamic> json_planets, String prompt) {
    String user_input = '';

    while (user_input != 'Y' && user_input != 'N') {
      user_input = responseToPrompt(prompt);

      if (user_input == 'Y') {
        return true;
      } else if (user_input == 'N') {
        return false;
      } else {
        print('Sorry, I didn\'t get that.');
      }
    }
    return false;
  }

  void travel(List<dynamic> json_planets, bool randomDestination) {
    if (randomDestination) {
      travelToRandomPlanet(json_planets);
    } else {
      travelTo(json_planets);
    }
  }

  void travelToRandomPlanet(List<dynamic> json_planets) {
    // generate random number
    var rng = new Random();
    var ran_index = rng.nextInt(8);

    // select random planet
    String ran_planet = json_planets[ran_index]['name'];
    String ran_description = json_planets[ran_index]['description'];

    print('Traveling to $ran_planet...\n'
        'Arrived at $ran_planet. $ran_description');
  }

  void travelTo(List<dynamic> json_planets) {
    var user_planet =
        responseToPrompt('Name the planet you would like to visit.');

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
  }
}
