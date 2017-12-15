class Radar //note that this class does NOT extend Floater
{
	private int myX, myY, tick, mySize;
	public Radar(int x, int y)
	{
		myX = x;
		myY = y;
		tick = 0;
		mySize = 0;
	}
	public void show()
	{
		tick += 1;
		mySize = tick * 3;
		noFill();
		strokeWeight(10);
		stroke(139,0,0);
		ellipse(myX, myY, mySize, mySize);
		strokeWeight(1);
	}
	public int getSize() {return (int)mySize;}
	public int getX() {return (int)myX;}   
	public int getY() {return (int)myY;}   
}
