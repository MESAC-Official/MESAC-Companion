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

/// A memory reference to the NavigationItem instance.
private var NavigationItemKey: UInt8 = 0
private var NavigationItemContext: UInt8 = 0

public class NavigationItem: NSObject {
    /// Should center the contentView.
    open var contentViewAlignment = ContentViewAlignment.center {
        didSet {
            navigationBar?.layoutSubviews()
        }
    }
    
	/// Back Button.
	public var backButton: IconButton?
	
	/// Content View.
    public private(set) lazy var contentView = UIView()
	
	/// Title label.
	public private(set) lazy var titleLabel = UILabel()
	
	/// Detail label.
	public private(set) lazy var detailLabel = UILabel()
	
	/// Left controls.
    public var leftControls = [UIView]() {
        didSet {
            navigationBar?.layoutSubviews()
        }
    }
	
	/// Right controls.
    public var rightControls = [UIView]() {
        didSet {
            navigationBar?.layoutSubviews()
        }
    }
	
    public var navigationBar: NavigationBar? {
        return contentView.superview?.superview as? NavigationBar
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard "titleLabel.textAlignment" == keyPath else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        contentViewAlignment = .center == titleLabel.textAlignment ? .center : .any
    }
    
    deinit {
        removeObserver(self, forKeyPath: "titleLabel.textAlignment")
    }
    
	/// Initializer.
	public override init() {
		super.init()
        prepareTitleLabel()
		prepareDetailLabel()
	}
    
    /// Reloads the subviews for the NavigationBar.
    internal func reload() {
        navigationBar?.layoutSubviews()
    }
	
	/// Prepares the titleLabel.
	private func prepareTitleLabel() {
		titleLabel.font = RobotoFont.medium(with: 17)
		titleLabel.textAlignment = .center
        addObserver(self, forKeyPath: "titleLabel.textAlignment", options: [], context: &NavigationItemContext)
	}
	
	/// Prepares the detailLabel.
	private func prepareDetailLabel() {
		detailLabel.font = RobotoFont.regular(with: 12)
		detailLabel.textAlignment = .center
	}
}

extension UINavigationItem {
	/// NavigationItem reference.
	public internal(set) var navigationItem: NavigationItem {
		get {
			return AssociatedObject(base: self, key: &NavigationItemKey) {
				return NavigationItem()
			}
		}
		set(value) {
			AssociateObject(base: self, key: &NavigationItemKey, value: value)
		}
	}
    
    /// Should center the contentView.
    public var contentViewAlignment: ContentViewAlignment {
        return navigationItem.contentViewAlignment
    }
	
    /// Content View.
    public var contentView: UIView {
        return navigationItem.contentView
    }
    
	/// Back Button.
	public internal(set) var backButton: IconButton? {
		get {
			return navigationItem.backButton
		}
		set(value) {
			navigationItem.backButton = value
		}
	}
	
	@nonobjc
	public var title: String? {
		get {
			return titleLabel.text
		}
		set(value) {
			titleLabel.text = value
            navigationItem.reload()
		}
	}
	
	/// Title Label.
	public var titleLabel: UILabel {
		return navigationItem.titleLabel
	}
	
	/// Detail text.
	public var detail: String? {
		get {
			return detailLabel.text
		}
		set(value) {
			detailLabel.text = value
            navigationItem.reload()
		}
	}
	
	/// Detail Label.
	public var detailLabel: UILabel {
		return navigationItem.detailLabel
	}
	
	/// Left side UIViews.
	public var leftControls: [UIView] {
		get {
			return navigationItem.leftControls
		}
		set(value) {
			navigationItem.leftControls = value
		}
	}
	
	/// Right side UIViews.
	public var rightControls: [UIView] {
		get {
			return navigationItem.rightControls
		}
		set(value) {
			navigationItem.rightControls = value
		}
	}
}
