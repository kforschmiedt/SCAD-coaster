use <../lib/grommet.scad>

/* [Size] */
Diameter = 100;
Height = 4.8;
Sand_Height = 0.56;

/* [Features] */
Hanger_Size = .1;
Hanger_Surround = 1.4;
Hanger_Adjust = 35.5;
Hanger_Rotate = 0.1;

/* [Frame] */
Frame_Radius = 40;
Frame_Rotate = 0;
Frame_fn = 4;

/* [Graphic1] */
Graphic1 = true;
Graphic_Flip1 = false;
Graphic_Scale1 = 1.01;
Graphic_Xadj1 = 0.1;
Graphic_Yadj1 = 0.1;
Graphic_Zadj1 = 0;
Graphic_XScale1 = 1.01;
Graphic_YScale1 = 1.01;
Graphic_Twist1 = 0;
Graphic_Rotate1 = -2;
Graphic_Scale_To1 = 0;
Graphic_File1 = "c:/Users/kentf/Documents/CAD/Vector/snowflake01-01.svg";

/* [Resolution] */
$fn=30;

/* [Selection]*/
Make_Ornament = false;
Make_Frame = false;
Make_Sandwich = false;
Make_Bread = false;

module _graphic(
        G_Flip,
        G_Height,
        G_Scale,
        G_Xadj,
        G_Yadj,
        G_Zadj,
        G_XScale,
        G_YScale,
        G_Twist,
        G_Rotate,
        G_Scale_To,
        G_File)
{
    adj_diam = G_Scale * Diameter;
    sv =
    (G_Scale_To == 0)? [adj_diam*G_XScale, adj_diam*G_YScale, 0]:
    (G_Scale_To == 1)? [adj_diam, 0, 0]:
                       [0, adj_diam, 0];
    rad = Diameter / 2;
    translate([-rad+G_Xadj, -rad+G_Yadj, 0])
    rotate([0,0,G_Rotate])
    resize(sv, auto=[true,true,false])
        linear_extrude(G_Height, twist=G_Twist)
        mirror([G_Flip?1:0,0,0])
        offset(-0.001)
        import(G_File, convexity=50);
}

module graphic(sandwich=false)
{
    if (Graphic1) {
        _graphic(
            Graphic_Flip1,
            sandwich?Sand_Height:Height,
            Graphic_Scale1,
            Graphic_Xadj1,
            Graphic_Yadj1,
            Graphic_Zadj1,
            Graphic_XScale1,
            Graphic_YScale1,
            Graphic_Twist1,
            Graphic_Rotate1,
            Graphic_Scale_To1,
            Graphic_File1);
    }
}

module frame()
{
    translate([0,0,.001])
    linear_extrude(height=Height-.002)
    rotate([0,0,Frame_Rotate])
    circle(r=Frame_Radius, $fn=Frame_fn);
}

module do_ornament()
{
    x = Hanger_Adjust * cos(Hanger_Rotate+90);
    y = Hanger_Adjust * sin(Hanger_Rotate+90);

    grommet(h=Height,
            r=Hanger_Size<.2?0:Hanger_Size,
            thickness=Hanger_Surround,
            offset=[x, y, Height/2])
    {
        graphic();
    }
}

module do_frame()
{
    difference() {
        frame();
        graphic();
    }
}

module do_sandwich()
{
    difference() {
        frame();
        graphic(sandwich=true);
        translate([0,0,Height-Sand_Height])
            graphic(sandwich=true);
    }
}

module do_bread()
{
    graphic(sandwich=true);
    translate([0,0,Height-Sand_Height])
        graphic(sandwich=true);
}

if (Make_Ornament)
    do_ornament();

if (Make_Frame)
    do_frame();

if (Make_Sandwich)
    do_sandwich();

if (Make_Bread) {
    do_bread();
}