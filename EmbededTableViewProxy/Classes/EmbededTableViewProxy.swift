//
//  EmbededTableViewProxy.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/5.
//
//

import UIKit

open class RecognizeSimultaneousTableView: UITableView, UIGestureRecognizerDelegate {
    
    open var shouldRecognizeSimultaneouslyWithOtherGestureRecognizer: Bool = true
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        panGestureRecognizer.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        panGestureRecognizer.delegate = self
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return shouldRecognizeSimultaneouslyWithOtherGestureRecognizer
    }
}

public class OutterScrollProxy {
    
    public var canScroll: Bool = true
    
    public var innerScrollProxys: [InnerScrollProxy] = []
    
    public init() {}
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView, torance: CGFloat) {
        
        let y = scrollView.contentOffset.y //+ controller.topLayoutGuide.length
        
        print("y = \(y)")
        
        if canScroll {
            if y - torance > 0 {
                innerScrollProxys.forEach { $0.canScroll = true }
                canScroll = false
            } else {
                innerScrollProxys.forEach {
                    $0.scrollView?.contentOffset.y = 0
                    $0.canScroll = false
                }
                canScroll = true
            }
        } else {
            scrollView.contentOffset.y = torance
        }
    }
}

public class InnerScrollProxy {
    
    public var canScroll: Bool = false
    
    public weak var scrollView: UIScrollView?
    
    public weak var outterScrollProxy: OutterScrollProxy?
    
    public init() {}
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !canScroll {
            scrollView.contentOffset.y = 0
        } else {
            if scrollView.contentOffset.y < 0 {
                outterScrollProxy?.canScroll = true
                scrollView.contentOffset.y = 0
                canScroll = false
            }
        }
    }
}
