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

	for (int i = 1; i <= n; i++){
		if(i %3 == 0)
		{
		System.out.println("FEED");
  		}
		else if(i %4 == 0)
		{
		System.out.println("BABE"); 
		}
		if(i %3 == 0 && i %4 == 0)
		{
		System.out.println("FEEDBABE");
		}
	}
  }
}
	
	

