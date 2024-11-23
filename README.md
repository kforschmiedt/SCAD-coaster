### Coasters and Magnets

intaglio.scad makes a disc or rectangle of a selected thickness. Vector
graphics and font glyphs may be projected onto the top surface of the disc,
building up images in top layers. They may also be projected INTO the top
surface, removing material before the ONTO projections are applied. By
choosing image thicknesses that are multiples of the slicers's layer
thicknesses, and changing filament between printed layers, graphics may be
printed in different colors.

Notes on Image files
----
Most of the SVG images I use here are licensed from iStock.com or similar
sources. The standard licenses grant the right to print a large or unlimited
number of items using the images, but specifically prohibit conveying the
images in standalone file form.

In other words, I cannot give you the EPS or SVG files that I used for most
of the presets in the JSON files.

Other notes
----

Multiple colors may be used by changing colors between layers. 

Use Graphic_Sub to subtract an image from the disc surface; set depth using
Graphic_Zadj. Use depths that are multiples of layer thickness to expose
desired color layers.
