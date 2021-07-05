import 'package:main/dart_space_adventure.dart';
import 'package:main/src/planetary_system.dart';

void main(List<String> arguments) {
  SpaceAdventure(planetarySystem: PlanetarySystem(name: 'Solar System')).start();
}
