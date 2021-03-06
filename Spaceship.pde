class Spaceship extends Floater  
{   
    public Spaceship() {
    	corners = 27;
    	//int[] xS = {-8, 16, -8, -2};
    	//int[] yS = {-8, 0, 8, 0};
    	int[] xS = {-30, -32, -32, -25, -15, -24, -24, -6, -4, 2, 2, 12, 28, 32, 32, 28, 12, 2, 2, -4, -6, -24, -24, -15, -25, -32, -32};
    	int[] yS = {0, -4, -6, -8, -12, -12, -20, -20, -14, -14, -12, -8,-6, -2, 2, 6, 8, 12, 14, 14, 20, 20, 12, 12, 8, 6, 4};
    	xCorners = xS;
    	yCorners = yS;
    }
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
}