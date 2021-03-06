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
boolean forward, backward, left, right, hyperspace, shipDisappear, starTrigger, firing, isHit, gameOver, hyperspaceOn;
double dRadians;
int radarTick, hyperspaceTick, hitTick, hyperspaceX, hyperspaceY, hyperspaceRotation, lives, score, scoreThisRound, round;
public void setup() 
{	
	score = 0;
	scoreThisRound = 0;
	round = 0;
	lives = 3;
	ship.setX(500);
	ship.setY(500);
	size(1000,1000);
	forward = false;
	backward = false;
	left = false;
	right = false;
	hyperspaceOn = false;
	hyperspaceTick = 0;
	hitTick = 0;
	radarTick = 0;
	isHit = false;
	shipDisappear = false;
	starTrigger = false;
	for (int i = 0; i < 200; i++) {starArray[i] = new Stars();}
	for (int i = 0; i < 4; i++) {
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
	if (asteroids.size() == 0 && round == 0 && hyperspaceOn == false)
  	{
  		textAlign(CENTER);
  		textSize(80);
  		fill(138,43,226);
  		text("Press Q for hyperspace",width/2,height/2);
  	}
	for (int i = 0; i < radarArray.size(); i++) {radarArray.get(i).show();}
	for (int i = 0; i < bulletArray.size(); i++) 
	{
		bulletArray.get(i).show();
		bulletArray.get(i).move();
		if (bulletArray.get(i).getDistance() > 750) {bulletArray.remove(i);}
	}
	if (radarTick % 180 == 0 && hyperspaceOn == false) {radarArray.add(new Radar(ship.getX(),ship.getY()));}
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
		if (sqrt(sq(asteroids.get(i).getY()-ship.getY())+sq(asteroids.get(i).getX()-ship.getX())) < (13*asteroids.get(i).getScale())+32 && isHit == false)
		{
			if (lives > 1) {asteroidHit(i, false);}
			hit();
		}
	}
	for (int i = 0; i < bulletArray.size(); i++)
	{
		for (int v = 0; v < asteroids.size(); v++)
		{
			if (sqrt(sq(asteroids.get(v).getY()-bulletArray.get(i).getY())+sq(asteroids.get(v).getX()-bulletArray.get(i).getX())) < 13*asteroids.get(v).getScale())
			{
				bulletArray.remove(i);
				asteroidHit(v, true);
				break;
			}
		}
	}
	dRadians = ship.getPointDirection() * (Math.PI/180);
	if (hyperspaceOn == false && shipDisappear == false)
	{
		ship.show();
		if (forward == true)
		{
			forward1.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			forward2.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			ship.accelerate(0.2);
		}
		if (backward == true)
		{
			backing1.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			backing2.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			ship.accelerate(-0.2);
		}
		if (left == true) 
		{
			lefting.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			ship.turn(-5);
		}
		if (right == true) 
		{
			righting.show(ship.getX(), ship.getY(), (float)ship.getPointDirection());
			ship.turn(5);
		}
	}
  	ship.move();
  	if (hyperspaceOn == true)
  	{
  		radarTick = 1;
  		ship.setDirectionX(0);
  		ship.setDirectionY(0);
  		for (int i = 0; i < radarArray.size(); i++) {radarArray.remove(i);}
  		hyperspaceTick += 1;
  		if (hyperspaceTick <= 40) 
  		{
  			if (gameOver == false) {beam.show(ship.getX(), ship.getY(), (float)ship.getPointDirection(), false);}
  			else
  			{
  				textAlign(CENTER);
 				fill(255, 0, 0);
 				textSize(100);
  				text("GAME OVER",width/2,height/2);
  			}
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
  			beam.show(ship.getX(), ship.getY(), (float)ship.getPointDirection(), gameOver);
  		}
  		else if (hyperspaceTick > 100) 
  		{
  			if (gameOver == true)
  			{
  				lives = 3;
  				gameOver = false;
  			}
  			shipDisappear = false;
  			hyperspaceTick = 0;
  			beam.reset();
  			hyperspaceOn = false;
  			for (int i = 0; i < 4; i++) 
  			{
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
  	if (isHit == true)
  	{
  		hitTick++;
  		if (hitTick % 60 < 30 && hitTick < 180) {shipDisappear = true;}
  		else if (hitTick % 60 >= 30) {shipDisappear = false;}
  		else if (hitTick >= 180)
  		{
  			shipDisappear = false;
  			hitTick = 0;
  			isHit = false;
  		}
  	}
  	textAlign(LEFT);
  	textSize(50);
  	fill(135,206,250);
  	text("Lives: " + lives,10,50);
  	textAlign(RIGHT);
  	fill(255);
  	text(score,width - 10,50);
}

public void hyperspaceFunction()
{
	asteroids.clear();
  	radarArray.clear();
  	bulletArray.clear();
	starTrigger = true;
	hyperspaceOn = true;
	hyperspaceX = (int)(Math.random() * (width-46)+23);
	hyperspaceY = (int)(Math.random() * (height-46)+23);
	hyperspaceRotation = (int)(Math.random() * 360);
}

public void asteroidHit(int asteroid, boolean isScored)
{
	switch(asteroids.get(asteroid).getScale())
	{
		case 4:
			asteroids.add(new Asteroid(2,asteroids.get(asteroid).getX(), asteroids.get(asteroid).getY()));
			asteroids.get(asteroid).change(2);
			if (isScored) 
			{
				score += 20;
				scoreThisRound += 20;
			}
			break;
		case 2:
			asteroids.add(new Asteroid(1,asteroids.get(asteroid).getX(), asteroids.get(asteroid).getY()));
			asteroids.get(asteroid).change(1);
			if (isScored) 
			{
				score += 50;
				scoreThisRound += 50;
			}
			break;
		case 1:
			asteroids.remove(asteroid);
			if (isScored) 
			{
				score += 100;
				scoreThisRound += 100;
			}
			break;
	}
}
public void keyPressed()
{
	if (key == 'a' && hyperspaceOn == false)
	{
		left = true;
	}
	if (key == 'd' && hyperspaceOn == false)
	{
		right = true;
	}
	if (key == 'w' && hyperspaceOn == false)
	{
		forward = true;
	}
	if (key == 's' && hyperspaceOn == false)
	{
		backward = true;
	}
	if (key == 'q' && hyperspaceOn == false) 
	{
		if (asteroids.size() == 0) 
		{
			score += scoreThisRound;
			round += 1;
			scoreThisRound = 0;
		}
		hyperspaceFunction();
	}
	if (key == ' ' && hyperspaceOn == false && firing == false) 
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

public void hit()
{
	isHit = true;
	lives--;
	if (lives == 0)
	{
		gameOver = true;
		round = 0;
		score = 0;
		scoreThisRound = 0;
		hyperspaceFunction();
	}
}