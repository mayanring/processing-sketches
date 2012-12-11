class Circle {
  PVector position;
  color myColor;
  float radius;
  
  Circle(int x, int y, float theRadius, color theColor) {
    position = new PVector( x, y );
    radius = theRadius;
    myColor = theColor;
  }
  
  void display() {
    noStroke();
    ellipseMode(RADIUS);
    fill( myColor );
    ellipse( position.x, position.y, radius, radius );
  }
  
  color getDominantColor() {
//    PImage boundingBox = img.get( int(position.x - radius), int(position.y - radius), int(radius), int(radius) );
//    boundingBox.resize(1, 1);
//    return boundingBox.pixels[0];
    return img.get( int(position.x), int(position.y) );
  }
}

PImage img;
Circle circle;
int columns = 10;
int rows = 0;
float gutter = 0.5; // gutter as a fraction of the radius
float radius = 0.0;
ArrayList circles;

void setup() {
 circles = new ArrayList();

 img = loadImage("mona_lisa_medium.jpg");
 size(img.width, img.height);
 
 radius = calculateRadius( columns, img.width );
 rows = calculateRows( radius, img.height );
 
 println( "With " + columns + " columns, there will be " + rows + " rows at a radius of " + radius );

 for( int j = 0; j < rows; j++ ) {
   for( int i = 0; i < columns; i++ ) {
     circles.add( new Circle( int(radius + i*2*radius + i*gutter*radius), int(radius + j*2*radius + j*gutter*radius), radius, #FFFFFF ) );
   }
 }
 
// circle = new Circle( 100, 100, radius, #FFFFFF );
 
// image(img, 0, 0);
 background( #FFFFFF );
 
 for( int i = 0; i < circles.size(); i++ ) {
   color dominant;
   circle = (Circle)circles.get(i);
   dominant = circle.getDominantColor();
   println( "circle " + i + ", dominant is : " + dominant ); 

   circle.myColor = dominant;
   circle.display();
 }
}

float calculateRadius( int columns, int image_width ) {
  return image_width / ( 2 * columns + gutter * columns - gutter );
}

int calculateRows( float radius, int image_height ) {
  return int((image_height + (gutter * radius)) / (2*radius + gutter*radius));
}

void draw() {
}
