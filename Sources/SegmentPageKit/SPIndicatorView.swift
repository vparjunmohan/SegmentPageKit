//
//  SPIndicatorView.swift
//  
//
//  Created by Arjun Mohan on 22/06/24.
//

import UIKit

class SPIndicatorView: UIView {
    
    init(indicatorColor: UIColor = .clear) {
        super.init(frame: .zero)
        backgroundColor = indicatorColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
