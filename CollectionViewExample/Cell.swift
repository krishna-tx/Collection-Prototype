//
//  Cell.swift
//  CollectionViewExample
//
//  Created by Krishna Ramesh on 8/9/25.
//

import UIKit

class Cell: UICollectionViewCell {
    
    let slideView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let risingText: UILabel = {
        let label = UILabel()
        label.text = "This is some rising text"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stationaryText: UILabel = {
        let label = UILabel()
        label.text = "This is some stationary text"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Click Me", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var textNormalConstraint: NSLayoutConstraint!
    private var textRaisedConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .black
        self.contentView.layer.cornerRadius = 8
        
        self.contentView.addSubview(self.risingText)
        self.contentView.addSubview(self.stationaryText)
        self.contentView.addSubview(self.button)
        self.contentView.addSubview(self.slideView)

        NSLayoutConstraint.activate([
            self.slideView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.slideView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.slideView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.slideView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.stationaryText.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.stationaryText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 250)
        ])
        
        self.textNormalConstraint = self.risingText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 250)
        self.textRaisedConstraint = self.risingText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 200)
        self.risingText.alpha = 0
        
        NSLayoutConstraint.activate([
            self.risingText.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            textNormalConstraint
        ])
        
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        self.textNormalConstraint.isActive = false
        self.textRaisedConstraint.isActive = true
        
        UIView.animate(withDuration: 0.25) {
            self.risingText.alpha = 1
            self.contentView.layoutIfNeeded()
        }
    }
}
