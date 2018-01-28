//
//  WaveView.swift
//  WaveExample
//
//  Created by 이광용 on 2018. 1. 25..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

enum WaveDirection : Int {
    case Left
    case Right
}

@IBDesignable class WaveView: UIView {
    
    
    @IBInspectable var waveHeight : CGFloat = 10.0
    @IBInspectable var waveWidth : CGFloat = 50.0
    @IBInspectable var controlWidth : CGFloat = 20.0
    
    var waveDirection = WaveDirection.Left
    var gradientLocations : [CGFloat] = [0.0, 1.0]
    var gradientCGColors : CFArray = [UIColor(white: 1, alpha: 0.2).cgColor, UIColor(white: 1, alpha: 0).cgColor] as CFArray
    
    
    private var lastPoint = CGPoint.zero
    private var currentWaveWidthOffset : CGFloat = 0.0
    private var currentWaveHeightOffset : CGFloat = 0.0
    private var heightReverse : CGFloat = 1.0
    
    private var waveTimer : Timer?
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        
        // 3. Setup view from .xib file
        setup()
    }
    
    
    private func setup() {
        
        startTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(WaveView.startTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WaveView.stopTimer), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    
    func startTimer() {
        if (waveTimer == nil) {
            waveTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(WaveView.changeOffset), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        waveTimer?.invalidate()
        waveTimer = nil
    }
    
    
    
    func changeOffset() {
        currentWaveWidthOffset = currentWaveWidthOffset + 1
        
        if (self.currentWaveWidthOffset > waveWidth * 2) {
            self.currentWaveWidthOffset = 0
        }
        
        currentWaveHeightOffset = currentWaveHeightOffset + 0.1 * heightReverse
        if (currentWaveHeightOffset > waveHeight) {
            currentWaveHeightOffset = waveHeight
            heightReverse = -1.0
        } else if (currentWaveHeightOffset < 0) {
            currentWaveHeightOffset = 0
            heightReverse = 1.0
        }
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        ///// General Declarations
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientCGColors, locations: gradientLocations);
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath();
        
        if (waveDirection == WaveDirection.Left) {
            
            rectanglePath.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            rectanglePath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            var currentPoint = CGPoint(x: rect.minX - (waveWidth * 2 - currentWaveWidthOffset),
                                       y: rect.minY + currentWaveHeightOffset)
            rectanglePath.addLine(to: currentPoint)
            lastPoint = currentPoint;
            
            var index = 0
            while (true) {
                if (index % 2 == 0) {
                    currentPoint = CGPoint(x: lastPoint.x + waveWidth,y: rect.minY + (waveHeight - currentWaveHeightOffset))
                } else {
                    currentPoint = CGPoint(x: lastPoint.x + waveWidth,y: rect.minY + currentWaveHeightOffset)
                }
                
                rectanglePath.addCurve(to: currentPoint, controlPoint1: CGPoint(x: lastPoint.x + controlWidth,y: lastPoint.y), controlPoint2: CGPoint(x: currentPoint.x - controlWidth,y: currentPoint.y))
                
                lastPoint = currentPoint;
                
                index = index + 1
                
                if (lastPoint.x >= rect.maxX) {
                    rectanglePath .addLine(to: lastPoint)
                    break
                }
                
            }
        } else {
            rectanglePath.move(to: CGPoint(x: rect.minX,y: rect.maxY))
            rectanglePath.addLine(to: CGPoint(x: rect.maxX,y: rect.maxY))
            
            var currentPoint = CGPoint(x: rect.maxX + (waveWidth * 2 - currentWaveWidthOffset), y: rect.minY + currentWaveHeightOffset)
            rectanglePath.addLine(to: currentPoint)
            lastPoint = currentPoint;
            
            var index = 0
            while (true) {
                if (index % 2 == 0) {
                    currentPoint = CGPoint(x: lastPoint.x - waveWidth,
                                           y: rect.minY + (waveHeight - currentWaveHeightOffset))
                } else {
                    currentPoint = CGPoint(x: lastPoint.x - waveWidth,
                                           y: rect.minY + currentWaveHeightOffset)
                }
                
                rectanglePath.addCurve(to: currentPoint,
                                       controlPoint1: CGPoint(x: lastPoint.x - controlWidth,
                                                              y: lastPoint.y),
                                       controlPoint2: CGPoint(x: currentPoint.x + controlWidth,
                                                              y: currentPoint.y))
                
                lastPoint = currentPoint;
                
                index = index + 1
                
                if (lastPoint.x <= rect.minX) {
                    rectanglePath .addLine(to: lastPoint)
                    break
                }
                
            }
            
        }
        
        rectanglePath.close()
        if let context = context,let gradient = gradient {
            context.saveGState()
            
            rectanglePath.addClip()
            
            let rectangleBounds = rectanglePath.cgPath.boundingBox
            
            context.drawLinearGradient(gradient,
                                       start: CGPoint(x: rectangleBounds.midX,
                                                      y: rectangleBounds.minY),
                                       end: CGPoint(x:rectangleBounds.midX,
                                                    y:rectangleBounds.maxY),
                                       options: CGGradientDrawingOptions(rawValue: 0))
            
            context.restoreGState()
        }
    }
    
}

