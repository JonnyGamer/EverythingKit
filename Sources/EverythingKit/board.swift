//
//  File.swift
//  
//
//  Created by Jonathan Pappas on 8/2/21.
//

import SpriteKit

public var w: CGFloat = 1000
public var h: CGFloat = 1000

public func build(_ view: SKView,_ scene: SKScene) {
    // Load the SKScene from 'GameScene.sks'
    w = scene.size.width
    h = scene.size.height
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
        
    // Present the scene
    view.presentScene(scene)
    
    view.ignoresSiblingOrder = true
    
    view.showsFPS = false
    view.showsNodeCount = false
}

public extension SKLabelNode {
    func bold() {
        fontName = "Avenir Next"
    }
    func unpixelate() {
        fontSize *= xScale
        setScale(1.0)
    }
}
public extension CGPoint {
    static var midScreen: Self { .init(x: w/2, y: h/2) }
}
public extension CGSize {
    static var thousand: Self { .init(width: 1000, height: 1000) }
    static var screenSize: Self { .init(width: w, height: h) }
    func times(_ this: CGFloat) -> Self {
        return .init(width: width * this, height: height * this)
    }
}

public extension SKNode {
    func centerAt(point: CGPoint) {
        position = point
        let whereThis = calculateAccumulatedFrame()
        position.x += point.x - whereThis.midX
        position.y += point.y - whereThis.midY
    }

    func keepInside(_ thhisSize: CGSize) {
        let nodeSize = calculateAccumulatedFrame()
        setScale(min((thhisSize.width / nodeSize.width) * xScale, (thhisSize.height / nodeSize.height) * yScale))
    }
}


open class Tile: SKSpriteNode {
    public var x = 0
    public var y = 0
}

open class Board<T: Tile>: SKNode {
    
    public var dimensions: (x: Int, y: Int)
    public var array: [[T]] = []
    
    public func tile(x: Int, y: Int) -> T {
        return array[x-1][y-1]
    }
    
    public func neighbors(x: Int, y: Int) -> [T] {
        var n: [T] = []
        for dx in [-1,0,1] {
            for dy in [-1,0,1] {
                if dx == 0, dy == 0 { continue }
                let newX = x + dx
                let newY = y + dy
                if newX < 1 || newX > dimensions.x { continue }
                if newY < 1 || newY > dimensions.y { continue }
                n.append(tile(x: newX, y: newY))
            }
        }
        return n
    }
    
    public init(x: Int, y: Int, padding: CGFloat = 0) {
        self.dimensions = (x, y)
        super.init()
        
        for x in 1...x {
            array.append([])
            for y in 1...y {
                let tile = T.init(color: .black, size: .init(width: 100, height: 100))
                let padded = (padding * 100) + 100
                tile.position = CGPoint(x: CGFloat(x) * padded, y: CGFloat(y) * padded)
                array[x-1].append(tile)
                tile.x = x
                tile.y = y
                addChild(tile)
            }
        }
    }
    
    public func loop(_ run: (T) -> ()) {
        for x in 1...dimensions.x {
            for y in 1...dimensions.y {
                run(tile(x: x, y: y))
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#if os(macOS)
extension SKScene {
    open override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let nodos = nodes(at: location)
        for i in nodos {
            if let j = i as? Tile {
                tapped(tile: j)
            }
        }
    }
}
#endif

#if os(iOS)
public extension SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let nodos = nodes(at: location)
        for i in nodos {
            if let j = i as? Tile {
                tapped(tile: j)
            }
        }
    }
}
#endif


extension SKScene {
    @objc open func tapped(tile: Tile) {}
}
