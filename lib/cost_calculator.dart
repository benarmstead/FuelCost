class CostCalculator {
  double litresPGallon = 4.54609;

  double mpg = 0;
  double distance = 0;
  double pricePLitre = 0;

  void setMpg(passed) {
    mpg = passed;
  }

  void setDistance(passed) {
    distance = passed;
  }

  void setPricePLitre(passed) {
    pricePLitre = passed;
  }

  double calculate() {
    return (distance / mpg) * (pricePLitre * litresPGallon);
  }

  bool canCalculate() {
    if (distance == 0 || mpg == 0 || pricePLitre == 0) {
      return false;
    }
    return true;
  }
}
