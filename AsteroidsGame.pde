Spaceship ship = new Spaceship();
Thruster forward1 = new Thruster(-24, -16, 0);
Thruster forward2 = new Thruster(-24, 16, 0);
Thruster backing1 = new Thruster(6, 16, 180);
Thruster backing2 = new Thruster(6, -16, 180);
MiniThruster righting = new MiniThruster(-6,-20,90);
MiniThruster lefting = new MiniThruster(-6,20,270);
Hyperbeam beam = new Hyperbeam();
Stars starArray[] = new Stars[200];
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Radar> radarArray = new ArrayList<Radar>();
ArrayList<Integer> asteroidProximity = new ArrayList<Integer>();
ArrayList<Bullet> bulletArray = new ArrayList<Bullet>();
boolean forward, backward, left, right, hyperspace, shipDisappear, starTrigger, firing;
double dRadians;
int radarTick, hyperspaceTick, hyperspaceX, hyperspaceY, hyperspaceRotation;
public void setup() 
{	
	ship.setX(500);
	ship.setY(500);
	size(1000,1000);
	forward = false;
	backward = false;
	left = false;
	right = false;
	hyperspace = false;
	hyperspaceTick = 0;
	radarTick = 0;
	shipDisappear = false;
	starTrigger = false;
	for (int i = 0; i < 200; i++) {starArray[i] = new Stars();}
	for (int i = 0; i < 6; i++) {
		asteroids.add(new Asteroid(3,(int)(Math.random()*width),(int)(Math.random()*height)));
		if (sqrt(sq(asteroids.get(i).getY()-ship.getY())+sq(asteroids.get(i).getX()-ship.getX())) < 70)
		{
			asteroids.get(i).setX((int)(Math.random()*width));
			asteroids.get(i).setY((int)(Math.random()*height));
		}
	}
}

public void draw() 
{
	radarTick += 1;
	background(0);
	noStroke();
	for (int i = 0; i < 200; i++) {starArray[i].show();}
	for (int i = 0; i < radarArray.size(); i++) {radarArray.get(i).show();}
	for (int i = 0; i < bulletArray.size(); i++) 
	{
		bulletArray.get(i).show();
		bulletArray.get(i).move();
	}
	if (radarTick % 180 == 0 && hyperspace == false) {radarArray.add(new Radar(ship.getX(),ship.getY()));}
	for (int i = 0; i < radarArray.size(); i++)
	{
		if (radarArray.get(i).getSize() > (sqrt((sq(height)+sq(width)))) * 2) {radarArray.remove(i);}
	}
	for (int i = 0; i < asteroids.size(); i++)
	{
		int maximum = 0;
		for (int ii = 0; ii < radarArray.size(); ii++)	
		{
			int filling = 255 - (2 * Math.abs((radarArray.get(ii).getSize()/2) - (int)(sqrt(sq(abs(radarArray.get(ii).getX()-asteroids.get(i).getX())) + sq(abs(radarArray.get(ii).getY()-asteroids.get(i).getY()))))));
			if (filling < 0) { filling = 0; }
			asteroidProximity.add(ii, filling);
		}
		if (asteroidProximity.size() > 0) {
			maximum = asteroidProximity.get(0);
			for (int iii = 0; iii < asteroidProximity.size(); iii++)	
				{
					if ((int)asteroidProximity.get(iii) > maximum) {maximum = (int)asteroidProximity.get(iii);}
				}
			asteroids.get(i).setColor(maximum);
			asteroids.get(i).show();
			asteroids.get(i).move();
			asteroidProximity.clear();
		}
		//println(filling);
	}
	for (int i = 0; i < bulletArray.size(); i++)
	{
		for (int v = 0; v < asteroids.size(); v++)
		{
			if (sqrt(sq(asteroids.get(v).getY()-bulletArray.get(i).getY())+sq(asteroids.get(v).getX()-bulletArray.get(i).getX())) < 13*asteroids.get(v).getScale())
			{
				bulletArray.remove(i);
				asteroidHit(v);
				break;
			}
		}
	}
	dRadians = ship.getPointDirection() * (Math.PI/180);
	if (hyperspace == false)
	{
		if (shipDisappear == false) {ship.show();}
		if (forward == true)
		{
			forward1.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			forward2.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
		}
		if (backward == true)
		{
			backing1.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			backing2.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
		}
		if (left == true) {lefting.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());}
		if (right == true) {righting.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());}
	}
  	ship.move();
  	if (hyperspace == true)
  	{
  		radarTick = 1;
  		ship.setDirectionX(0);
  		ship.setDirectionY(0);
  		for (int i = 0; i < radarArray.size(); i++) {radarArray.remove(i);}
  		hyperspaceTick += 1;
  		if (hyperspaceTick <= 40) 
  		{
  			beam.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
  			shipDisappear = true;
  		}
  		else if (hyperspaceTick > 60 && starTrigger == true)
  		{
  			for (int i = 0; i < 200; i++) {starArray[i].randomize();}
  			starTrigger = false;
  		}
  		else if (hyperspaceTick > 80 && hyperspaceTick <= 100)
  		{
  			ship.setX(hyperspaceX);
  			ship.setY(hyperspaceY);
  			ship.setPointDirection(hyperspaceRotation);
  			beam.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
  		}
  		else if (hyperspaceTick > 100) 
  		{
  			shipDisappear = false;
  			hyperspaceTick = 0;
  			beam.reset();
  			hyperspace = false;
  			for (int i = 0; i < 6; i++) {
		asteroids.add(new Asteroid(3,(int)(Math.random()*width),(int)(Math.random()*height)));
		if (sqrt(sq(asteroids.get(i).getY()-ship.getY())+sq(asteroids.get(i).getX()-ship.getX())) < 70)
		{
			asteroids.get(i).setX((int)(Math.random()*width));
			asteroids.get(i).setY((int)(Math.random()*height));
		}
	}
  		}
  	}
  	//test.show(ship.getX()-24,ship.getY()-16,(float)ship.getPointDirection());
  	//println(hyperspaceTick);
}

public void hyperspace()
{
	asteroids.clear();
  	radarArray.clear();
  	bulletArray.clear();
	starTrigger = true;
	hyperspace = true;
	hyperspaceX = (int)(Math.random() * (width-46)+23);
	hyperspaceY = (int)(Math.random() * (height-46)+23);
	hyperspaceRotation = (int)(Math.random() * 360);
}

public void asteroidHit(int asteroid)
{
	switch(asteroids.get(asteroid).getSize())
	{
		case 3:
			println("success");
			asteroids.add(new Asteroid(2,asteroids.get(asteroid).getX(), asteroids.get(asteroid).getY()));
			asteroids.get(asteroid).change(2);
			break;
		case 2:
			asteroids.add(new Asteroid(1,asteroids.get(asteroid).getX(), asteroids.get(asteroid).getY()));
			asteroids.get(asteroid).change(1);
			break;
		case 1:
			asteroids.remove(asteroid);
			break;
	}
}
public void keyPressed()
{
	if (key == 'a' && hyperspace == false)
	{
		ship.turn(-10);
		left = true;
	}
	if (key == 'd' && hyperspace == false)
	{
		ship.turn(10);
		right = true;
	}
	if (key == 'w' && hyperspace == false)
	{
		ship.accelerate(0.2);
		forward = true;
	}
	if (key == 's' && hyperspace == false)
	{
		ship.accelerate(-0.2);
		backward = true;
	}
	if (key == 'q' && hyperspace == false) {hyperspace();}
	if (key == ' ' && hyperspace == false && firing == false) 
	{
		bulletArray.add(new Bullet(ship));
		firing = true;
	}
}


public void keyReleased()
{
	if (key == 'a') {left = false;}
	if (key == 'd') {right = false;}
	if (key == 'w') {forward = false;}
	if (key == 's') {backward = false;}
	if (key == ' ') {firing = false;}
}