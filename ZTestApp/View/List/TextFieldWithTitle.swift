//
//  TextFieldWithTitle.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 25.05.2021.
//

import UIKit

class TextFieldWithTitle: UIControl {
// MARK: - Properties

    let label = UILabel()
    let textField = UITextField()

    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }

// MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func isEmpty() -> Bool {
        guard let text = text else { return true }
        return text.isEmpty
    }

    private func setupLayout() {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor

        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.rightAnchor.constraint(equalTo: stackView.leftAnchor, constant: 200)
        ])

    }
}
