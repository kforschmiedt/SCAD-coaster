use <../little-box/files/boxlib.scad>
//use <../lib/grommet.scad>
//use <../lib/shapes.scad>

/* [Stuff] */
Thickness = 3.2;

Round = false;
Width = 105;
Height = 40;
Offset = 10;
Radius = 10;
Extend = 10;
XScale = 100;
YScale = 100;

$fn = 30;
fa_rim = 3;

function SemiPoints(thickness, fa=6) = [
    for (a = [180:-fa:0])
        [cos(a)*thickness/2, sin(a)*thickness/2] ];

// make a semicircle in x, z
semipts = SemiPoints(Thickness, fa=fa_rim);
npts = floor(180 / fa_rim + 1);


module Corner(r, h, thickness)
{
    cornerpts = [
        for (a = [0:fa_rim:90])
        let (cosa=cos(a), sina=sin(a))
        each concat(
            [[(r-thickness/2)*cosa, (r-thickness/2)*sina, 0]],
            [for (p=semipts) 
                [ (r+p[0])*cosa,
                  (r+p[0])*sina,
                  h +p[1] ]],
            [[(r+thickness/2)*cosa, (r+thickness/2)*sina, 0]]
        )
    ];

    nframe = floor(90 / fa_rim + 1);
    ncycle = npts + 2;
    //echo("Corner", "nframe", nframe, "ncycle", ncycle);

    faces = concat(
        [[ for (n = [0:ncycle-1]) n ]],
        [[ for (n = [ncycle-1:-1:0]) (nframe-1) * ncycle + n ]],
        [
            for (f = [0:nframe-2])
                let (f0base = f * ncycle, f1base = (f+1)*ncycle)
                for (n = [0:ncycle-2])
                    [f0base+n, f1base+n, f1base+n+1, f0base+n+1, f0base+n]
        ],
        [
            for (f = [0:nframe-2])
            let (f0base = f * ncycle, f1base = (f+1)*ncycle)
                [f1base, f0base, f0base+ncycle-1, f1base+ncycle-1, f1base]
        ]
    );
    polyhedron(points=cornerpts, faces=faces, convexity=5);
}

module Wall(h, l, thickness)
{
    wallpts = [
            [0, semipts[0][0], 0],
            for (p=semipts) 
                [ 0, p[0], h+p[1] ],
            [0, semipts[npts-1][0], 0],
            [l, semipts[0][0], 0],
            for (p=semipts) 
                [ l, p[0], h+p[1] ],
            [l, semipts[npts-1][0], 0]
    ];

    nframe = 1;
    ncycle = npts + 2;
    //echo("Wall", "nframe", nframe, "ncycle", ncycle);

    faces = concat(
        [[ for (n = [ncycle-1:-1:0]) n ]],
        [[ for (n = [0:ncycle-1]) ncycle + n ]],
        [for (n = [0:ncycle-2])
                [ncycle+n, n, n+1, ncycle+n+1, ncycle+n]
        ],
        [[0, ncycle, ncycle+ncycle-1, ncycle-1, 0]]
    );
    polyhedron(points=wallpts, faces=faces, convexity=2);

}

module SinWall(h, l, offset, thickness, start=90, end=270, over=0)
{
    inc = (end - start) / l;
    scale = (h - offset)/2;

    wallpts = [
        for (x = [0:l])
        let (sina = sin(start + inc * x),
             // extend ends a tiny mit so butt ends will fuse
             xx = ((x==0)?-over:((x==l)?over:0)))
        each concat(
            [[x+xx, -thickness/2, 0]],
            [for (p=semipts)
                [ x+xx, p[0],
                  offset + scale + sina*scale+p[1] ]],
            [[x+xx, thickness/2, 0]]
        ),
    ];

    //echo("wallpts", wallpts);

    nframe = l;
    ncycle = npts + 2;
    //echo("nframe", nframe, "ncycle", ncycle);

    faces = concat(
        [[ for (n = [0:ncycle-1]) n ]],
        [[ for (n = [ncycle-1:-1:0]) nframe * ncycle + n ]],
        [
            for (f = [0:nframe-1])
                let (f0base = f*ncycle, f1base = (f+1)*ncycle)
                for (n = [0:ncycle-2])
                    [f0base+n, f1base+n, f1base+n+1, f0base+n+1, f0base+n]
        ],
        [
            for (f = [0:nframe-1])
            let (f0base = f * ncycle, f1base = (f+1)*ncycle)
                [f0base, f0base+ncycle-1, f1base+ncycle-1, f1base, f0base]
        ]
    );

//    echo("faces", faces);

    polyhedron(points=wallpts, faces=faces, convexity=5);

}

module RoundWall(h, r, thickness, start, end, dosin=true,
                        offset=0, inc=360/$fn, freq=3)
{
    height = h-offset;
    _end = start + inc * floor((end - start)/inc);
    
    // rotate and combine with sin
    wallpts = [
        for (a = [start:inc:_end+inc])
        // extend the span a small amount so ends will fuse
        let (aa = ((a==start)?-.01:((a==_end+inc)?.01:0)),
             cosa=cos(a+aa),
             sina=sin(a+aa),
             sinfast=cos(a*freq))
        each concat(
            [[(r-thickness/2)*cosa, (r-thickness/2)*sina, 0]],
            [for (p=semipts) 
                [ (r+p[0])*cosa,
                  (r+p[0])*sina,
                  (dosin? ((1-sinfast)*height/2+offset+p[1]) :
                          (height+offset+p[1])) ]],
            [[(r+thickness/2)*cosa, (r+thickness/2)*sina, 0]]
        )
    ];
    
    //echo(wallpts);

    nframe = ((_end - start) / inc);
    ncycle = npts + 2;
    //echo("nframe", nframe, "ncycle", ncycle);

    faces = concat(
        [[ for (n = [0:ncycle-1]) n ]],
        [[ for (n = [ncycle-1:-1:0]) nframe * ncycle + n ]],
        [
            for (f = [0:nframe-1])
                let (f0base = f * ncycle, f1base = (f+1)*ncycle)
                for (n = [0:ncycle-2])
                    [f0base+n, f1base+n, f1base+n+1, f0base+n+1, f0base+n]
        ],
        [
            for (f = [0:nframe-1])
            let (f0base = f * ncycle, f1base = (f+1)*ncycle)
                [f1base, f0base, f0base+ncycle-1, f1base+ncycle-1, f1base]
        ]
    );

    //echo("faces", faces);

    polyhedron(points=wallpts, faces=faces, convexity=5);
}

module RoundBox()
{

    RoundWall(
            h=Height,
            r=Width/2, 
            thickness=Thickness,
            start=30,
            end=330,
            inc=2,
            dosin=false
    );

    RoundWall(
            h=Height,
            r=Width/2, 
            thickness=Thickness,
            start=-30,
            end=30,
            inc=2,
            dosin=true,
            freq=6,
            offset=Offset
    );

    cylinder(h=Thickness, d=Width);
}

module SqBox()
{
    for (tr = [[0, Width-Radius, Width-Radius],
               [90, Radius, Width-Radius],
               [180, Radius, Radius],
               [270, Width-Radius, Radius]])
    {
        translate([tr[1], tr[2], 0])
        rotate([0,0,tr[0]])
        Corner(r=Radius, h=Height, thickness=Thickness);
    }

    for (tr = [
               [0, Radius-.001, 0],
               //[90, Width, Radius-.001],
               [0, Radius-.001, Width],
               //[90, 0, Radius-.001]
    ])
    {
        translate([tr[1], tr[2], 0])
        rotate([0,0,tr[0]])
        Wall(h=Height, l=Width-2*Radius+.002, thickness=Thickness);
    }

    for (tr = [
               //[0, Radius+Extend-.001, 0],
               [90, Width, Radius+Extend-.001],
               //[0, Radius+Extend-.001, Width],
               [90, 0, Radius+Extend-.001]
    ])
    {
        translate([tr[1], tr[2], 0])
        rotate([0,0,tr[0]])
        SinWall(h=Height, l=Width-2*Radius-2*Extend, offset=Offset,
                thickness=Thickness,
                start=90,
                end=450,
                over=Extend+.002);
    }

    // bottom
    RoundedBox(size=[Width, Width, Thickness],
               radius=Radius,
               sidesonly=true);
}

module Box()
{
    if (Round) {
        scale([XScale/100, YScale/100, 1])
        RoundBox();
    } else {
        SqBox();
    }
}



Box();
