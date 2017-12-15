class Stars //note that this class does NOT extend Floater
{
	int myX, myY, myFill1, myFill2, myFill3, mySize;
	public Stars()
	{
		myX = (int)(Math.random()*width);
		myY = (int)(Math.random()*height);
		myFill1 = (int)(Math.random()*256);
		myFill2 = (int)(Math.random()*256);
		myFill3 = (int)(Math.random()*256);
		mySize = (int)((Math.random()*4)+1);
	}
	public void show()
	{
		noStroke();
		fill(myFill1, myFill2, myFill3);
		ellipse(myX, myY, mySize, mySize);
	}
	public void randomize()
	{
		myX = (int)(Math.random()*width);
		myY = (int)(Math.random()*height);
		myFill1 = (int)(Math.random()*256);
		myFill2 = (int)(Math.random()*256);
		myFill3 = (int)(Math.random()*256);
		mySize = (int)((Math.random()*5)+1);
	}
	public int getSize() {return mySize;}
	public int getX() {return myX;}
	public int getY() {return myY;}
}
