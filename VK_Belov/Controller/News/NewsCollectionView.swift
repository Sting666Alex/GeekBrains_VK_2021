//
//  NewsTableViewCell.swift
//  VK_Belov
//
//  Created by Алексей Белов on 23.03.2021.
//

import UIKit
import RealmSwift

class NewsCollectionView: UICollectionViewController,
                          //UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Регистрация своего view controller
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.reuseId)
        
        loadNews()
    }
    // MARK: - Data source
    var myNewsItem: [NewsResponseItem] = []

    private func loadNews(){
        WebService().newsRequest{ [weak self] frendsElementRequest in
            self?.myNewsItem = frendsElementRequest
            //self?.setupDataSource()
            self?.collectionView.reloadData() //.tableView.reloadData()
        }
    }
    
    private func getNews( for indexPath: IndexPath) -> NewsResponseItem {
        return myNewsItem[indexPath.row] //[indexPath.row]
    }
    
    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNewsItem.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseId, for: indexPath)
            as! NewsCollectionViewCell

        let bounds: CGRect = UIScreen.main.bounds
        let width:CGFloat = bounds.size.width
        //let height:CGFloat = bounds.size.height
        
        if !myNewsItem.isEmpty{
            let activNews = getNews(for: indexPath)
            do{
                cell.configure(
                    titleLableC: activNews.text!,
                    newsElement: activNews
                )
            }catch{
               print(error)
            }
        }
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //get width screen
        let width = collectionView.frame.width  / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func getDate(dateEnd: Date) -> String{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.mm.yyyy"
            let date = formatter.string(from: dateEnd as Date)
            return date
        }
    
}
