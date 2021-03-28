//
//  RandomUser+UIImageView.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            guard let self = self else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve, .curveEaseIn], animations: {
                    self.image = image
                }, completion: nil)
            }
        }
    }
}
