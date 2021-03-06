//
//  SKEase.swift
//  EverythingKitMaster
//
//  Created by Jonathan Pappas on 1/27/22.
//

import SpriteKit

public extension SKAction {
    func easeInOut() -> SKAction {
        timingFunction = SineEaseInOut(_:)
        return self
    }
    func easeOut() -> SKAction {
        timingFunction = SineEaseOut(_:)
        return self
    }
    func bounceOut() -> SKAction {
        timingFunction = BounceEaseOut(_:)
        return self
    }
    func circleOut() -> SKAction {
        timingFunction = CircularEaseOut(_:)//SineEaseOut
        return self
    }
    func circleIntOut() -> SKAction {
        timingFunction = CircularEaseInOut(_:)//SineEaseOut
        return self
    }
}

///Curve type
public enum CurveType {
    case linear, quadratic, cubic, quartic, quintic
    case sine, circular, expo, elastic, back, bounce
}

///Ease type
public enum EaseType { case `in`, out, inOut }

extension SKAction {
    
    func easeInEaseOut() -> SKAction {
        Self.easeType(curve: .sine, easeType: .inOut, self)
    }
//
//    static func ifTrue(_ me2: () -> Bool,_ runThese: () -> [SKAction], otherwise: () -> [SKAction] = {[SKAction.wait(forDuration: 0)]} ) -> SKAction {
//        if me2() {
//            return .sequence(runThese())
//        } else {
//            return .sequence(otherwise())
//        }
//    }
//
//    static func killAction(_ me: (ActionSprite & SKActionable),_ to: Int) -> SKAction {
//        return .run {
//            me.skNode.removeAction(forKey: "\(to)")
//            me.actionSprite.removeAction(forKey: "\(to)")
//        }
//    }
//    static func killAction(_ me: (MovableSprite & SKActionable),_ to: Int) -> SKAction {
//        return .run {
//            me.skNode.removeAction(forKey: "\(to)")
//            me.actionSprite.removeAction(forKey: "\(to)")
//        }
//    }
//
//    static func setImage(_ to: Images,_ num: Double = 0) -> SKAction {
//        return .sequence([
//            .animate(with: [Cash.getTexture(to.rawValue)], timePerFrame: 0),
//            .wait(forDuration: num),
//        ])
//    }
//    static func animation(_ to: [(Images, Double)]) -> SKAction {
//        return .sequence(to.map { SKAction.setImage($0.0, $0.1) })
//    }
//
////    static func animate(_ using: [Images]) -> SKAction {
////        return .moveBy(x: 0, y: 10, duration: 1)
////    }
//
//    static func figureEight(height: CGFloat, time: Double, clockwise: Bool = true) -> SKAction {
//        return .sequence([
//            .circle(height: height/2, time: time/2, clockwise: clockwise),
//            .circle(height: -height/2, time: time/2, clockwise: !clockwise),
//        ])
//    }
//
//    static func circle(height: CGFloat, width: CGFloat? = nil, time: Double, clockwise: Bool = true) -> SKAction {
//        let www = width ?? height
//        let c: CGFloat = clockwise ? -1 : 1
//        return SKAction.group([
//            .sequence([
//                .easeType(curve: .sine, easeType: .out, .moveBy(x: c * (www/2), y: 0, duration: (time/4))),
//                .easeType(curve: .sine, easeType: .inOut, .moveBy(x: -c * www, y: 0, duration: (time/2))),
//                .easeType(curve: .sine, easeType: .in, .moveBy(x: c * (www/2), y: 0, duration: (time/4))),
//            ]),
//            .sequence([
//                .easeType(curve: .sine, easeType: .inOut, .moveBy(x: 0, y: height, duration: (time/2))),
//                .easeType(curve: .sine, easeType: .inOut, .moveBy(x: 0, y: -height, duration: (time/2))),
//            ])
//        ])
//    }
    
    
    
    static func easeType(curve: CurveType, easeType: EaseType,_ n: SKAction) -> SKAction {
        
        if easeType == .in {
            switch curve {
            case.back: n.timingFunction = BackEaseIn
            case .bounce: n.timingFunction = BounceEaseIn(_:)
            case .circular: n.timingFunction = CircularEaseIn(_:)
            case .cubic: n.timingFunction = CubicEaseIn(_:)
            case .elastic: n.timingFunction = ElasticEaseIn(_:)
            case .expo: n.timingFunction = ExponentialEaseIn(_:)
            case .linear: n.timingFunction = LinearInterpolation(_:)
            case .quadratic: n.timingFunction = QuadraticEaseIn(_:)
            case .quartic: n.timingFunction = QuarticEaseIn(_:)
            case .quintic: n.timingFunction = QuinticEaseIn(_:)
            case .sine: n.timingFunction = SineEaseIn(_:)
            }
        } else if easeType == .out {
            switch curve {
            case.back: n.timingFunction = BackEaseOut
            case .bounce: n.timingFunction = BounceEaseOut
            case .circular: n.timingFunction = CircularEaseOut
            case .cubic: n.timingFunction = CubicEaseOut
            case .elastic: n.timingFunction = ElasticEaseOut
            case .expo: n.timingFunction = ExponentialEaseOut
            case .linear: n.timingFunction = LinearInterpolation
            case .quadratic: n.timingFunction = QuadraticEaseOut
            case .quartic: n.timingFunction = QuarticEaseOut
            case .quintic: n.timingFunction = QuinticEaseOut
            case .sine: n.timingFunction = SineEaseOut
            }
        } else {
            switch curve {
            case.back: n.timingFunction = BackEaseInOut
            case .bounce: n.timingFunction = BounceEaseInOut
            case .circular: n.timingFunction = CircularEaseInOut
            case .cubic: n.timingFunction = CubicEaseInOut
            case .elastic: n.timingFunction = ElasticEaseInOut
            case .expo: n.timingFunction = ExponentialEaseInOut
            case .linear: n.timingFunction = LinearInterpolation
            case .quadratic: n.timingFunction = QuadraticEaseInOut
            case .quartic: n.timingFunction = QuarticEaseInOut
            case .quintic: n.timingFunction = QuinticEaseInOut
            case .sine: n.timingFunction = SineEaseInOut
            }
        }
        return n
    }
}




let M_PI_2_f = Float(Double.pi / 2)
let M_PI_f = Float(Double.pi)

public typealias AHEasingFunction = (Float)->Float

public func dub(_ num:Float)->Float {
    return (Float(Int32(num)))
}
public func sinFloat(_ num:Float)->Float {
    return sin(num)
}
// Modeled after the line y = x
public func LinearInterpolation(_ p:Float)->Float
{
    return p;
}

// Modeled after the parabola y = x^2
public func  QuadraticEaseIn(_ p:Float)->Float
{
    return p * p;
}

// Modeled after the parabola y = -x^2 + 2x
public func QuadraticEaseOut(_ p:Float)->Float
{
    return -(p * (p - 2));
}

// Modeled after the piecewise quadratic
// y = (1/2)((2x)^2)             ; [0, 0.5)
// y = -(1/2)((2x-1)*(2x-3) - 1) ; [0.5, 1]
public func QuadraticEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 2 * p * p;
    }
    else
    {
        return (-2 * p * p) + (4 * p) - 1;
    }
}

// Modeled after the cubic y = x^3
public func CubicEaseIn(_ p:Float)->Float
{
    return p * p * p;
}

// Modeled after the cubic y = (x - 1)^3 + 1
public func CubicEaseOut(_ p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f + 1;
}

// Modeled after the piecewise cubic
// y = (1/2)((2x)^3)       ; [0, 0.5)
// y = (1/2)((2x-2)^3 + 2) ; [0.5, 1]
public func CubicEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 4 * p * p * p;
    }
    else
    {
        let f:Float = ((2 * p) - 2);
        return 0.5 * f * f * f + 1;
    }
}

// Modeled after the quartic x^4
public func QuarticEaseIn(_ p:Float)->Float
{
    return p * p * p * p;
}

// Modeled after the quartic y = 1 - (x - 1)^4
public func QuarticEaseOut(_ p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f * (1 - p) + 1;
}

// Modeled after the piecewise quartic
// y = (1/2)((2x)^4)        ; [0, 0.5)
// y = -(1/2)((2x-2)^4 - 2) ; [0.5, 1]
public func QuarticEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 8 * p * p * p * p;
    }
    else
    {
        let f:Float = (p - 1);
        return -8 * f * f * f * f + 1;
    }
}

// Modeled after the quintic y = x^5
public func QuinticEaseIn(_ p:Float)->Float
{
    return p * p * p * p * p;
}

// Modeled after the quintic y = (x - 1)^5 + 1
public func QuinticEaseOut(_ p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f * f * f + 1;
}

// Modeled after the piecewise quintic
// y = (1/2)((2x)^5)       ; [0, 0.5)
// y = (1/2)((2x-2)^5 + 2) ; [0.5, 1]
public func QuinticEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 16 * p * p * p * p * p;
    }
    else
    {
        let f:Float = ((2 * p) - 2);
        return  0.5 * f * f * f * f * f + 1;
    }
}

// Modeled after quarter-cycle of sine wave
public func SineEaseIn(_ p:Float)->Float
{
    return sinFloat((p - 1.0) * M_PI_2_f)+1.0
}

// Modeled after quarter-cycle of sine wave (different phase)
public func SineEaseOut(_ p:Float)->Float
{
    return sinFloat(p * M_PI_2_f)
}

// Modeled after half sine wave
public func SineEaseInOut(_ p:Float)->Float
{
    return 0.5 * (1.0 - cos(p * M_PI_f));
}

// Modeled after shifted quadrant IV of unit circle
public func CircularEaseIn(_ p:Float)->Float
{
    return 1 - sqrt(1 - (p * p));
}

// Modeled after shifted quadrant II of unit circle
public func CircularEaseOut(_ p:Float)->Float
{
    return sqrt((2 - p) * p);
}

// Modeled after the piecewise circular public function
// y = (1/2)(1 - sqrt(1 - 4x^2))           ; [0, 0.5)
// y = (1/2)(sqrt(-(2x - 3)*(2x - 1)) + 1) ; [0.5, 1]
public func CircularEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * (1 - sqrt(1 - 4 * (p * p)));
    }
    else
    {
        return 0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1);
    }
}

// Modeled after the exponential public function y = 2^(10(x - 1))
public func ExponentialEaseIn(_ p:Float)->Float
{
    return (p == 0.0) ? p : pow(2, 10 * (p - 1));
}

// Modeled after the exponential public function y = -2^(-10x) + 1
public func ExponentialEaseOut(_ p:Float)->Float
{
    return (p == 1.0) ? p : 1 - pow(2, -10 * p);
}

// Modeled after the piecewise exponential
// y = (1/2)2^(10(2x - 1))         ; [0,0.5)
// y = -(1/2)*2^(-10(2x - 1))) + 1 ; [0.5,1]
public func ExponentialEaseInOut(_ p:Float)->Float
{
    if(p == 0.0 || p == 1.0) { return p; }
    
    if(p < 0.5)
    {
        return 0.5 * pow(2, (20 * p) - 10);
    }
    else
    {
        return -0.5 * pow(2, (-20 * p) + 10) + 1;
    }
}

// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
public func ElasticEaseIn(_ p:Float)->Float
{
    return sinFloat(13 * M_PI_2_f * p) * pow(2, 10.0 * (p - 1.0));
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
public func ElasticEaseOut(_ p:Float)->Float
{
    return sinFloat(-13 * M_PI_2_f * (p + 1)) * pow(2, -10 * p) + 1;
}

// Modeled after the piecewise exponentially-damped sine wave:
// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))      ; [0,0.5)
// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2) ; [0.5, 1]
public func ElasticEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * sinFloat(13.0 * M_PI_2_f * (2 * p)) * pow(2, 10 * ((2 * p) - 1));
    }
    else
    {
        return 0.5 * (sinFloat(-13 * M_PI_2_f * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) + 2);
    }
}

// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
public func BackEaseIn(_ p:Float)->Float
{
    return p * p * p - p * sinFloat(p * M_PI_f);
}

// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
public func BackEaseOut(_ p:Float)->Float
{
    let f:Float = (1 - p);
    return 1 - (f * f * f - f * sinFloat(f * M_PI_f));
}

// Modeled after the piecewise overshooting cubic public function:
// y = (1/2)*((2x)^3-(2x)*sin(2*x*pi))           ; [0, 0.5)
// y = (1/2)*(1-((1-x)^3-(1-x)*sin((1-x)*pi))+1) ; [0.5, 1]
public func BackEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        let f:Float = 2 * p;
        return 0.5 * (f * f * f - f * sinFloat(f * M_PI_f));
    }
    else
    {
        let f:Float = (1 - (2*p - 1));
        return 0.5 * (1 - (f * f * f - f * sinFloat(f * M_PI_f))) + 0.5;
    }
}

public func BounceEaseIn(_ p:Float)->Float
{
    return 1 - BounceEaseOut(1 - p);
}

public func BounceEaseOut(_ p:Float)->Float
{
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

public func BounceEaseInOut(_ p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * BounceEaseIn(p*2);
    }
    else
    {
        return 0.5 * BounceEaseOut(p * 2 - 1) + 0.5;
    }
}





