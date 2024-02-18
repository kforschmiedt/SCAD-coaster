// just extrude an SVG

Height = 95;
Wscale = .91;
Thick = 1.75;

Graphic = "D:/misc/CAD/Vector/Fonts/Bakery/0.svg";

rv = [0, Height, 0];
scale([Wscale, 1, 1])
resize(rv, auto=[true,false,false])
linear_extrude(height=Thick)
import(Graphic, convexity=5);