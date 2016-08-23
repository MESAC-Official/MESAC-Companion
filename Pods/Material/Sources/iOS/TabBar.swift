/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

@objc(TabBarLineAlignment)
public enum TabBarLineAlignment: Int {
	case top
	case bottom
}

@objc(TabBarDelegate)
public protocol TabBarDelegate {
    /**
     A delegation method that is executed when the button will trigger the
     animation to the next tab.
     - Parameter tabBar: A TabBar.
     - Parameter button: A UIButton.
     */
    @objc
    optional func tabBarWillSelectButton(tabBar: TabBar, button: UIButton)
    
    /**
     A delegation method that is executed when the button did complete the
     animation to the next tab.
     - Parameter tabBar: A TabBar.
     - Parameter button: A UIButton.
     */
    @objc
    optional func tabBarDidSelectButton(tabBar: TabBar, button: UIButton)
}

open class TabBar: View {
    /// Will render the view.
	open var willRenderView: Bool {
		return 0 < width && 0 < height && nil != superview
	}
    
    /// A preset wrapper around contentInset.
    open var contentEdgeInsetsPreset: EdgeInsetsPreset {
        get {
            return grid.contentEdgeInsetsPreset
        }
        set(value) {
            grid.contentEdgeInsetsPreset = value
        }
    }
    
    /// A wrapper around grid.contentInset.
    @IBInspectable
    open var contentInset: EdgeInsets {
        get {
            return grid.contentEdgeInsets
        }
        set(value) {
            grid.contentEdgeInsets = value
        }
    }
    
    /// A preset wrapper around interimSpace.
    open var interimSpacePreset = InterimSpacePreset.none {
        didSet {
            interimSpace = InterimSpacePresetToValue(preset: interimSpacePreset)
        }
    }
    
    /// A wrapper around grid.interimSpace.
    @IBInspectable
    open var interimSpace: InterimSpace {
        get {
            return grid.interimSpace
        }
        set(value) {
            grid.interimSpace = value
        }
    }
    
    /// A delegation reference.
    public weak var delegate: TabBarDelegate?
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: 49)
    }
    
    /// The currently selected button.
    open var selected: UIButton?
    
	/// Buttons.
	open var buttons = [UIButton]() {
		didSet {
			for b in oldValue {
                b.removeFromSuperview()
            }
			
            grid.views = buttons as [UIView]
            
			layoutSubviews()
		}
	}
    
    /// A reference to the line UIView.
    internal var line: UIView!
    
    /// The line color.
    open var lineColor: UIColor? {
        get {
            return line.backgroundColor
        }
        set(value) {
            line.backgroundColor = value
        }
    }
    
    /// A value for the line alignment.
    open var lineAlignment = TabBarLineAlignment.bottom {
        didSet {
            layoutSubviews()
        }
    }
    
    /// The line height.
    open var lineHeight: CGFloat {
        get {
            return line.height
        }
        set(value) {
            line.height = value
        }
    }
    
    /// Layer Reference.
    open internal(set) var divider: Divider!
    
    open override func layoutSubviews() {
		super.layoutSubviews()
		if willRenderView {
            if 0 < buttons.count {
                let columns: Int = grid.axis.columns / buttons.count
                for b in buttons {
                    b.grid.columns = columns
                    b.contentEdgeInsets = .zero
                    b.layer.cornerRadius = 0
                    b.removeTarget(self, action: #selector(handleButton(button:)), for: .touchUpInside)
                    b.addTarget(self, action: #selector(handleButton(button:)), for: .touchUpInside)
                }
                grid.reload()
                
                if nil == selected {
                    selected = buttons.first
                }
                
                line.frame = CGRect(x: selected!.x, y: .bottom == lineAlignment ? height - lineHeight : 0, width: selected!.width, height: lineHeight)
            }
            divider.reload()
		}
	}
	
	/// Handles the button touch event.
    @objc
	internal func handleButton(button: UIButton) {
		delegate?.tabBarWillSelectButton?(tabBar: self, button: button)
        selected = button
        
        UIView.animate(withDuration: 0.25, animations: { [weak self, button = button] in
            guard let s = self else {
                return
            }
            s.line.x = button.x
            s.line.width = button.width
        }) { [weak self, button = button] _ in
            guard let s = self else {
                return
            }
            s.delegate?.tabBarDidSelectButton?(tabBar: s, button: button)
        }
	}
	
	/**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepareView method
     to initialize property values and other setup operations.
     The super.prepareView method should always be called immediately
     when subclassing.
     */
	open override func prepareView() {
		super.prepareView()
        interimSpacePreset = .interimSpace1
        contentEdgeInsetsPreset = .none
        autoresizingMask = .flexibleWidth
        prepareLine()
        prepareDivider()
	}
	
	// Prepares the line.
	private func prepareLine() {
		line = UIView()
        line.zPosition = 5100
		lineColor = Color.blueGrey.lighten3
		lineHeight = 3
        addSubview(line)
	}
    
    /// Prepares the divider.
    private func prepareDivider() {
        divider = Divider(view: self)
    }
}
