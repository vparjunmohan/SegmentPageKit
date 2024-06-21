//
//  SPButton.swift
//  
//
//  Created by Arjun Mohan on 22/06/24.
//

import UIKit

class SPButton: UIButton {
    
    init(title: String, index: Int) {
        super.init(frame: .zero)
        setupButton(title: title, index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, index: Int) {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitle(title, for: .normal)
        self.tag = index
    }
}
