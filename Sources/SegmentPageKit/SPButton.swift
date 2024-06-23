//
//  SPButton.swift
//  
//
//  Created by Arjun Mohan on 22/06/24.
//

import UIKit

class SPButton: UIButton {
    
    init(title: String, index: Int, font: UIFont?) {
        super.init(frame: .zero)
        setupButton(title: title, index: index, font: font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, index: Int, font: UIFont?) {
        self.titleLabel?.font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        self.setTitle(title, for: .normal)
        self.tag = index
    }
}
