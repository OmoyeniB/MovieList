//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
   
    static let identifier = "MovieCollectionViewCell"
    let releasedDateLabel = UILabelMaker.label(textColor: Constants.Colors.textColor)
    let titleLabel = UILabelMaker.label(textColor: Constants.Colors.textColor)
    let durationLabel = UILabelMaker.label(textColor: Constants.Colors.textColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
        initializeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeCell() {
        contentView.addSubviews(titleLabel, releasedDateLabel, durationLabel)
       
        titleLabel.snp.makeConstraints({make in
            make.left.equalTo(contentView.snp.left).inset(20)
            make.top.equalTo(contentView.snp.top).inset(20)
        })
        
        releasedDateLabel.snp.makeConstraints({make in
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
            make.left.equalTo(contentView.snp.left).inset(20)
        })
        
        durationLabel.snp.makeConstraints({make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).inset(20)
        })
    }
    
    func setUpCell(with movieList: MovieList) {
        titleLabel.text = "Title: \(movieList.title)"
        releasedDateLabel.text = "Date released: \(movieList.releasedDate)"
        durationLabel.text = "duration: \(movieList.duration)"
    }
    
}
