class Hyperbeam
{
    int myX, myY, tick;
    float myRotation;
    public Hyperbeam() 
    {
        myX = 0;
        myY = 0;
        tick = 0;
    }
    public void show(int x, int y, float rotation, boolean continued)
    {
        tick += 1;
        //x and y are located at the center of the triangle base.
        myX = x;
        myY = y;
        //rotation will be ship.getPointRotation();
        myRotation = (float)((rotation)*(Math.PI/180));;
        noStroke();
        translate((float)x,(float)y);
        rotate(myRotation);
        fill(135,206,250);
        rect(-sqrt(sq(width)+sq(height)),-25,sqrt(sq(width)+sq(height))*2,50);
        if (tick > 30 || continued)
        {
            fill(255);
            rect(-sqrt(sq(width)+sq(height)),-20,sqrt(sq(width)+sq(height))*2,40);
            //rect(width/2,height/2,sqrt(width^2+height^2),500);
        }
        rotate(-myRotation);
        translate(-(float)x,-(float)y);
    }
    public void reset() {tick = 0;}
}