class Skillset {
  String skillset;
  final String id;

  Skillset(this.skillset, this.id);

  void update(String val) {
    this.skillset = val;
    print(this.skillset);
  }
}
