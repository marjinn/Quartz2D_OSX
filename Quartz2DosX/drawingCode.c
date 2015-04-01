//
//  drawingCode.c
//  Quartz2DosX
//
//  Created by mar Jinn on 2/23/15.
//  Copyright (c) 2015 mar Jinn. All rights reserved.
//

#include "drawingCode.h"
#include <math.h>

static inline void cdoSimpleRect (CGContextRef context);
static inline void ccreateRectPath (CGContextRef context,CGRect rect);
static inline void cdoPathRects(CGContextRef context);
static inline void cdoAplphaRects(CGContextRef context);
static inline void cdoDashedLines (CGContextRef context);
static inline void cdoClippedCircle(CGContextRef context);
void cdrawCoordinateAxes (CGContextRef context);
void cdrawRotatedAndScaledRectangle (CGContextRef context);
void cdrawRotatedRectWithContextSave(CGContextRef context);
void cdrawEllipseWithAffineTransform (CGContextRef context);
void cdrawRotatedEllipses (CGContextRef context);
void cdrawSkewedCoordinateSystem (CGContextRef context);
void cdoEgg(CGContextRef context);
void cdoRoundedRects (CGContextRef context);

void cdoDrawing(CGContextRef context)
{
    
    cdrawCoordinateAxes(context);
    
    //cdoSimpleRect(context);
    
    //ccreateRectPath(context, CGRectMake(20.0f, 20.0f, 100.0f, 150.0f));
    
    //cdoPathRects(context);
    
    //cdoAplphaRects(context);
    
    //cdoDashedLines(context);
    
    //cdoClippedCircle(context);
    
    //cdrawRotatedAndScaledRectangle(context);
    
    //cdrawRotatedRectWithContextSave(context);
    
    //cdrawEllipseWithAffineTransform(context);
    
    //cdrawRotatedEllipses(context);
    
    //cdrawSkewedCoordinateSystem(context);
    
    //cdoEgg(context);
    
    cdoRoundedRects(context);

}

void cdrawCoordinateAxes (CGContextRef context)
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


__unused static inline void cdoSimpleRect (CGContextRef context)
{
    //get rect
    CGRect rect = CGRectZero;
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             1.0f,
                             0.0f,
                             0.0f,
                             1.0f);
    
    //set up the rect
    rect.origin.x   =   20.0f;
    rect.origin.y   =   20.0f;
    rect.size.width =   130.0f;
    rect.size.height    =   100.0f;
    
    //draw the rect
    CGContextFillRect(context, rect);
    
    rect.origin.x = rect.origin.x + 200.0f;
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             0.482f,
                             0.62f,
                             1.871f,
                             1.0f);
    
    CGContextStrokeRect(context, rect);
    
    rect.origin.y = rect.origin.y + 150.0f;
    
    CGContextStrokeRectWithWidth(context, rect, 15.0f);
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             0.482f,
                             1.62f,
                             0.871f,
                             1.0f);
    
    CGContextFillRect(context, rect);
    
    rect.origin.x = 20.0f;
    
    CGContextStrokeRectWithWidth(context, rect, 15.0f);
    
}

static inline void ccreateRectPath (CGContextRef context,CGRect rect)
{
    //begin path
    CGContextBeginPath(context);
    
    //move to the origin of the rect
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    
    //Drawing happens anti clockwise
    //add a line from (0,0) to (0,height)
    //assuming the origin is (0,0)
    CGContextAddLineToPoint(context,
                            rect.origin.x,
                            rect.origin.y + rect.size.height);
    
    //add another line from (0,height) to (width,height)
    CGContextAddLineToPoint(context,
                            rect.origin.x + rect.size.width,
                            rect.origin.y + rect.size.height);
    
    //add a line from (width,height) to (width,0)
    CGContextAddLineToPoint(context,
                            rect.origin.x + rect.size.width,
                            rect.origin.y);
    
    //close  path or adda a line from (width,0) to (0,0)
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    
    //set line width
    CGContextSetLineWidth(context, 10.0f);
    
    //line cap // set to avoid a the empty space at the end
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //color
    //CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    //draw path
    //CGContextDrawPath(context, kCGPathStroke);
}

__unused static inline void cdoPathRects(CGContextRef context)
{
    //define rect
    CGRect ourRect = {{20.0f, 220.0f},{130.0f, 100.0f}};
    
    /**
     *  4 rectangles can be draw by moving the x,y coordinates around
     *
     *  Can Also be achieved by translating the CTM along x, y coordinates
     */
    
    /**
     *  1st Rect
     */
    //create rect path
    //ccreateRectPath(context, ourRect);
    
    //fill color
    CGContextSetRGBFillColor(context, 0.482, 0.62f, 0.871f, 1.0f);
    
    //fill path
    //CGContextDrawPath(context, kCGPathFill);
    
    /**
     *  Rect 2
     * translate to 200 along x
     */
    CGContextTranslateCTM(context, 200.0f, 0.0f);
    
    //stroke color
    CGContextSetRGBStrokeColor(context, 0.0404f, 0.0808f, 0.239f, 1.0);
    
    //add path
    ccreateRectPath(context, ourRect);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
    /**
     *  rect 3
     * move top (-200,-200)
     */
    CGContextTranslateCTM(context, -200.0f, -200.0f);
    
    //color
    //create path
    ccreateRectPath(context, ourRect);
    
    //draw an apinst stroke and fill
    CGContextDrawPath(context, kCGPathFillStroke);
    
    /**
     *  rect 4
     *  move to 200,0
     * stroke and then Fill
     */
    CGContextTranslateCTM(context, 200.0f, 0.0f);
    
    //path
    ccreateRectPath(context, ourRect);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
    //path again
    ccreateRectPath(context, ourRect);
    
    //draw
    CGContextDrawPath(context, kCGPathFill);
    
}

__unused static inline void cdoAplphaRects(CGContextRef context)
{
    CGRect ourRect          = {{0.0f,0.0f},{130.0f,100.0f}};
    int i, numRects         = 6;
    float rotateAngle       = (2*M_PI)/numRects;
    float tint, tintAdjust  = 1.0f/numRects;
    
    //divides 360 ie 2*180 into 6 parts ie rotate angle is 60
    //when used in a loop to rotateCTM the effect will be cumilative
    
    CGContextTranslateCTM(context,
                          2 * CGRectGetWidth(ourRect),
                          2 * CGRectGetHeight(ourRect));
    
    
    for (i = 0, tint = 1.0f; i < numRects; i++, tint -= tintAdjust)
    {
        //choose fill color
        CGContextSetRGBFillColor(context, tint, 0.0f, 0.0f, 1.0f);
        
        //fillrect
        CGContextFillRect(context, ourRect);
        
        //rotateCTM
        CGContextRotateCTM(context, rotateAngle);
    }
}

__unused static inline void cdrawStrokedLine (CGContextRef context,
                                             CGPoint start,
                                             CGPoint end)
{
    /**
     *  draw  a line
     */
    //begin path
    CGContextBeginPath(context);
    
    //move to starting point
    CGContextMoveToPoint(context, start.x, start.y);
    
    //add line
    CGContextAddLineToPoint(context, end.x, end.y);
    
    //drawPath
    CGContextDrawPath(context, kCGPathStroke);
}

__unused static inline void cdoDashedLines (CGContextRef context)
{
    CGPoint start   = {20.0f,270.0f};
    CGPoint end     = {300.0f,270.0f};
    
    //pattern of on-off dashes
    CGFloat length[6]  = {12.0f, 6.0f, 5.0f, 6.0f, 5.0f, 6.0f};
    
    /**
     *  solid line
     */
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextSetLineDash(context,
                         0.0f,
                         (const CGFloat *)&length,
                         0.0f);
    
    //draw line
    cdrawStrokedLine(context, start, end);
    
    /**
     *  long dashes
     */
    CGContextTranslateCTM(context, 0.0f, -50.0f);
    
    //draw without using CTM
//    start.y =   (start.y - 20.0f);
//    end.y   =   (end.y - 20.0f);
    
    /**
     *  dotted line 12on 6 off
     */
    CGContextSetLineDash(context,
                         0.0f,
                         (const CGFloat *)&length,
                         2.0f);
    
    //draw line
    cdrawStrokedLine(context, start , end);
    
    /**
     *  long short
     */
    CGContextTranslateCTM(context, 0.0f, -50.0f);
    
    CGContextSetLineDash(context,
                         0.0f,
                         (const CGFloat *)&length,
                         4.0f);
    
    //draw line
    cdrawStrokedLine(context, start , end);
    
    
    
}

__unused static inline void cdoClippedCircle(CGContextRef context)
{
    CGPoint circleCenter = {150.0f,150.0f};
    float circleRadius = 100.0f;
    float startingAngle = 0.0f, endingAngle = 2 * M_PI;
    CGRect ourRect = {{65.0f,65.0f},{170.0f,170.0f}};
    
    /**
     *  Filled Circle
     */
    //color
    CGContextSetRGBFillColor(context,
                             0.633f,
                             0.0f,
                             0.031f,
                             1.0f);
    
    //path
    CGContextBeginPath(context);
    
    //circle
    CGContextAddArc(context,
                    circleCenter.x,
                    circleCenter.y,
                    circleRadius,
                    startingAngle,
                    endingAngle,
                    false);
    
    //draw
    CGContextDrawPath(context, kCGPathFill);
    
   
    CGContextStrokeRect(context, ourRect);
    
    
    /**
     *  draw fill rect
     */
    CGContextTranslateCTM(context,
                          CGRectGetWidth(ourRect) + circleRadius + 5.0f,
                          0);
    
    //CGContextBeginPath(context);
    
    //color
    CGContextSetRGBFillColor(context,
                             0.633f,
                             0.0f,
                             0.031f,
                             1.0f);
    
    //CGContextAddRect(context, ourRect);
    
    //CGContextDrawPath(context, kCGPathFill);
    
    
    /**
     *  Clipped circle
     */
    
    //ADD CLip PAth ie rect
    CGContextBeginPath(context);
    
    CGContextAddRect(context, ourRect);
    
    CGContextClip(context);
    
    
    
    CGContextBeginPath(context);
    
    
    //circle
    CGContextAddArc(context,
                    circleCenter.x,
                    circleCenter.y,
                    circleRadius,
                    startingAngle,
                    endingAngle,
                    false);
    
    //draw
    CGContextDrawPath(context, kCGPathFill);
    
}

void cdrawRotatedAndScaledRectangle (CGContextRef context)
{
    CGRect ourRect = {{0.0f,0.0f},{172.0f,172.0f}};
    
    //
    cdrawCoordinateAxes(context);
    
    CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    //Fill the unscaled rectangle
    CGContextFillRect(context,ourRect);
    
    CGContextRotateCTM(context, M_PI/6);
    
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    CGContextSetRGBStrokeColor(context, 0.69f,0.486f, 0.722f, 1.0f);
    
    CGContextSetRGBFillColor(context, 0.69f,0.486f, 0.722f, 0.7f);
    
    cdrawCoordinateAxes(context);
    
    CGContextFillRect(context, ourRect);
}

void cdrawRotatedRectWithContextSave(CGContextRef context)
{
    CGRect ourRect = {{0.0f,0.0f},{172.0f,172.0f}};
    
    //
    cdrawCoordinateAxes(context);
    
    /**
     *  Rectangle 1
     */
    CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    
    //Fill the unscaled rectangle
    CGContextFillRect(context,ourRect);
    
    /**
     *  SAVE THE STATE
     */
    CGContextSaveGState(context);
    
    //rotate by 30
    CGContextRotateCTM(context, M_PI / 6);
    
    //scale by 0.5 in x and 2.0 by y
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    //set StrokeColor and Fillcolor
    CGContextSetRGBStrokeColor(context, 0.69f,0.486f, 0.722f, 1.0f);
    
    CGContextSetRGBFillColor(context, 0.69f,0.486f, 0.722f, 0.7f);
    
    //darw the coordinate axis
    cdrawCoordinateAxes(context);

    
        //Rectangel 2
    
    //drawrect
    CGContextFillRect(context, ourRect);
    
    //restore state
    CGContextRestoreGState(context);
    
    
    //translate to right
    CGContextTranslateCTM(context, 288., 0.);
    
    cdrawCoordinateAxes(context);
    
    //rect 3
    CGContextFillRect(context, ourRect);
    
    //save the state
    CGContextSaveGState(context);
    
    //scale and then rotate
    CGContextScaleCTM(context, 0.5f, 2.0f);
    
    CGContextRotateCTM(context, M_PI/6);
    
    //set StrokeColor and Fillcolor
    CGContextSetRGBStrokeColor(context, 0.965f,0.584f, 0.059f, 1.0f);
    
    CGContextSetRGBFillColor(context,0.965f,0.584f, 0.059f, 1.0f);

    cdrawCoordinateAxes(context);
    
    //RECT 4
    CGContextFillRect(context, ourRect);
    
    //restore state
    CGContextRestoreGState(context);

    
}

void cdrawEllipseWithAffineTransform (CGContextRef context)
{
    //major and minor axis of ellipse
    __unused const CGFloat height = 50.0f;
    __unused const CGFloat width = 100.0f;
    
    //make scale transform
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeScale(2.0f, 1.0f);
    
    CGContextConcatCTM(context, transform);
    
    CGContextBeginPath(context);
    
    CGContextAddArc(context,
                    100.,
                    100.,
                    50.,
                    0.,
                    2 * M_PI,
                    false);
    //color
    CGContextSetRGBFillColor(context,
                             0.633f,
                             0.0f,
                             0.031f,
                             1.0f);
    
    CGContextDrawPath(context, kCGPathFill);
    
}


void cdrawRotatedEllipses (CGContextRef context)
{
    const int totreps = 144;
    float tint = 1., tintIncrement = (1./totreps);
    
    //transform with 45 degree rotation
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeRotation(M_PI/4);
    
    //apply scale
    transform = CGAffineTransformScale(transform, 1., 2.);
    
    //staring point
    CGContextTranslateCTM(context, 200., 100.);
    
    for (unsigned int i = 0; i < 100; i++)
    {
        //save state
        CGContextSaveGState(context);
        
        CGContextConcatCTM(context, transform);
        
        CGContextBeginPath(context);
        
        CGContextAddArc(context,
                        100.,
                        100.,
                        50.,
                        0.,
                        2 * M_PI,
                        false);
        //color
        CGContextSetRGBFillColor(context,
                                 tint,
                                 0.0f,
                                 0.031f,
                                 1.0f);
        
        CGContextDrawPath(context, kCGPathFill);
        
        CGContextRestoreGState(context);
        
        tint -= tintIncrement;
        
        //move to left
        CGContextTranslateCTM(context, 1.0f, 0.);
    }
}

void cdrawSkewedCoordinateSystem (CGContextRef context)
{
    //skew is non uniform scaling and rotation
    //the transform is make
    
    /**
    *  Skewed drawing
    ------ where x axis is rotated towards y-axis by angle α and
    ------- y axis is rotaed toward x axis by an angle of β
    all rotations made relative to untransformed x and y axes
    
    M_skew =    1     tan α       0
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
    
    //rect
    const CGRect rect  = (CGRect){{0.,0.},{72.,72.}};
    
    //starting Point
    CGContextTranslateCTM(context, 144., 144.);
    
    cdrawCoordinateAxes(context);
    
    CGContextSetRGBFillColor(context, 1., 0., 0., 1.);
    
    CGContextFillRect(context, rect);
    
    //skew transform
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMake
    (1., tan(M_PI/8), tan(M_PI/12), 1., 0., 0.);
    
    //apply the transform
    CGContextConcatCTM(context, transform);
    
    //set StrokeColor and Fillcolor
    CGContextSetRGBStrokeColor(context, 0.11f,0.208f, 0.451, 1.0f);
    
    CGContextSetRGBFillColor(context, 0.11f,0.208f, 0.451, 1.0f);
    
    cdrawCoordinateAxes(context);
    
    //set fill color again
    CGContextSetRGBFillColor(context, 0.11f,0.208f, 0.451, 0.7f);
    
    CGContextFillRect(context, rect);

}

void cdoEgg(CGContextRef context)
{
    //BEZIER CURVE
    
    CGPoint const p0 = {0.,0.},p1 = {0.,200.};
    CGPoint const c1 = {140.,5.},c2 = {80.,198.};
    
    //move to a location
    CGContextTranslateCTM(context, 100., 5.);
    
    cdrawCoordinateAxes(context);
    
    CGContextBeginPath(context);
    
    //add curve starting point
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    //add curve
    CGContextAddCurveToPoint(context,
                             c1.x,
                             c1.y,
                             c2.x,
                             c2.y,
                             p1.x,
                             p1.y);
    
    CGContextAddCurveToPoint(context,
                             -c2.x,
                             c2.y,
                             -c1.x,
                             c1.y,
                             p0.x,
                             p0.y);
    
    CGContextClosePath(context);
    
    //line width
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextSetRGBStrokeColor(context, 1.0f, 0., 0., 1.);
    
    //draw path
    CGContextDrawPath(context, kCGPathStroke);
    
}

void caddRoundedRectToPath(CGContextRef context,
                          CGRect rect,
                          CGFloat ovalWidth,
                          CGFloat ovalHeight)
{
    CGFloat fw, fh = 0.0f;
    
    //if ovalWidth or ovalHeight is 0, add a regular rect
    if (ovalHeight == 0. || ovalWidth == 0.)
    {
        CGContextAddRect(context, rect);
    }
    else
    {
        CGContextSaveGState(context);
        
        //move to lower left corner of the rect
        //ie minX and minX
        CGContextTranslateCTM(context,
                              CGRectGetMinX(rect),
                              CGRectGetMinY(rect));
        
        //scale x ovalwidth and ovalheight
        //so that each rounded corner is 0.5 unis in radius
        CGContextScaleCTM(context, ovalWidth, ovalHeight);
        
        //unscale to get original width and height
        fw = CGRectGetWidth(rect) / ovalWidth;
        fh = CGRectGetHeight(rect) / ovalHeight;
        
        //start at the right edge, at the midpoint in Y
        CGContextMoveToPoint(context, fw, fh/2.);
        
        //Segment 1
        CGContextAddArcToPoint(context,
                               fw,
                               fh,
                               fw/2.,
                               fh,
                               0.5f);
        
        CGContextAddArcToPoint(context,
                               0.,
                               fh,
                               0.,
                               fh/2.,
                               0.5f);
        
        CGContextAddArcToPoint(context,
                               0.,
                               0.,
                               fw/2.,
                               0.,
                               0.5f);

        CGContextAddArcToPoint(context,
                               fw,
                               0.,
                               fw,
                               fh/2.,
                               0.5f);

        CGContextClosePath(context);
        
        CGContextRestoreGState(context);
    }
}

void cdoRoundedRects (CGContextRef context)
{
    CGRect const rect = {{10.,10.},{210.,150.}};
    
    const CGFloat ovalWidth = 100.0f ,ovalHeight = 100.;
    
    CGContextSetLineWidth(context, 5.);
    
    CGContextBeginPath(context);
    
    caddRoundedRectToPath(context,
                          rect,
                          ovalWidth,
                          ovalHeight);
    
    CGContextSetRGBStrokeColor(context, 1., 0., 0., 1.);
    
    CGContextDrawPath(context, kCGPathStroke);

}