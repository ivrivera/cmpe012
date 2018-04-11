//----------------------
//Ivanna Rivera
//CMPE 12
//Lab 1
//April 9th,2018
//FeedBabe.java
//----------------------

class FeedBabe{
  public static void main(String[] args){
	int n = 500;
	char divisible;

	for (int i = 1; i <= n; i++){
		if(n %3 == 0){
		System.out.println("FEED");
  		} else if(n %4 == 0){
		System.out.println("BABE");
		} else if(n %3 == 0 && n %4 == 0){
		System.out.println("FEEDBABE");
		}
	}
  }
}
	
	

