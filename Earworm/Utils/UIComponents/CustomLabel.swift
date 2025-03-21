//
//  CustomLabel.swift
//  Earworm
//
//  Created by Hugo Pinheiro  on 24/01/25.
//

import Foundation
import UIKit

class CustomLabel: UILabel {

    init(text: String, fontSize: CGFloat = 16.0, textColor: UIColor = .black, alignment: NSTextAlignment = .left, isbold: Bool = false) {
        super.init(frame: .zero)
        self.text = text
        self.font = isbold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
