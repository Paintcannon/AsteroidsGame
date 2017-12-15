class Thruster
{   
	int myCenterX, myCenterY, tick, myX, myY;
	float myRotation, myRotationCenter;

	public Thruster(int centerX, int centerY)
	{
		tick = 0;
		myCenterX = centerX;
		myCenterY = centerY;
	}

	public Thruster(int centerX, int centerY, float centerOfRotation)
	{
		tick = 0;
		myCenterX = centerX;
		myCenterY = centerY;
		myRotationCenter = centerOfRotation;
	}

    public void show(int x, int y, float rotation)
    {
    	tick += 1;
    	//x and y are located at the center of the triangle base.
    	myX = x;
    	myY = y;
    	//rotation will be ship.getPointRotation();
    	myRotation = (float)((rotation+myRotationCenter)*(Math.PI/180));;
    	noStroke();
    	translate((float)x,(float)y);
    	rotate(myRotation);
    	//draws the flicker:
    	if (tick % 20 < 10)
    	{
    		fill(265,165,0);
    		triangle(myCenterX,myCenterY-4,myCenterX,myCenterY+4,myCenterX-18,myCenterY);
    		fill(255);
    		triangle(myCenterX,myCenterY-2,myCenterX,myCenterY+2,myCenterX-9,myCenterY);
    	}
    	else
    	{
    		fill(265,165,0);
    		triangle(myCenterX,myCenterY-4,myCenterX,myCenterY+4,myCenterX-9,myCenterY);
    		fill(255);
    		triangle(myCenterX,myCenterY-2,myCenterX,myCenterY+2,myCenterX-4,myCenterY);
    	}
    	rotate(-myRotation);
    	translate(-(float)x,-(float)y);
    }
}

class MiniThruster
{
	int myCenterX, myCenterY, tick, myX, myY;
	float myRotation, myRotationCenter;

	public MiniThruster(int centerX, int centerY)
	{
		tick = 0;
		myCenterX = centerX;
		myCenterY = centerY;
	}

	public MiniThruster(int centerX, int centerY, float centerOfRotation)
	{
		tick = 0;
		myCenterX = centerX;
		myCenterY = centerY;
		myRotationCenter = centerOfRotation;
	}

	public void show(int x, int y, float rotation)
    {
    	tick += 1;
    	//x and y are located at the center of the triangle base.
    	myX = x;
    	myY = y;
    	//rotation will be ship.getPointRotation();
    	myRotation = (float)((rotation+myRotationCenter)*(Math.PI/180));;
    	noStroke();
    	translate((float)x,(float)y);
    	rotate(myRotation);
    	//draws the flicker:
    	if (tick % 20 < 10)
    	{
    		fill(265,165,0);
    		triangle(myCenterX,myCenterY-2,myCenterX,myCenterY+2,myCenterX-9,myCenterY);
    		fill(255);
    		triangle(myCenterX,myCenterY-1,myCenterX,myCenterY+1,myCenterX-4,myCenterY);
    	}
    	else
    	{
    		fill(265,165,0);
    		triangle(myCenterX,myCenterY-2,myCenterX,myCenterY+2,myCenterX-5,myCenterY);
    		fill(255);
    		triangle(myCenterX,myCenterY-1,myCenterX,myCenterY+1,myCenterX-2,myCenterY);
    	}
    	rotate(-myRotation);
    	translate(-(float)x,-(float)y);
    }
}