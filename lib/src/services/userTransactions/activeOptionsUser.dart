

class activeOptions{
 int active=0;

 static activeOptions _instance = activeOptions._internal();
 activeOptions._internal() {}

 factory activeOptions() {
   return _instance;
 }


activarOptions() {
  if(active==0){
    active=1;
  }else{
    active=0;
  }
 }
 int get isActive=>active;

}