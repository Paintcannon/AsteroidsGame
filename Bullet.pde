class Bullet extends Floater
{
	public void setX(int x) {myCenterX = x;}  
	public int getX() {return (int)myCenterX;}   
	public void setY(int y) {myCenterY = y;}
	public int getY() {return (int)myCenterY;}   
	public void setDirectionX(double x) {myDirectionX = x;}   
	public double getDirectionX() {return myDirectionX;}   
	public void setDirectionY(double y) {myDirectionY = y;}   
	public double getDirectionY() {return myDirectionY;}   
	public void setPointDirection(int degrees) {myPointDirection = degrees;}   
	public double getPointDirection() {return myPointDirection;}
	private double myRadians;
	public Bullet(Spaceship theShip)
	{
		myCenterX = theShip.getX();
		myCenterY = theShip.getY();
		myPointDirection = theShip.getPointDirection();
		myRadians = myPointDirection*(Math.PI/180);
		myDirectionX = (5 * Math.cos(myRadians)) + theShip.getDirectionX();
		myDirectionY = (5 * Math.sin(myRadians)) + theShip.getDirectionY();
	}
	public void show()
	{
		noStroke();
		fill(135,206,250);
		ellipse((float)myCenterX,(float)myCenterY,7.0,7.0);
	}
}