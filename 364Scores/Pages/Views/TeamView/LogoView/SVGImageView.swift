//
//  SVGImageView.swift
//  364Scores
//
//  Created by Yohai Reshef on 25/08/2021.
//

import UIKit
import SwiftSVG

class SVGImageView: UIView {
    
    private var svgLayer: SVGLayer?{
        didSet{
            oldValue?.removeFromSuperlayer()
            if let svgLayer = svgLayer {
                self.layer.addSublayer(svgLayer)
                svgLayer.resizeToFit(self.frame)
            }
        }
    }
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(url: String) {
        guard let svgURL = URL(string: url) else { return }
        CALayer(SVGURL: svgURL) { layer in
            self.svgLayer = layer
        }
    }
}
