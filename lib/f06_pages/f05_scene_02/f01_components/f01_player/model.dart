
class Model{

  final String name;
  final String race;
  int health;
  int magic;
  int level;
  int exp;
  String rivePath;
  double speed = 100.0;

  Model({
    this.name = "player",
    this.race = "human",
    this.health = 100,
    this.magic = 100,
    this.level = 1,
    this.exp = 0,
    this.rivePath = 'assets/rives/player.riv'
  });
}