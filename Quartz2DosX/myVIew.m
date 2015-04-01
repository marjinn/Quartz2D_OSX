//
//  myVIew.m
//  Quartz2DosX
//
//  Created by mar Jinn on 1/24/15.
//  Copyright (c) 2015 mar Jinn. All rights reserved.
//

#import "myVIew.h"

#include "drawingCode.h"

@implementation myVIew

void setBackgroundColorOfRect(CGContextRef context, NSRect dirtyRect)
{
    //set a background color
    CGContextSetRGBFillColor(context, 0.0f, 1.0f, 1.0f, 1.0f);
    
    //CGContextFillRect(context, (CGRect)dirtyRect);//works
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

void flipCoordinatesThroughXaxis (CGContextRef contetx, CGRect bounds)
{
    //i.e. move y axis up so that (0,0) is at the top left
    //Core Graphics - (0,0) bottom left
    CGContextTranslateCTM(contetx, 0.0f, bounds.size.height);
    
    CGContextScaleCTM(contetx, 1.0f, -1.0f);
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
    NSGraphicsContext* nsContext = nil;
    nsContext = [NSGraphicsContext currentContext];
    
    CGContextRef context = NULL;
    context = (CGContextRef)[nsContext graphicsPort];
    
    //flipCoordinatesThroughXaxis(context, NSRectToCGRect(dirtyRect));
    
    //background color
    //setBackgroundColorOfRect(context, dirtyRect);
    
    //drawCoordinateAxes(context);
    
    //doAlphaRects(context);
    
    //not necessary
    //CGContextSynchronize(context);
    
    //drawASquare(context);
    
    //drawARotatedAndScaledRectangle(context);
    
    //drawARotatedAndScaledRectangleWithContextSaves(context);
    
    //drawAnEllipseWithoutAffineTransform(context);
    
    //drawAnEllipse(context);
    
    //drawRotatedEllipses(context);
    
    //drawRotatedEllipsesWithTransforms(context);
    
    //drawSkewedCoordinateSystem(context);
    
    //drawSkewedRectangles(context);
    
    //drawScewedCoordinateSystem_(context);
    
    /**
     *  curves
     */
    //doEgg(context);
    
    //doEggWithoutModifications(context);
    
    //drawQuadraticBezierCurve(context);
    
    //addRoundedRectToPath(context,CGRectMake(10.0f, 10.0f, 210.0f, 150.0f),100.0f,100.0f);
    
    //doRoundedRects(context);
    
    //fills ellipse instead of stroking
    //myContextAddEllipseInRect(context, CGRectMake(100.0f, 100.0f, 200.0f, 50.0f));
    
    //drawLineSegemnts(context);
    
    //doStrokeWithCTM(context);
    
    //doRotatedEllipsesWithCGPath(context);
    
   // doPixeAlignedFillAndStroke(context);
    
    //doColorSpaceFillAndStroke(context);
    
    drawWithColorRefs(context);
    
    
    /**
     *  from DrawingCode
     *
     */
    
    //cdoDrawing(context);
}

void drawCoordinateAxes (CGContextRef context)
{
    /**
     *  draw Coordinate axes
     */
    
    //setLineWidth
    CGContextSetLineWidth(context, 5.0f);
    
    //drawing lines
    //begin path
    CGContextBeginPath(context);
    
    //x- axis
    //move to starting point
    CGContextMoveToPoint(context, -2000.0f, 0.0f);
    
    //add line to end point
    CGContextAddLineToPoint(context, 2000.0, 0.0f);
    
    //draw path
    CGContextDrawPath(context, kCGPathStroke);
    
    //y-axis
    //starting point
    CGContextMoveToPoint(context, 0.0f, -2000.0);
    
    //end point
    CGContextAddLineToPoint(context, 0.0f, 2000.0f);
    
    //drawPath
    CGContextDrawPath(context,kCGPathStroke);
}

void doAlphaRects(CGContextRef context)
{
    //the rect
    CGRect ourRect = {{0.0f, 0.0f}, {130.0f, 100.0f}};
    int i, numRects = 6;
    float rotateAngle = 2 * M_PI / numRects;
    float tint, tintAdjust = 1.0/numRects;
    
    //translate context
    CGContextTranslateCTM(context, 2* (ourRect.size.width), 2 * (ourRect.size.height));
    
    
    for (i = 0, tint = 1.0f; i < numRects; i++, tint = tint - tintAdjust )
    {
        /**
         *  setcolor
         * fillrect
         * rotateCTM
         */
        CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, tint);
        
        CGContextFillRect(context, ourRect);
        
        CGContextRotateCTM(context, rotateAngle);//cumilative
    }
   
}

void drawASquare (CGContextRef context)
{
    //begin path
    CGContextBeginPath(context);
    
    //draw Coordinate Axes
    drawCoordinateAxes(context);
    
    //line width
    CGContextSetLineWidth(context, 15.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 0.0f, 1.0f);
    
    //begin at (0,0)
    CGContextMoveToPoint(context, 25.0f, 25.0f);
    
    //move to 0,50) //along y
    CGContextAddLineToPoint(context, 25.0f, 50.0f);
    
    //move to (50,50) //
    CGContextAddLineToPoint(context, 50.0f, 50.0f);
    
    //move to (50,0)
    CGContextAddLineToPoint(context, 50.0f, 25.0f);
    
    //move to (0,0)
    //CGContextAddLineToPoint(context, 17.0f, 25.0f);
    CGContextClosePath(context);
    
    //draw
    CGContextStrokePath(context);

}

/**
 *  CGAFFineTransform
 */
/*
 (x' y' 1) = (x y 1) a  b  0
                     c  d  0
                     tx ty 1
 
 a b c d deals with rotation and scaling
 tx ty   deals with translation

 
 Point' = Pont x Mtransform
 
 TransformationMatrixForTranslation
 
 M_translate =  1  0  0
                0  1  0
                tx ty 1
 
 Transformation matrix for scaling of sx in x and sy in y
 
 M_scale = sx  0  0 
            0  sy 0
            0  0   1
 
 
 Transformation matrix for rotation
 //about the origin by the angle theta o
 
 m_rotate = cosθ   sinθ  0
            -sinθ  cosθ  0
            0       0    1
 
 
 M_translate =  1   0   0
                0   1   0
                72  36  1
 
 
 M_scale =      2   0   0
                0   2   0
                0   0   1
 
 
 Mt,s = M_scale x M_translate = 2   0   0       1   0   0
                                0   2   0       0   1   0
                                0   0   1       72  36  1
 
                        mt,s =  2   0   0
                                0   2   0
                                72  36  1
 
 
 
 Mt,s = M_translate x M_scale = 1   0   0   2   0   0
                                0   1   0   0   2   0
                                72  36  1   0   0   1
 
                    mt,s =  2   0   0
                            0   2   0
                            144 72  1
 
 
 
 
 */

//without context Save
void drawARotatedAndScaledRectangle (CGContextRef context)
{
    //rect
    CGRect const ourRect = { {0.0f, 0.0f}, {72.0f, 72.0f} };
    
    //draw unrottaed coo-rdinate axis
    drawCoordinateAxes(context);
    
    //fill the unscaled Rectangle
    CGContextSetRGBFillColor(context,
                             204.0f/255.0f,
                             0.0f,
                             204.0f/255.0f,
                             1.0f);
    CGContextFillRect(context, ourRect);
    
    //rotate the coordinate system by 30 degrees
    CGContextRotateCTM(context, M_PI/6);
    
    //scale by 0.5in x and2.0 in y
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    CGContextSetRGBStrokeColor(context, 0.69f, 0.486f, 0.722, 1.0f);
    
    //
    drawCoordinateAxes(context);
    
    //fillRect
    CGContextFillRect(context, ourRect);
    
    
}

void drawARotatedAndScaledRectangleWithContextSaves (CGContextRef context)
{
    //rect
    CGRect const ourRect = {{0.0f,0.0f},{72.0f,72.0f}};
    
    //draw axes
    drawCoordinateAxes(context);
    
    /**
     *  Rectangle 1
     */
    
    CGContextFillRect(context, ourRect);
    
    //make  a snapshot of the CTM and other drawing parameters
    CGContextSaveGState(context);
    
    //rotate by 30
    CGContextRotateCTM(context, M_PI/6);//in radians
    
    //scale 0,5 in x 2.0y
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    //stroke and fill color
    CGContextSetRGBStrokeColor(context,
                               0.69f,
                               0.486f,
                               0.722,
                               1.0f);
    
    CGContextSetRGBFillColor(context,
                             0.69f,
                             0.486f,
                             0.722,
                             0.7f);
    
    //draw axis
    drawCoordinateAxes(context);
    
    /**
     *  Recatngle 2
     */
    CGContextFillRect(context, ourRect);
    
    //restore the snapshot of the CTM and other drawing parameters
    CGContextRestoreGState(context);
    //This coordinate system is the one before any transformations
    
    //translate to right
    CGContextTranslateCTM(context, 288.0f, 0.0f);
    
    drawCoordinateAxes(context);
    
    
    /**
     *  Rectangle 3
     */
    CGContextFillRect(context, ourRect);
    
    //save current state
    CGContextSaveGState(context);
    
    //scale
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    //rotate
    CGContextRotateCTM(context, M_PI/6);
    
    //stroke and fill color
    CGContextSetRGBStrokeColor(context,
                               0.965f,
                               0.584f,
                               0.059,
                               1.0f);
    
    CGContextSetRGBFillColor(context,
                             0.965f,
                             0.584f,
                             0.059,
                             1.0f);
    
    drawCoordinateAxes(context);
    
    /**
     *  Rectangle 4
     */
    CGContextFillRect(context, ourRect);
    
    //restore
    CGContextRestoreGState(context);
    
    
}

void drawAnEllipseWithoutAffineTransform (CGContextRef context)
{
    //we translate t0 100.0 100.0
    //we make  ascale of 2.0in x and 1.0y
    //we draw a circle
    
    CGContextSetRGBFillColor(context,
                             0.69f,
                             0.486f,
                             0.722,
                             0.7f);
    
    CGContextScaleCTM(context, 2.0f, 1.0f);
    
    CGContextTranslateCTM(context, 100.0f, 100.0f);
    
    //begin path
    CGContextBeginPath(context);
    
    //add an arc - circle
    CGContextAddArc(context,
                    0.0f,
                    0.0f,
                    45.0f,
                    0.0f,
                    2 * M_PI,
                    false);
    
    //draw
    CGContextDrawPath(context, kCGPathFill);
    
    
}

void drawAnEllipse (CGContextRef context)
{
    //create the transfomrmatrix for scale
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeScale(2.0f, 1.0f);
    
    CGContextTranslateCTM(context, 100.0f, 100.0f);
    
    //concatenate affine transform
    CGContextConcatCTM(context, transform);
    
    //begin path
    CGContextBeginPath(context);
    
    //draw circle
    CGContextAddArc(context,
                    0.0f,
                    0.0f,
                    45.0f,
                    0.0f,
                    2 * M_PI,
                    false);
    
    CGContextSetRGBFillColor(context,
                             0.69f,
                             0.486f,
                             0.722,
                             0.7f);
    
    CGContextDrawPath(context, kCGPathFill);
    
    
}

void drawRotatedEllipses (CGContextRef context)
{
    unsigned int i, totReps = 144;
    
    float tint = 1.0f, tintIncrement = 1.0/totReps;
    
    //translate to move the ellipse to a good location
    CGContextTranslateCTM(context, 100.0f,100.0f);
    
    for (i = 0; i < totReps; i++)
    {
        //make snapshot of the context
        CGContextSaveGState(context);
        
        //rotate 45
        CGContextRotateCTM(context, M_PI/4.0f);
        
        //scale (1,2)
        CGContextScaleCTM(context, 1.0f, 2.0f);
        
        /**
         *  draw ellipse
         */
        //begin path
        CGContextBeginPath(context);
        
        //add arc i.e circle
        CGContextAddArc(context,
                        0.0f,
                        0.0f,
                        45.0f,
                        0.0f,
                        2 * M_PI,
                        false);
        
        //color
        CGContextSetRGBFillColor(context,
                                 tint,
                                 0.0f,
                                 0.0f,
                                 1.0f);
        
        //draw
        CGContextDrawPath(context, kCGPathFill);
        
        //restore the coordinate system to that of the snapshot
        CGContextRestoreGState(context);
        
        //decremnet tint color
        tint -= tintIncrement;
        
        //move bt 1 unit in x for the next ellipse
        CGContextTranslateCTM(context, 1.0f, 0.0f);
    }
    
    
}

//drawing blend
void drawRotatedEllipsesWithTransforms (CGContextRef context)
{
    unsigned int i, totReps = 144;
    
    float tint = 1.0f, tintIncrement = 1.0/totReps;
    
    //create a new transform 45- degree rotation
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeRotation(M_PI/4.0f);
    
    //apply a scale to the transform just created
    transform = CGAffineTransformScale(transform, 1.0f, 2.0f);
    
    //place the first ellipse in a good location
    CGContextTranslateCTM(context, 100.0f, 100.0f);
    
    for (i = 0; i < totReps; i++)
    {
        //save context
        CGContextSaveGState(context);
        
        //concat - multiples transforms ie cuttent CTM and the transform
        CGContextConcatCTM(context, transform);
        
        /**
         *  draw ellipse
         */
        CGContextBeginPath(context);
        
        //draw circle
        CGContextAddArc(context,
                        0.0f,
                        0.0f,
                        45.0f,
                        0.0f,
                        2 * M_PI,
                        false);
        
        //color
        CGContextSetRGBFillColor(context,
                                 tint,
                                 0.0f,
                                 0.0f,
                                 1.0f);

        CGContextDrawPath(context, kCGPathFill);
        
        //restore state
        CGContextRestoreGState(context);
        
        //compute next tint color
        tint -= tintIncrement;
        
        //move bt 1 unit in x for the next ellipse
        CGContextTranslateCTM(context, 1.0f, 0.0f);
    }
    
}


/**
 *  Skewed drawing
 ------ where x axis is rotated towards y-axis by angle α and 
 ------- y axis is rotaed toward x axis by an angle of β
            all rotations made relative to untransformed x and y axes
 
 M_skew =   1     tan α       0
            tanβ    1         0
            0       0         1

 
 steps
 1. draw x and y axis
 2. draw a square at origin
 3. make the transform i.e skew transform
 4. concatCTM i.e apply it to ctm
 5. draw x and y axis
 7. draw a square at origin
 
 */

void drawSkewedCoordinateSystem (CGContextRef context)
{
    //α = 22.5   β = 15
    float const alpha = M_PI / 8.0f; // 180/8
    float const beta  = M_PI / 12.0f;// 180/12
    
    CGAffineTransform skew = CGAffineTransformIdentity;
    
    //create a rectangle that is 72 units on a side
    //with its origin at (0,0)
    CGRect rect = CGRectZero;
    rect = CGRectMake(0.0f, 0.0f, 72.0f, 72.0f);
    
    //move to (144,144)
    CGContextTranslateCTM(context, 144.0f, 144.0f);
    
    //draw coordinate axes - utransformed
    drawCoordinateAxes(context);
    
    //color
    CGContextSetRGBFillColor(context,
                             1.0,
                             0.0f,
                             0.0f,
                             1.0f);
    //fill the rectangle
    CGContextFillRect(context, rect);
    
    /**
     *  draw a skewed transform
     
     
     TransformMatrix =  a  b  0
                        c  d  0
                        tx ty 1
     
     M_skew =   1     tan α       0
                tanβ    1         0
                0       0         1
     
     * x axis by alpha radians and
     *  y axis by beta radians
     
     */
    /*
     CGAffineTransform CGAffineTransformMake (
     CGFloat a,
     CGFloat b,
     CGFloat c,
     CGFloat d,
     CGFloat tx,
     CGFloat ty
     );
     */
    skew = CGAffineTransformMake(1.0f,
                                 (CGFloat)tan((double)alpha),
                                 (CGFloat)tan((double)beta),
                                 1.0f,
                                 0.0f,
                                 0.0f
                                 );
    
    //apply this transfrom to CTM
    CGContextConcatCTM(context, skew);
    
    //stroke color - dark blue
    CGContextSetRGBStrokeColor(context,
                               0.11f,
                               0.208f,
                               0.451f,
                               1.0f);
    
    CGContextSetRGBFillColor(context,
                               0.11f,
                               0.208f,
                               0.451f,
                               1.0f);
    
    //draw coordinate axes - transformed
    drawCoordinateAxes(context);
    
    //set fillcolor - alpha 0.7
    CGContextSetRGBFillColor(context,
                             0.11f,
                             0.208f,
                             0.451f,
                             0.7f);
    
    CGContextFillRect(context, rect);
}

/**
 *  Curved Paths
 * Bezier curves
 */

void doEgg(CGContextRef context)
{
    CGPoint p0 = CGPointZero;
    CGPoint p1 = {0.0f, 200.0f};
    
    CGPoint c1 = {100.0f,100.0f};
    CGPoint c2 = {110.0f, 110.0f};
    
    //move to point (100,5)
    CGContextTranslateCTM(context, 100.0f, 5.0f);
    
    drawCoordinateAxes(context);
    
    //begin path
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    //bezeir path segment for the right side of the egg
    //- DARK RED
    CGContextAddCurveToPoint(context,
                             c2.x,  //0     controlPoint 1 //bottom
                             c2.y,  //50    controlPoint 1
                             c1.x,  //100   controlPoint 2 //top
                             c1.y,  //150   controlPoint 2
                             p1.x,  //0     endPoint 1
                             p1.y); //200   endPoint 1
    
    /**
     *  control point 1 is at the bottom of the curve
     *  control point 2 is at the top
     
     * if x of control point 1 moves curve bulge at bottom moves in x direction
     */
    
    
    CGContextSetRGBStrokeColor(context, 153.0f/255.0f, 0.0f, 73.0f/255.0f, 1.0f);
    
    //CGContextAddLineToPoint(context, p0.x, p0.y);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //end point of curve - RED
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    CGContextAddLineToPoint(context, p1.x, p1.y);
     CGContextDrawPath(context, kCGPathStroke);
    
    //control point 1 - GREEN - bottom portion of the curve
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextSetRGBStrokeColor(context, 0.0f, 1.0f, 0.0f, 1.0f);
    CGContextAddLineToPoint(context, c1.x, c2.y);
    CGContextDrawPath(context, kCGPathStroke);
    
    //control point 2 - BLUE - Top Portion of the curve
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 1.0f, 1.0f);
    CGContextAddLineToPoint(context, c2.x, c2.y);
     CGContextDrawPath(context, kCGPathStroke);
    
    
    CGContextMoveToPoint(context, p0.x, p0.y);
    

    //bezeir path for the left side of the egg
//    CGContextAddCurveToPoint(context,
//                             c2.x,
//                             c2.y,
//                             c1.x,
//                             c1.y,
//                             p0.x,
//                             p0.y);
    
    //CGContextClosePath(context);
    
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    /**
     *  Quadratic bezier Curve
     */
    
//    CGContextMoveToPoint(context, p0.x, p0.y);
//    
//    CGContextAddQuadCurveToPoint(context, c2.x, c2.y, p1.x,p1.y);
//    
//    CGContextDrawPath(context, kCGPathStroke);
}

void doEggWithoutModifications(CGContextRef context)
{
    //origin
    CGPoint p0 = {0.0f,0.0f};
    
    //end point
    CGPoint p1 = {0.0f,200.0f};
    
    //control point 1 - controls bottom
    CGPoint c1 = {140.0f,5.0f};
    
    //controlPoint 2
    CGPoint c2 = {80.0f,198.0f};
    
    //move context to (100,5)
    CGContextTranslateCTM(context, 100.0f, 5.0f);
    
    drawCoordinateAxes(context);
    
    //begin path
    CGContextBeginPath(context);
    
    //move to origin
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    //add curve
    CGContextAddCurveToPoint(
                             context,
                             c1.x,
                             c1.y,
                             c2.x,
                             c2.y,
                             p1.x,
                             p1.y);
    
    //add curve
    CGContextAddCurveToPoint(
                             context,
                             -c2.x,
                             c2.y,
                             -c1.x,
                             c1.y,
                             p0.x,
                             p0.y);
    
    CGContextClosePath(context);

    //line width
    CGContextSetLineWidth(context, 5.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);

    //draw
    CGContextDrawPath(context, kCGPathStroke);
}

void drawQuadraticBezierCurve (CGContextRef context)
{
    /**
     *  These curves have only 1 control point
     */
    //origin
    CGPoint p0 = {0.0f,0.0f};
    
    //end point
    CGPoint p1 = {0.0f,200.0f};
    
    //control point 1 - controls bottom
    CGPoint c1 = {140.0f,5.0f};
    
    //move context to (100,5)
    CGContextTranslateCTM(context, 100.0f, 5.0f);
    
    drawCoordinateAxes(context);
    
    //begin path
    CGContextBeginPath(context);
    
    //move to origin
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    //add curve
    CGContextAddQuadCurveToPoint(context,
                                 -c1.x,
                                 c1.y,
                                 p1.x,
                                 p1.y);
    
    //line width
    CGContextSetLineWidth(context, 5.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);

}

void addRoundedRectToPath (CGContextRef context, CGRect rect,
                           float ovalWidth, float ovalHeight)
{
    float fw, fh = 0.0f;
    
    //add anormal rect if ovalHeight or ovalWidth == 0
    if (ovalHeight == 0 || ovalWidth == 0)
    {
        CGContextAddRect(context, rect);
    }
    else
    {
        
        drawCoordinateAxes(context);
        
        //save state
        CGContextSaveGState(context);
        
        
        
        //move to lower left corner of the rect
        CGContextTranslateCTM(context,
                              CGRectGetMinX(rect),
                              CGRectGetMinY(rect));
        
        //scale the ovalwidth and height
        //so that each rounded corner is 0.5 units in radius
        CGContextScaleCTM(context, ovalWidth, ovalWidth);
        
        //unscale the rectagle width by the amount of x scaling
        fw = CGRectGetWidth(rect) / ovalWidth;
        
        //unscale the rectangle height by the amount of y scaling
        fh = CGRectGetHeight(rect) / ovalHeight;
        
        //start at the right edge of the rectangle, at midpoint in Y
        //Y being the amount of scaling in y direction
        CGContextMoveToPoint(context, fw, fh/2);
        
        
        /**
         *  add segment 1
         */
        CGContextAddArcToPoint(context,
                               fw, //p1.x
                               fh, //p1.y
                               fw/2, //p2.x
                               fh,   //p2.y
                               0.5f);
        
        
        //segment 2
        CGContextAddArcToPoint(context,
                               0.0f,
                               fh,
                               0.,
                               fh/2,
                               0.5);
        
        //segment 3
        CGContextAddArcToPoint(context,
                               0.,
                               0.,
                               fw/2,
                               0.,
                               0.5);

        //segment 4
        CGContextAddArcToPoint(context,
                               fw,
                               0.,
                               fw,
                               fh/2,
                               0.5);
        
        
        
        
        
        CGContextClosePath(context);
        CGContextRestoreGState(context);
    }
}
void doRoundedRects (CGContextRef context)
{
    CGRect rect = {{10.0f,10.0f},{200.0f,200.0f}};
    
    float ovalWidth = 100.0f ,ovalHeight = 100.0f;
    
    //line width
    CGContextSetLineWidth(context, 2.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextSaveGState(context);
    
    addRoundedRectToPath(context, rect, ovalWidth, ovalHeight);

    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
    
    
    /**
     *  draw  a reference rect
     */
    CGContextBeginPath(context);
    
    CGContextAddRect(context, rect);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
}

void myContextAddEllipseInRect(CGContextRef context,CGRect rect)
{
//    //line width
//    CGContextSetLineWidth(context, 2.0f);
//    
//    //color
//    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
//    if ((&CGContextAddEllipseInRect) != NULL)
//    {
//          CGContextBeginPath(context);
//        
//        CGContextAddEllipseInRect(context, rect);
//        
//        CGContextDrawPath(context, kCGPathStroke);
//        
//        return;
//    }
    
    CGContextSaveGState(context);
    
    //translate to the center of teh ellipse
    CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    //scale by half the width and height of the rectangle
    CGContextScaleCTM(context, CGRectGetWidth(rect) /2.0, CGRectGetHeight(rect) / 2.0);
    
    //move to first point on the ellipse
    //this is the current point
    CGContextMoveToPoint(context, 1.0f, 0.0f);
    
    //line width
    CGContextSetLineWidth(context, 2.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextBeginPath(context);
    
    CGContextAddArc(context,
                    0.0f,
                    0.0f,
                    1.0f,
                    0.0f,
                    2 * M_PI,
                    true);
    
    
    
    //CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);


}

void drawLineSegemnts (CGContextRef context)
{
    
    //line width
    CGContextSetLineWidth(context, 2.0f);
    
    //color
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);

        CGPoint array[4] =
    {{10.0,20.0},{100.0,60.0},{60.0,90.0f},{100.0,100.0}};
    
        CGContextStrokeLineSegments(context, array, 4);
    
       //CGContextDrawPath(context, kCGPathStroke);
    
}

void doStrokeWithCTM(CGContextRef context)
{
    
    drawCoordinateAxes(context);
    
    //move to 150,180
    CGContextTranslateCTM(context, 100.0f, 180.0f);
    
    //line width
    CGContextSetLineWidth(context, 10.0f);
    
    //drawa the ellipse
    CGContextSaveGState(context);
    
    //scale the CTM
    CGContextScaleCTM(context, 2.0f, 1.0f);
    
    CGContextBeginPath(context);
    
    //add Arc
    CGContextAddArc(context,
                    0.0f,
                    0.0f,
                    45.0f,
                    0.0f,
                    2 * M_PI,
                    false);
    
    //restore context
    //context restore does not affect the path isn the context
    CGContextRestoreGState(context);
    
    //stroke
    CGContextStrokePath(context);
    
    
    CGContextTranslateCTM(context, 200.0f, 0.0f);
    
    //2nd ellipse
    
    CGContextSaveGState(context);
    
    //scale
    CGContextScaleCTM(context, 2.0f, 1.0f);
    
    CGContextBeginPath(context);
    
    //add arc
    CGContextAddArc(context,
                    0.0f,
                    0.0f,
                    45.0f,
                    0.0f,
                    2 * M_PI,
                    false);
    
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

void doRotatedEllipsesWithCGPath (CGContextRef context)
{
    u_int i, totreps = 144;
    float tint = 1.0f, tintincrement = 1.0f / totreps;
    
    //make 45 degree Rotation
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeRotation(M_PI /4.0f);
    
    //apply a scaling transform
    transform = CGAffineTransformScale(transform, 1.0f, 2.0f);
    
    //create  amutable path
    CGMutablePathRef path = NULL;
    path = CGPathCreateMutable();
    
    if (!path)
    {
        fprintf(stderr, "Couldn't create path!\n");
        return;
    }
    
    //add circular arc with transform applied
    CGPathAddArc(path,
                 &transform,
                 0.0f,
                 0.0f,
                 45.0f,
                 0.0f,
                 2 * M_PI,
                 false);
    
    //close the subpath
    CGPathCloseSubpath(path);
    
    //move to 100.0 100.0
    CGContextTranslateCTM(context, 100.0f, 100.0f);
    
    for (i = 0; i < totreps; i++)
    {
        //begin path
        CGContextBeginPath(context);
        
        //add subpath to main path
        CGContextAddPath(context, path);
        
        //set fill color
        CGContextSetRGBFillColor(context,
                                 tint,
                                 0.0f,
                                 0.0f,
                                 1.0f);
        
        //fill path
        CGContextFillPath(context);
        
        //get the next tint color
        tint -= tintincrement;
        
        //move to next ellipse
        CGContextTranslateCTM(context, 1.0f, 0.0f);
    }
    
    //release path
    CGPathRelease(path);
}

///DRAW With PixelAligned coordinates

static CGPoint alignPointToUserSpace (CGContextRef context, CGPoint p)
{
    //compute the coordinates of the point in device space
    p = CGContextConvertPointToDeviceSpace(context,
                                           p);
    
    //ensure the coordinates are at exactly the corner
    //of a device pixel
    p.x = floor(p.x);
    p.y = floor((double)p.y);
    
    //convert device aligned coordinate back to userspace
    CGPoint tmpPoint = CGPointZero;
    tmpPoint = CGContextConvertPointToUserSpace(context, p);
    
    return tmpPoint;
}

static CGSize alignSizeToUserSpace (CGContextRef context, CGSize size)
{
    //size in device space
    size = CGContextConvertSizeToDeviceSpace(context, size);
    
    //ensure size is an integer multiple of device pixels
    size.width = floor(size.width);
    size.height = floor(size.height);
    
    //back to userspace
    CGSize tmpSize = CGSizeZero;
    tmpSize = CGContextConvertSizeToUserSpace(context, size);
    
    return tmpSize;
}

static CGRect alignRectToUserSpace (CGContextRef context, CGRect rect)
{
    //rect in device space
    rect = CGContextConvertRectToDeviceSpace(context, rect);
    
    //ensure x y are at pixel corner
    //width height are integer numbers
    rect.origin.x = floor(rect.origin.x);
    rect.origin.y = floor(rect.origin.y);
    rect.size.width = floor(rect.size.width);
    rect.size.height = floor(rect.size.height);
    
    //back to userspace
    CGRect tmpRect = CGRectZero;
    tmpRect = CGContextConvertRectToUserSpace(context, rect);
    
    return tmpRect;
    
}

void doPixeAlignedFillAndStroke(CGContextRef context)
{
    CGPoint p1 = {16.7,17.8};
    CGPoint p2 = {116.7,17.8};
    CGRect rect = {{16.7, 20.8},{100.6,100.6}};
    CGSize s = CGSizeZero;
    
    //set line width and color
    CGContextSetLineWidth(context, 2.);
    CGContextSetRGBFillColor(context, 1., 0., 0., 1.);
    CGContextSetRGBStrokeColor(context, 1.0, 0., 0., 1.0);
    
    //Unaligned Drawing
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, p2.x, p2.y);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextFillRect(context, rect);
 
    
    //move to right
    CGContextTranslateCTM(context, 115., 0.);
    
    //LIGNED DRAWING
    
    //get length of line insuerSpace
    s = CGSizeMake((p2.x - p1.x), (p2.y - p1.y));
    
    CGContextBeginPath(context);
    
    //align strating point p1
    p1 = alignPointToUserSpace(context, p1);
    
    //move to the aligned point
    CGContextMoveToPoint(context, p1.x, p1.y);
    
    //compute the line length as an integer number of device pixels
    //align size
    s = alignSizeToUserSpace(context, s);
    
    //final point
    CGPoint finalPoint = CGPointZero;
    finalPoint.x = p1.x + s.width;
    finalPoint.y = p1.y + s.height;
    
    //add line
    CGContextAddLineToPoint(context, finalPoint.x, finalPoint.y);
    
    //draw path
    CGContextDrawPath(context, kCGPathStroke);
    
    //align rect
    rect = alignRectToUserSpace(context, rect);
    
    CGContextFillRect(context, rect);
}


#pragma mark QUARTZ COLORSPACES
CGColorSpaceRef getTheRGBColorSpace(void)
{
    static CGColorSpaceRef deviceRGB = NULL;
    
    if (NULL == deviceRGB)
    {
        deviceRGB = CGColorSpaceCreateDeviceRGB();
    }
    
    return deviceRGB;
}

void doColorSpaceFillAndStroke(CGContextRef context)
{
    CGColorSpaceRef theColorSpace = NULL;
    theColorSpace = getTheRGBColorSpace();
    
    CGFloat opaqueRed[] = {0.663f, 0.0f, 0.031, 1.0};//RGBA
    CGFloat aBlue[] = {0.482, 0.62, 0.871, 1.0};//RGBA
    
    //fill color space
    CGContextSetFillColorSpace(context, theColorSpace);
    
    //set fill color
    //number of elements in the array passed
    //must be the number of color components in the current fill color space
    //plus one for alpha
    CGContextSetFillColor(context, (const CGFloat *)&opaqueRed);
    
    
    //stroke color space
    CGContextSetStrokeColorSpace(context, theColorSpace);
    
    //stroke color
    CGContextSetStrokeColor(context, (const CGFloat *)&aBlue);
    
    //linwidth
    CGContextSetLineWidth(context, 8.);
    
    ///RECTANGLE 1
    CGContextBeginPath(context);
    
    CGContextAddRect(context, CGRectMake(20., 20., 100., 100.));
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //Change stroke
    aBlue[3] = 0.5f; //change alpha
    
    //change stroke color
    CGContextSetStrokeColor(context, (const CGFloat *)&aBlue);
    
    //RECTANGLE 2
    CGContextBeginPath(context);
    
    CGContextAddRect(context,CGRectMake(140., 20., 100., 100.));
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

void drawWithColorRefs(CGContextRef context)
{
    static CGColorRef opaqueRedColor = NULL;
     CGColorRef opaqueBlueColor = NULL;
     CGColorRef transparentBlueColor = NULL;
    
    if (NULL == opaqueRedColor)
    {
        CGFloat color[4] = {0.663f, 0.f, 0.031f, 1.0f};
        
        //color space
        CGColorSpaceRef theColorSpace =  NULL;
        theColorSpace = getTheRGBColorSpace();
        
        //create the color
        opaqueRedColor =
        CGColorCreate(theColorSpace, (const CGFloat *)&color);
        
        //change color array to hold blue color
        color[0] = 0.482f;
        color[1] = 0.62f;
        color[2] = 0.871f;
        
        opaqueBlueColor =
        CGColorCreate(theColorSpace, (const CGFloat *)&color);
        
        //cretae transparent color
        transparentBlueColor =
        CGColorCreateCopyWithAlpha(opaqueBlueColor, 0.5f);
        
        if (!(opaqueRedColor && opaqueBlueColor && transparentBlueColor))
        {
            fprintf(stderr, "Couldnt create CGColoRef");
            return;
        }
        
        //SET fill and stroke Color
        CGContextSetFillColorWithColor(context, opaqueRedColor);
        CGContextSetStrokeColorWithColor(context, opaqueBlueColor);
        
        CGContextSetLineWidth(context, 8.0f);
        
        //RECTANGLE 1
        CGContextBeginPath(context);
        
        CGContextAddRect(context, CGRectMake(20.f, 20.f, 100.f, 100.f));
        
        CGContextDrawPath(context, kCGPathFillStroke);
        
        //Chnage stroke color
        CGContextSetStrokeColorWithColor(context, transparentBlueColor);
        
        //RECTANGLE 1
        CGContextBeginPath(context);
        
        CGContextAddRect(context, CGRectMake(140.f, 20.f, 100.f, 100.f));
        
        CGContextDrawPath(context, kCGPathFillStroke);

        
        
    }
    
}

@end
