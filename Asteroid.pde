class Asteroid extends Floater
{
	private int myRotationSpeed, mySize, mySpeed;
	private int scale;
	public void setX(int x) {myCenterX = x;}  
	public int getX() {return (int)myCenterX;}   
	public void setY(int y) {myCenterY = y;}
	public int getY() {return (int)myCenterY;}   
	public int getScale() {return scale;}
	public void setDirectionX(double x) {myDirectionX = x;}   
	public double getDirectionX() {return myDirectionX;}   
	public void setDirectionY(double y) {myDirectionY = y;}   
	public double getDirectionY() {return myDirectionY;}   
	public void setPointDirection(int degrees) {myPointDirection = degrees;}   
	public double getPointDirection() {return myPointDirection;}
	public int getSize() {return mySize;}
	public Asteroid(int size, int x, int y) {
		setX(x);
		setY(y);
		switch (size)
		{
			case 3:
				setDirectionX((Math.random()*3)-1);
				setDirectionY((Math.random()*3)-1);
				scale = 4;
				break;
			case 2:
				setDirectionX((Math.random()*5)-2);
				setDirectionY((Math.random()*5)-2);
				scale = 2;
				break;
			case 1:
				setDirectionX((Math.random()*7)-3);
				setDirectionY((Math.random()*7)-3);
				scale = 1;
				break;
		}
		myRotationSpeed = (int)((Math.random()*7)-3);
		int randomize = (int)(Math.random()*4);
		if (randomize == 0)
		{
    		corners = 10;
    		int[] xS = {-14, -7, 1, 7, 13, 9, 13, 3, -8, -14};
    		int[] yS = {8, 13, 8, 13, 8, 1, -7, -14, -14, -9};
    		for (int i = 0; i < corners; i++) {xS[i] *= scale;}
    		for (int i = 0; i < corners; i++) {yS[i] *= scale;}
    		xCorners = xS;
    		yCorners = yS;
    	}	
    	else if (randomize == 1)
    	{
    		corners = 12;
    		int[] xS = {-12, -12, -3, -6, 3, 14, 14, 2, 14, 7, 2, -7};
    		int[] yS = {-4, 5, 5, 12, 12, 6, 3, -1, -8, -14, -11, -14};
    		for (int i = 0; i < corners; i++) {xS[i] *= scale;}
    		for (int i = 0; i < corners; i++) {yS[i] *= scale;}
    		xCorners = xS;
    		yCorners = yS;
    	}
    	else if (randomize == 2)
    	{
    		corners = 11;
    		int[] xS = {-14, -7, -14, -4, 7, 14, 14, 7, 0, 0, -7};
    		int[] yS = {-3, 0, 3, 13, 13, 3, -3, -13, -13, -3, -13};
    		for (int i = 0; i < corners; i++) {xS[i] *= scale;}
    		for (int i = 0; i < corners; i++) {yS[i] *= scale;}
    		xCorners = xS;
    		yCorners = yS;
    	}
    	else if (randomize == 3)
    	{
    		corners = 12;
    		int[] xS = {-11, -14, -7, 0, 7, 14, 7, 14, 7, -3, -7, -14};
    		int[] yS = {0, 7, 13, 10, 13, 7, 4, -3, -13, -10, -13, -7};
    		for (int i = 0; i < corners; i++) {xS[i] *= scale;}
    		for (int i = 0; i < corners; i++) {yS[i] *= scale;}
    		xCorners = xS;
    		yCorners = yS;
    	}
    	mySize = 28 * scale;
    }
    public void move()
	{      
	    turn(myRotationSpeed);
	    super.move();
  	}
  	public void change(int newSize)
  	{
   		switch (newSize)
		{
			case 3:
				setDirectionX((Math.random()*3)-1);
				setDirectionY((Math.random()*3)-1);
				scale = 4;
				break;
			case 2:
				setDirectionX((Math.random()*5)-2);
				setDirectionY((Math.random()*5)-2);
				scale = 2;
				break;
			case 1:
				setDirectionX((Math.random()*7)-3);
				setDirectionY((Math.random()*7)-3);
				scale = 1;
				break;
		}
  	}
  	public void setColor(int filling) { myColor = filling; }
}