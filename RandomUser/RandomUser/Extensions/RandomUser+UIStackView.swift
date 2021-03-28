//
//  RandomUser+UIStackView.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import UIKit

extension UIStackView {
    static func create(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubviews(arrangedSubviews)
        return stackView
    }

    func addArrangedSubviews(_ arrangedSubviews: [UIView]) -> Void {
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
    }
}
