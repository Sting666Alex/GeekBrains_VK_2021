//
//  NewsTableViewCell.swift
//  VK_Belov
//
//  Created by Алексей Белов on 23.03.2021.
//

import UIKit

class NewsCollectionView: UICollectionViewController,
                          //UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Регистрация своего view controller
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.reuseId)
        
        loadNews()
        setupDataSource()
    }
    // MARK: - Data source
    var myNews: [NewsClass] = []
    var filterMyNews: [NewsClass] = []
    var sections: [Date] = []
    var myNewsSection: [Date: [NewsClass]] = [:]
    
    private func loadNews(){
        myNews = NewsClass.arrNewsClass.sorted(by: { $0.date < $1.date } )
        
        WebService().newsRequest()
        
    }
    
    private func filterNews(text: String?){
        guard let text = text, !text.isEmpty else{
            filterMyNews = myNews
            return
        }
        //filterMyNews = myNews.filter{
            //$0.date.lowercased().contains(text.lowercased())
        //}
    }
    
    private func setupDataSource(){
        // 1 sort myFrends
        //
        
        filterNews(text: "")//text: searchBar.text)
        
        // 2 create section firs latters
        let firstdate = filterMyNews.map {  $0.date  } //.uppercased().prefix(1)
        sections = Array(Set(firstdate)).sorted()
        
        // 3 create myFrendsSection
        myNewsSection.removeAll()
        for section in sections {
            myNewsSection[section] = filterMyNews.filter{
                $0.date == section
            }
        }
    }
    
    private func getNews( for indexPath: IndexPath) -> NewsClass {
        let sectionLetter = sections[indexPath.section]
        return myNewsSection[sectionLetter]![0] //[indexPath.row]
    }
    
    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseId, for: indexPath)
            as! NewsCollectionViewCell

        let bounds: CGRect = UIScreen.main.bounds
        let width:CGFloat = bounds.size.width
        //let height:CGFloat = bounds.size.height
        
        let activNews = getNews(for: indexPath)
        
        cell.configure(titleLableC: activNews.titleLable, titleTextC: activNews.textLable, titleFotoString: activNews.urlFoto, whoAndThenLableString: String(activNews.who + " " + getDate(dateEnd: activNews.date)), width: width, likeNumberC: String(activNews.likeNumber))
        
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
