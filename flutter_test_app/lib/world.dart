
class World {
  int noBuildings = 20;
  late List<Building> buildings = <Building>[];

  World() {
    for(int i = 0; i < 20; i++) {
      buildings.add(Building(i.toString(), 10, i * 22));
    }
  }
}

class WorldBuilder {
  late String name;

  void setName(String name) {
    this.name = name;
  }

  World build() {
    return World();
  }
}

class Building {
  double x1;
  double y1;
  late double x2;
  late double y2;
  bool selected = false;

  String name;

  Building(this.name, this.x1, this.y1) {
    x2 = x1 + 10;
    y2 = y1 + 20;
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
    return "$name\n($x1,$y1)";
  }
}