//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit
import SnapKit

class MovieListViewController: BaseViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<MovieSection, MovieList>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<MovieSection, MovieList>
    var viewModel: IMovieListViewModel?
    let model = [MovieList]()
    private lazy var datasource = setDataSource()
    
    lazy var collectionView: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        view.backgroundColor = Constants.Colors.backgroundColor
        viewModel?.fetchFromJsonPath()
        applySnapshot()
    }
    
    override func configureViews() {
        super.configureViews()
        observeDataFromViewModel()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints({make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
        })
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
    }
    
   private func setDataSource() -> DataSource {
       let datasource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
            if let item = self.viewModel?.movieList?.movieList {
                cell?.setUpCell(with: item[indexPath.item])
                cell?.contentView.backgroundColor = Constants.Colors.cellColor
            }
            return cell
        })
       return datasource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = SnapShot()
        let sections: [MovieSection] = [.main]
        snapshot.appendSections(sections)
        if let items = viewModel?.movieList?.movieList {
            snapshot.appendItems(items)
        }
        datasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func observeDataFromViewModel() {
        self.showLoading()
        viewModel?.showError = { [weak self] error in
            if let self {
                self.displayAlert(title: Constants.Alert.errorTitle, message: error.localizedDescription, type: .error, action: nil)
                self.hideLoading()
            }
        }
        
        viewModel?.showMovieList = { [weak self] showIfTrue in
            guard let self = self else {return}
           
            if showIfTrue {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.hideLoading()
                }
            }
        }
    }
    

}

extension MovieListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        ControllerSceneDIContainer.movieList = self.viewModel?.movieList?.movieList[indexPath.item]
        ControllerSceneDIContainer.sharedInstance.makeUserDetailsViewController(navigationController: navigationController!)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize, height: collectionViewSize/3)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
