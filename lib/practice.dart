
class Bicycle {
  int wheel;
  int speed;
  int gear;

  Bicycle(this.wheel, this.speed, this.gear); // equivalent to adding all the others separately
}

main(List<String> args) {
  
  var bike = new Bicycle(2, 0, 1);
  print(bike.gear); 

}
