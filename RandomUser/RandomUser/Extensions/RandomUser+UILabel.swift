//
//  RandomUser+UILabel.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import UIKit

extension UILabel {
    
    static var padding: String {
        return "  "
    }
    
    static func createField() -> UILabel {
        let label = UILabel()
        
        label.textColor = .label
        
        label.backgroundColor = .systemGray6
        
        // corner radius
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return label
    }
    
    static func createBigHeader(with text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = text
        label.textColor = .label
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }
    
    static func createSmallHeader(with text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = text
        label.textColor = .secondaryLabel
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }
    
}
