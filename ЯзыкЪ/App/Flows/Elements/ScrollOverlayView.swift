//
//  ScrollOverlayView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import UIKit

class ScrollOverlayView: UIView {
    var referenceView: UIView?
    
    // MARK: - Overrides
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? referenceView : view
    }
}
