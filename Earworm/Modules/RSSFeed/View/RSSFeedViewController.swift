//
//  RSSFeedViewController.swift
//  Earworm
//
//  Created by Hugo Pinheiro  on 24/01/25.
//

import UIKit
import SnapKit
import SDWebImage

class RSSFeedViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Insira aqui a URL do RSS",
            fontSize: 20,
            textColor: .black,
            alignment: .center
        )
        return label
    }()
    
    private let urlTextField: CustomTextField = {
        let textField = CustomTextField(
            placeholder: "Digite a URL do RSS"
        )
        return textField
    }()

    private let submitButton: CustomButton = {
        let button = CustomButton(
            title: "Buscar",
            backgroundColor: .systemBlue
        )
        return button
    }()
    
    private lazy var clearCacheButton = CustomButton(
        title: "Limpar Cache",
        backgroundColor: .red,
        action: {
            SDImageCache.shared.clear(with: .all)
            
            if let urlString = self.urlTextField.text, !urlString.isEmpty {
                RSSCacheManager.clear(for: urlString)
            }
        }
    )

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Properties
    var presenter: RSSFeedPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RSSFeedPresenter(view: self)
        setupUI()
        setupConstraints()
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(urlTextField)
        view.addSubview(buttonStackView)

        buttonStackView.addArrangedSubview(submitButton)
        buttonStackView.addArrangedSubview(clearCacheButton)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(15)
        }
        
        urlTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(urlTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Actions
    @objc private func submitButtonTapped() {
        presenter?.handleSubmitButtonTapped(with: urlTextField.text)
    }
}

// MARK: - RSSFeedViewProtocol
extension RSSFeedViewController: RSSFeedViewProtocol {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateUI(with feed: RSSFeed) {
        DispatchQueue.main.async {
            self.presenter?.navigateToDetails(with: feed)
        }
    }
}

#Preview {
    let vc = RSSFeedViewController()
    return vc
}
