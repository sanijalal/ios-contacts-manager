//
//  OrangeDotTableHeaderView.swift
//  ContactsManager
//
//  Created by Abd Sani Abd Jalal on 05/09/2021.
//  Copyright © 2021 Sani. All rights reserved.
//

import Foundation
import UIKit

class OrangeDotTableHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let circleView = CircleView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circleView.backgroundColor = .white
        self.addSubview(circleView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        circleView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        circleView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        circleView.widthAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.8).isActive = true
        circleView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.8).isActive = true
    }
}
