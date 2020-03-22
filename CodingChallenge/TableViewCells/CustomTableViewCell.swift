//
//  CustomTableViewCell.swift
//  CodingChallenge
//
//  Created by Praveen on 3/20/20.

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let albumCoverImageView = UIImageView()
    let albumName = UILabel()
    let artistName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        albumName.translatesAutoresizingMaskIntoConstraints = false
        artistName.translatesAutoresizingMaskIntoConstraints = false
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumName)
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(artistName)
        
        let viewsDict = [
            "albumName" : albumName,
            "image" : albumCoverImageView,
            "artistName" : artistName,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(50)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-[albumName]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumName]-[artistName]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[artistName]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(albumName: String?, artistName: String?, imageUrl: String? ) {
        self.albumName.text = albumName
        self.artistName.text = artistName
        if let image =  imageUrl, let imageURL = URL(string:image) {
            self.albumCoverImageView.load(url: imageURL)
        }
    }
}
