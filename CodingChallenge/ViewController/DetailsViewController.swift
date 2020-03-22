//
//  DetailsViewController.swift
//  CodingChallenge
//
//  Created by Praveen on 3/20/20.

import UIKit

class DetailsViewController: UIViewController {

    private var iTunesUrl: String?
    private let imageView = UIImageView()
    private let trackNameLabel  = UILabel()
    private let artistNameLabel  = UILabel()
    private let releaseDateLabel  = UILabel()
    private let copyRightLabel  = UILabel()
    private let genreLabel  = UILabel()
    private let stackView   =  UIStackView()

    private struct Attributes {
        static let viewPadding:CGFloat = 20.0
        static let buttonHeight:CGFloat = 50.0
        static let stackViewLabelSpacing:CGFloat = 16.0
        static let albumImageWH:CGFloat = 175.0
        static let buttonCornerRadius:CGFloat = 25.0
        static let buttonTitle = "iTunes Store"
        static let commaSeparatorString = ", "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: - Private methods

    /// It add label and textfields to the view and also it set the frame.
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        //Stack View
        stackView.frame = CGRect(x: Attributes.viewPadding, y: 0, width: self.view.frame.width - Attributes.viewPadding - Attributes.viewPadding, height: self.view.frame.height)
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = Attributes.stackViewLabelSpacing
        
        //Adding labels to Stackview
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(trackNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(copyRightLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(stackView)
        
        //UIButton
        let iTunesButton = UIButton(frame: CGRect(x: Attributes.viewPadding, y: self.view.frame.height - Attributes.viewPadding - Attributes.buttonHeight, width: self.view.frame.width - Attributes.viewPadding - Attributes.viewPadding, height: Attributes.buttonHeight))
        iTunesButton.backgroundColor = .black
        iTunesButton.setTitle(Attributes.buttonTitle, for: .normal)
        iTunesButton.layer.cornerRadius = Attributes.buttonCornerRadius
        iTunesButton.addTarget(self, action: #selector(iTunesButtonAction), for: .touchUpInside)
        self.view.addSubview(iTunesButton)
        setupAutoLayoutConstraints()
    }
    
    /// It set the autolayout Constraints to the stackView
    private func setupAutoLayoutConstraints() {
        
        //Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
        imageView.heightAnchor.constraint(equalToConstant: Attributes.albumImageWH).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Attributes.albumImageWH).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: stackView.frame.width).isActive = true
        genreLabel.widthAnchor.constraint(equalToConstant: stackView.frame.width).isActive = true
        releaseDateLabel.widthAnchor.constraint(equalToConstant: stackView.frame.width).isActive = true
        copyRightLabel.widthAnchor.constraint(equalToConstant: stackView.frame.width).isActive = true
    }
    
    //MARK: - Internal methods
    /// It set the labels content.
    /// - Parameter details: Need to pass the details to display.
    func setContentForDetails(details: Result) {
        iTunesUrl = details.url
        self.title = details.name
        
        //Text Label's
        trackNameLabel.text  = details.name
        trackNameLabel.textAlignment = .center
        artistNameLabel.text  = details.artistName
        artistNameLabel.textAlignment = .left
        releaseDateLabel.text  = details.releaseDate
        releaseDateLabel.textAlignment = .left
        copyRightLabel.text  = details.copyright
        copyRightLabel.textAlignment = .left
        copyRightLabel.numberOfLines = 0
        
        //Image View
        if let image =  details.artworkUrl100, let imageURL = URL(string:image) {
            imageView.load(url: imageURL)
        }
        var genreString:[String] = []
        if let genres = details.genres {
            for genre in genres {
                if let drink = genre.name {
                    genreString.append(drink)
                }
            }
        }
        genreLabel.text = genreString.joined(separator:Attributes.commaSeparatorString)
    }
    
    @objc func iTunesButtonAction(sender: UIButton) {
        guard let urlString = iTunesUrl,let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
