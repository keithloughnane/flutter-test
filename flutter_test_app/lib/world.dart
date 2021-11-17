import 'dart:math';

import 'package:flutter/foundation.dart';

class World {
  int noBuildings = 20;
  late List<Building> buildings = <Building>[];
  List<Crime>? crimes;

  World();
}

class WorldBuilder {
  late String name;

  void setName(String name) {
    this.name = name;
  }

  World build() {
    Random random = Random(100); //TODO from city name

    var world = World();

    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 5; y++) {
        var building = Building("", x * 11, y * 22);
        var type = BuildingType.values[random.nextInt(4)];
        building.type = type;
        world.buildings.add(building);
      }
    }

    for (var element in world.buildings) {
      switch (element.type) {
        case BuildingType.home:
          element.addPerson(Person(PersonType.civilian, random.nextInt(99)));
          break;
        case BuildingType.hangOut:
          for (int i = 0; i < random.nextInt(7); i++) {
            if (random.nextInt(10) < 8) {
              element
                  .addPerson(Person(PersonType.criminal, random.nextInt(100)));
            } else {
              element.addPerson(Person(PersonType.snitch, random.nextInt(100)));
            }
          }
          break;
        case BuildingType.victimBusiness:
          element.addPerson(Person(PersonType.civilian, random.nextInt(99)));
          break;
        case BuildingType.fence:
          element.addPerson(Person(PersonType.fence, random.nextInt(99)));
          break;
      }
    }

    world.crimes = generateCrimes(world, random);

    return world;
  }

  List<Crime> generateCrimes(World world, Random random) {
    List<Building> victims = <Building>[];
    List<Building> gangs = <Building>[];
    List<Building> fences = <Building>[];

    List<Crime> crimes = <Crime>[];

    world.buildings.forEach((element) {
      switch (element.type) {
        case BuildingType.home:
          break;
        case BuildingType.hangOut:
          gangs.add(element);
          break;
        case BuildingType.victimBusiness:
          victims.add(element);
          break;
        case BuildingType.fence:
          fences.add(element);
          break;
      }
    });

    for (var gang in gangs) {
      //TODO maybe skip some.
      if (gang.occupants.isNotEmpty) {
        Crime crime = Crime();

        crime.addCriminals(gang.occupants);

        for (var criminal in gang.occupants) {
          if (criminal.compitence > crime.highestCompitence) {
            crime.highestCompitence = criminal.compitence;
          } else if (criminal.compitence < crime.lowestCompitence) {
            crime.lowestCompitence = criminal.compitence;
          }
        }

        victims.shuffle(random);
        fences.shuffle(random);

        print("KLTest 100");
        for (var victim in victims) {
          if (victim.occupants[0].compitence > crime.highestCompitence) {
            crime.addAttemptedVictim(victim.occupants[0]);
            crime.victim = victim.occupants[0];
            crime.hall = victim.valueables;
          }
        }

        for (var fence in fences) {
          if (fence.occupants[0].compitence > crime.highestCompitence) {
            crime.addAttemptedFence(fence);
            crime.fence = fence.occupants[0];
          }
        }
        if (crime.victim != null) {
          crimes.add(crime);
        }
      }
    }

    print("Generated crimes : " + crimes.toString());

    return crimes;
  }
}

class Crime {
  int lowestCompitence = 100;
  int highestCompitence = 0;

  Person? victim;
  Valuable? hall;
  Person? fence;

  void addAttemptedVictim(Person occupant) {}

  void addAttemptedFence(victim) {}

  void addCriminals(List<Person> occupants) {}
}

enum PersonType { criminal, fence, snitch, civilian }

class Person {
  PersonType type;
  int compitence;

  Person(this.type, this.compitence);
}

enum BuildingType {
  home,
  hangOut,
  victimBusiness,
  fence,
}

class Building {
   int width = 10;
  int height = 20;

  double x1;
  double y1;
  late double x2;
  late double y2;
  bool selected = false;
  BuildingType? type;

  String name;

  Valuable? valueables;

  Building(this.name, this.x1, this.y1) {
    x2 = x1 + width;
    y2 = y1 + height;
  }

  bool isInside(double x, double y) {
    return (x > x1 && x < x2 && y > y1 && y < y2);
  }

  void setSelected(bool selected) {
    print("KLTest selected : " + y1.toString());
    this.selected = selected;
  }

  @override
  String toString() {
    return "$type\n${occupantsString(occupants)}";
  }

  List<Person> occupants = <Person>[];

  void addPerson(Person person) {
    occupants.add(person);
  }

  String occupantsString(List<Person> occupants) {
    String result = "";
    for (var element in occupants) {
      switch (element.type) {
        case PersonType.criminal:
          result += "C";
          break;
        case PersonType.fence:
          result += "F";
          break;
        case PersonType.snitch:
          result += "S";
          break;
        case PersonType.civilian:
          result += "_";
          break;
      }
    }
    return result;
  }
}

class Valuable {
  String name;
  int value;

  Valuable(this.name, this.value);
}
