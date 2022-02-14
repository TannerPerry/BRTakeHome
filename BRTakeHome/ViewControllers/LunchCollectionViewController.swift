//
//  LunchCollectionViewController.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import UIKit

protocol LunchViewProtocol {
    func restaurantsReceived()
    func imageReceived(image:UIImage, forIndex:Int)
    func navigateToDetailView(withRestaurant:Restaurant)
    func navigateToMapView()
}


class LunchCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "restaurantCell"
    
    private var lunchPresenter : LunchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lunchPresenter = LunchPresenter(lunchView: self, lunchService: ServiceLocator.shared.lunchService)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return lunchPresenter?.restaurants.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
            
        let listModel = lunchPresenter?.getRestaurant(atIndex: indexPath.row)
        lunchPresenter?.fetchImageForRestaurant(atIndex:indexPath.row)
    
        restaurantCell.restaurantNameLabel.text = listModel?.name
        restaurantCell.restaurantCategoryLabel.text = listModel?.category
    
        return restaurantCell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lunchPresenter?.restaurantSelected(atIndex: indexPath.row)
    }
    
    // MARK: UINavigationBar selectors
    @IBAction func mapButtonPressed(_ sender: Any) {
        lunchPresenter?.mapSelected()
    }
    
    // MARK: Screen changed... do stuff
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        // Rotation happened, reflow the collection view
        self.collectionView .collectionViewLayout.invalidateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Size class changed.  Reflow the collection view
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension LunchCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalClass = self.traitCollection.horizontalSizeClass;
        let width = self.view.frame.width
        var size = CGSize(width: width, height: 180.0)
        
        switch (horizontalClass) {
        case UIUserInterfaceSizeClass.compact :
            size = CGSize(width: width, height: 180.0)
            break;
        case UIUserInterfaceSizeClass.regular :
            size = CGSize(width: width / 2, height: 240)
            break;
        default :
            print("Unknown size class")
            break;
        }
        return size
    }
}

extension LunchCollectionViewController : LunchViewProtocol {
    public func restaurantsReceived() {
        DispatchQueue.main.async {
            // Got our restaurants. Reload the collection view
            self.collectionView.reloadData()
        }
    }
    
    public func imageReceived(image:UIImage, forIndex:Int) {
        DispatchQueue.main.async {
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: forIndex, section: 0)) as? RestaurantCollectionViewCell {
//                UIView.animate(withDuration: 0.1) {
                    cell.restaurantImageView.image = image
//                }
            }
        }
    }
    
    public func navigateToDetailView(withRestaurant:Restaurant) {
        guard let detailView = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else {
            print("Couldn't find Restaurant detail view")
            return
        }
        detailView.restaurant = withRestaurant
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    public func navigateToMapView() {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            print("Couldn't find map view")
            return
        }
        self.navigationController?.present(mapVC, animated: true)
    }
}
