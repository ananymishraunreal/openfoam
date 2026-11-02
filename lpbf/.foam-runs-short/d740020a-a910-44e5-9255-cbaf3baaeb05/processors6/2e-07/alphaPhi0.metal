/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  2506                                  |
|   \\  /    A nd           | Website:  www.openfoam.com                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      binary;
    arch        "LSB;label=32;scalar=64";
    class       decomposedBlockData;
    object      alphaPhi0.metal;
    data.format     ascii;
    data.class      surfaceScalarField;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //


// processor0
1217
(FoamFile
{
    version     2.0;
    format      ascii;
    arch        "LSB;label=32;scalar=64";
    class       surfaceScalarField;
    location    "2e-07";
    object      alphaPhi0.metal;
}
dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           uniform 0;
    }
    front
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           uniform 0;
    }
    bottomWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    procBoundary0to1
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary0to3
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary0to4
    {
        type            processor;
        value           uniform 0;
    }
}
)

// processor1
1145
(dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    front
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           uniform 0;
    }
    bottomWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    procBoundary1to0
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary1to2
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary1to4
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary1to5
    {
        type            processor;
        value           uniform 0;
    }
}
)

// processor2
921
(dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    front
    {
        type            calculated;
        value           uniform 0;
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           uniform 0;
    }
    bottomWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    procBoundary2to1
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary2to5
    {
        type            processor;
        value           uniform 0;
    }
}
)

// processor3
921
(dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           uniform 0;
    }
    front
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    bottomWall
    {
        type            calculated;
        value           uniform 0;
    }
    procBoundary3to0
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary3to4
    {
        type            processor;
        value           uniform 0;
    }
}
)

// processor4
1145
(dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    front
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    bottomWall
    {
        type            calculated;
        value           uniform 0;
    }
    procBoundary4to0
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary4to1
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary4to3
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary4to5
    {
        type            processor;
        value           uniform 0;
    }
}
)

// processor5
1024
(dimensions      [0 3 -1 0 0 0 0];

oriented        oriented;

internalField   uniform 0;

boundaryField
{
    back
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    front
    {
        type            calculated;
        value           uniform 0;
    }
    leftWall
    {
        type            calculated;
        value           uniform 0;
    }
    rightWall
    {
        type            calculated;
        value           uniform 0;
    }
    topWall
    {
        type            calculated;
        value           nonuniform List<scalar> 0();
    }
    bottomWall
    {
        type            calculated;
        value           uniform 0;
    }
    procBoundary5to1
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary5to2
    {
        type            processor;
        value           uniform 0;
    }
    procBoundary5to4
    {
        type            processor;
        value           uniform 0;
    }
}
)
