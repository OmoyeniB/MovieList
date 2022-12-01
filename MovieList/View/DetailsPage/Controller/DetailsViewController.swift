//
//  DetailsViewController.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit
import LinkPresentation

class DetailsViewController: BaseViewController {
    
    private let videoCacheManager = VideoCacheManager()
    private lazy var metadataProvider = LPMetadataProvider()
    var viewModel: DetailsViewModelProtocol?
    var movieListItem: MovieList?
    let descriptionLabel = UILabelMaker.label(textColor: Constants.Colors.textColor)
    var metaData: LPLinkMetadata?

    lazy var videoView: LPLinkView = {
        var linkView = LPLinkView()
        return linkView
    }()
    
    lazy var ratingsButton: UIButton = {
        var ratingsButton = UIButton()
        ratingsButton.setImage(UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)), for: .normal)
        ratingsButton.tintColor = .systemBlue
        ratingsButton.backgroundColor = .clear
        ratingsButton.setTitleColor(Constants.Colors.textColor, for: .normal)
        return ratingsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        view.backgroundColor = Constants.Colors.backgroundColor
    }

    override func configureViews() {
        super.configureViews()
        if let movieListItem  = viewModel?.movieListItem{
            setUpView(with: movieListItem)
        }
        view.addSubviews(videoView, ratingsButton, descriptionLabel)
        
        DispatchQueue.main.async {
            self.videoView.snp.makeConstraints({ make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(20)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().inset(20)
                make.height.equalTo(300)
            })
        }
        
        ratingsButton.snp.makeConstraints({make in
            make.top.equalTo(videoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        })
        
        descriptionLabel.snp.makeConstraints({make in
            make.top.equalTo(ratingsButton.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        })
    }
    
    func setUpView(with model: MovieList) {
        self.ratingsButton.setTitle(String(model.rating), for: .normal)
        self.descriptionLabel.text = "Description:  \(model.description)"
        self.loadVideoWithLPLinkPreview(trailerLink: model.trailerLink)
    }
    
    func loadVideoWithLPLinkPreview(trailerLink: String) {
        if let url = URL(string: trailerLink) {
            if let metadata = videoCacheManager.metadata(for: url) {
                videoView.metadata = metadata
                DispatchQueue.main.async {
                    self.hideLoading()
                }
                return
            }
            metadataProvider.startFetchingMetadata(for: url) { [weak self] (metadata, error) in
                if let error = error {
                    print(error)
                }
                else if let metadata = metadata {
                    DispatchQueue.main.async { [weak self] in
                        self?.videoCacheManager.store(metadata)
                        self?.videoView.metadata = metadata
                        self?.hideLoading()
                    }
                }
            }
        }
    }
    
}
