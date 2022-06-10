use <../little-box/files/boxlib.scad>
use <../lib/grommet.scad>
use <../lib/shapes.scad>

/* [Coaster Size] */
Length_Diameter = 100;
Width = 100;
Disc_Height = 4.8;
Corner_Radius = 10;
Rim_Radius = 3.9;
Rim_Height = 0.8;
Square_Disc = false;
Rounded_Rim = false;

/* [Features] */
Hanger_Size = .1;
Hanger_Surround = 1.4;
Hanger_Adjust = 35.5;
Hanger_Rotate = 0.1;

Reverse_Image = false;
Magnet_Back = false;
Magnet_Height = .1;
Magnet_Diameter = 2.2;

/* [Graphic1] */
Graphic1 = true;
Graphic_Flip1 = false;
Graphic_Sub1 = false;
Graphic_Scale1 = 0.707;
Graphic_Offset1 = -.001;
Graphic_Xadj1 = 0.1;
Graphic_Yadj1 = 0.1;
Graphic_Zadj1 = -0.001;
Graphic_XScale1 = 1.01;
Graphic_YScale1 = 1.01;
Graphic_Rotate1 = -2;
Graphic_Scale_To1 = 0;
Graphic_File1 = "c:/Users/kentf/Documents/CAD/Vector/pumpkin01.svg";

/* [Graphic2] */
Graphic2 = false;
Graphic_Flip2 = false;
Graphic_Sub2 = false;
Graphic_Scale2 = 0.707;
Graphic_Offset2 = -.001;
Graphic_Xadj2 = 0;
Graphic_Yadj2 = 0;
Graphic_Zadj2 = -0.001;
Graphic_XScale2 = 1.01;
Graphic_YScale2 = 1.01;
Graphic_Rotate2 = -2;
Graphic_Scale_To2 = 0;
Graphic_File2 = "c:/Users/kentf/Documents/CAD/Vector/pumpkin01.svg";

/* [Graphic3] */
Graphic3 = false;
Graphic_Flip3 = false;
Graphic_Sub3 = false;
Graphic_Scale3 = 0.707;
Graphic_Offset3 = -.001;
Graphic_Xadj3 = 0.1;
Graphic_Yadj3 = 0.1;
Graphic_Zadj3 = -0.001;
Graphic_XScale3 = 1.01;
Graphic_YScale3 = 1.01;
Graphic_Rotate3 = -2;
Graphic_Scale_To3 = 0;
Graphic_File3 = "c:/Users/kentf/Documents/CAD/Vector/pumpkin01.svg";

/* [Graphic4] */
Graphic4 = false;
Graphic_Flip4 = false;
Graphic_Sub4 = false;
Graphic_Scale4 = 0.707;
Graphic_Offset4 = -.001;
Graphic_Xadj4 = 0;
Graphic_Yadj4 = 0;
Graphic_Zadj4 = -0.001;
Graphic_XScale4 = 1.01;
Graphic_YScale4 = 1.01;
Graphic_Rotate4 = -2;
Graphic_Scale_To4 = 0;
Graphic_File4 = "c:/Users/kentf/Documents/CAD/Vector/pumpkin01.svg";

/* [Text1] */
Font1 = "Script MT Bold:style=Italic";
Text1 = "test";
Size1 = 10;
XText1 = 0;
YText1 = 0;

/* [Text2] */
Font2 = "Script MT Bold:style=Italic";
Text2 = "";
Size2 = 10;
XText2 = 0;
YText2 = 0;

/* [Text3] */
Font3 = "Script MT Bold:style=Italic";
Text3 = "";
Size3 = 10;
XText3 = 0;
YText3 = 0;

/* [Text4] */
Font4 = "Script MT Bold:style=Italic";
Text4 = "";
Size4= 10;
XText4 = 0;
YText4 = 0;


/* [Resolution] */
$fn=30;

module _graphic(
        G_Flip,
        G_Extend,
        G_Scale,
        G_Offset,
        G_Xadj,
        G_Yadj,
        G_Zadj,
        G_XScale,
        G_YScale,
        G_Rotate,
        G_Scale_To,
        G_File)
{
    adj_diam = G_Scale * Length_Diameter;
    sv =
    (G_Scale_To == 0)? [adj_diam*G_XScale, adj_diam*G_YScale, 0]:
    (G_Scale_To == 1)? [adj_diam, 0, 0]:
                       [0, adj_diam, 0];
    rad = Length_Diameter / 2;
    
    translate([-rad+G_Xadj, -rad+G_Yadj,
            Disc_Height+G_Zadj-G_Extend-Rim_Height-.004])

    rotate([0,0,G_Rotate])
        resize(sv, auto=[true,true,false])
        linear_extrude(Rim_Height+G_Extend+.005)
        mirror([G_Flip?1:0,0,0])
        offset(r=G_Offset) offset(delta=G_Offset)
            import(G_File, convexity=50);
}

module graphic(subtract=false)
{
    extend = (Disc_Height - Rim_Height)/2;
    if (Graphic1 && (subtract == Graphic_Sub1)) {
        _graphic(
            Graphic_Flip1,
            subtract?0:extend,
            Graphic_Scale1,
            Graphic_Offset1,
            Graphic_Xadj1,
            Graphic_Yadj1,
            Graphic_Zadj1,
            Graphic_XScale1,
            Graphic_YScale1,
            Graphic_Rotate1,
            Graphic_Scale_To1,
            Graphic_File1);
    }
    if (Graphic2 && (subtract == Graphic_Sub2)) {
        _graphic(
            Graphic_Flip2,
            subtract?0:extend,
            Graphic_Scale2,
            Graphic_Offset2,
            Graphic_Xadj2,
            Graphic_Yadj2,
            Graphic_Zadj2,
            Graphic_XScale2,
            Graphic_YScale2,
            Graphic_Rotate2,
            Graphic_Scale_To2,
            Graphic_File2);
    }
    if (Graphic3 && (subtract == Graphic_Sub3)) {
        _graphic(
            Graphic_Flip3,
            subtract?0:extend,
            Graphic_Scale3,
            Graphic_Offset3,
            Graphic_Xadj3,
            Graphic_Yadj3,
            Graphic_Zadj3,
            Graphic_XScale3,
            Graphic_YScale3,
            Graphic_Rotate3,
            Graphic_Scale_To3,
            Graphic_File3);
    }
    if (Graphic4 && (subtract == Graphic_Sub4)) {
        _graphic(
            Graphic_Flip4,
            subtract?0:extend,
            Graphic_Scale4,
            Graphic_Offset4,
            Graphic_Xadj4,
            Graphic_Yadj4,
            Graphic_Zadj4,
            Graphic_XScale4,
            Graphic_YScale4,
            Graphic_Rotate4,
            Graphic_Scale_To4,
            Graphic_File4);
    }
}

module _disc(rh)
{
    if (Rounded_Rim) {
        translate([0,0,(Disc_Height-rh)/2])
        cyl_rounded(height=Disc_Height-rh,
                    radius=Length_Diameter/2,
                    redge=Length_Diameter/20,
                    toponly=true,
                    center=true);
    } else {
        difference() {
            cylinder(h=Disc_Height, d=Length_Diameter);
            if (rh) {
                translate([0, 0, Disc_Height - rh])
                cylinder(h=rh + .01, d=Length_Diameter - 2 * Rim_Radius);
            }
        }
    }
}

module _sqdisc(rh)
{
    r1 = Corner_Radius;
    idl = Length_Diameter - 2*Rim_Radius;
    idw = Width - 2*Rim_Radius;
    
    translate([-Width/2, -Length_Diameter/2, 0])
    difference() {
    RoundedBox(size=[Width, Length_Diameter, Disc_Height],
               radius=r1,
               sidesonly=true);
    translate([Rim_Radius,Rim_Radius,Disc_Height-rh])
    RoundedBox(size=[idw, idl, rh+.003],
               radius=r1>Rim_Radius?r1-Rim_Radius:0,
               sidesonly=true); 
    }
}

module _text(text, font, size, x, y)
{
    if (len(text)) {
        translate([x, y, Disc_Height - Rim_Height - .05])
        rotate([0, 0, 0])
        #linear_extrude(Rim_Height + .05, center=false)
        text(text=text,
            size=size,
            halign="left",
            font=font,
            $fn=30);
    }
}

module dotext()
{
    _text(Text1, Font1, Size1, XText1, YText1);
    _text(Text2, Font2, Size2, XText2, YText2);
    _text(Text3, Font3, Size3, XText3, YText3);
    _text(Text4, Font4, Size4, XText4, YText4);
}

module disc(rh=Rim_Height)
{
    if (Square_Disc) {
        _sqdisc(rh);
    } else {
        _disc(rh);
    }
}

module magback()
{
    if (Magnet_Back) {
        translate([0,0,-.001]) {
          cylinder(h=Magnet_Height+.001, d=Magnet_Diameter);
          cylinder(h=.751, r1=Magnet_Diameter/2 + .3,
                           r2=Magnet_Diameter/2 - .001);
        }
        translate([-(Magnet_Diameter+2)/2,-.25,-.001])
          RoundedBox(size=[Magnet_Diameter+2,1,Magnet_Height+.001],
                     radius=.3, sidesonly=true);
    }
}

module renderit()
{
    x = Hanger_Adjust * cos(Hanger_Rotate+90);
    y = Hanger_Adjust * sin(Hanger_Rotate+90);

    if (Reverse_Image) {
        difference() {
            grommet(h=Disc_Height,
                r=Hanger_Size<.2?0:Hanger_Size,
                thickness=Hanger_Surround,
                offset=[x, y, Disc_Height/2])
            {
                disc(rh=0);
            }
            #graphic();
            magback();
        }
    } else {
        difference() {
            grommet(h=Disc_Height,
                    r=Hanger_Size<.2?0:Hanger_Size,
                    thickness=Hanger_Surround,
                    offset=[x, y, Disc_Height/2])
            {
                difference() {
                    disc(rh=Rim_Height);
                    #graphic(subtract=true);
                }
                #graphic();
                dotext();
            }
            magback();
        }
    }
}


renderit();

//import(Graphic_File1, convexity=50);