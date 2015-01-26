//
//  myVIew.m
//  Quartz2DosX
//
//  Created by mar Jinn on 1/24/15.
//  Copyright (c) 2015 mar Jinn. All rights reserved.
//

#import "myVIew.h"



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
    setBackgroundColorOfRect(context, dirtyRect);
    
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
    
    drawSkewedCoordinateSystem(context);
    
    //drawSkewedRectangles(context);
    
    //drawScewedCoordinateSystem_(context);
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


@end
