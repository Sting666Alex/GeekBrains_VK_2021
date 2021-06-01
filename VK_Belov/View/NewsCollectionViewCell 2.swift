//
//  NewsCollectionViewCell.swift
//  VK_Belov
//
//  Created by Алексей Белов on 24.03.2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "NewsCollectionViewCell"
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var whoAndThenLable: UILabel!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var titleFoto: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeNumber: UILabel!
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var numberOfViewsText: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapL = UITapGestureRecognizer(target: self, action: #selector(LikeTapped))
        
        likeButton.addGestureRecognizer(tapL)
        likeButton.isUserInteractionEnabled = true
        
        let tapF = UITapGestureRecognizer(target: self, action: #selector(ForwardTapped))
        forwardButton.addGestureRecognizer(tapF)
        forwardButton.isUserInteractionEnabled = true
 
        let tapC = UITapGestureRecognizer(target: self, action: #selector(CommentTapped))
        commentButton.addGestureRecognizer(tapC)
        commentButton.isUserInteractionEnabled = true

        
    }
    
    func configure(titleLableC: String?, newsElement: NewsResponseItem){
        
        let titleLableText: String = ""
        
        if var titleLableText = titleLableC{
            while !titleLableText.isEmpty && titleLableText.count <= 15  {
                    titleLableText.remove(at: titleLableText.index(before: titleLableText.endIndex))
                    titleLableText.append("...")
                }
        }
        
        titleLable.text = titleLableText
        titleText.text = titleLableC
        whoAndThenLable.text = ""
        
        if let likes = newsElement.likes?.count{
            likeNumber.text = String(likes)
        }
        
        if let views = newsElement.views?.count{
            numberOfViewsText.text = String(views)
        }
        
        titleFoto.backgroundColor = .gray
        titleFoto.layer.cornerRadius = titleFoto.frame.width / 2
        
        
        titleFoto.backgroundColor = .gray
        titleFoto.layer.shouldRasterize = false
        titleFoto.clipsToBounds = false
        titleFoto.layer.shadowPath = UIBezierPath(roundedRect: titleFoto.bounds, cornerRadius: 5).cgPath
        
        titleFoto.layer.shadowColor = UIColor.darkGray.cgColor
        titleFoto.layer.shadowRadius = titleFoto.frame.height * 0.2
        titleFoto.layer.shadowOpacity = 1
        titleFoto.layer.shadowOffset = .init(width: 2, height: 2) //(width: 10, height: 10)
        
        do{
            let url: URL = URL(string:"") ?? URL(string: "https://img1.pngindir.com/20180607/cik/kisspng-electronic-cigarette-akademia-infiniti-american-pi-gerl-5b18c0880b22d0.4070254915283488080456.jpg")!
            
            if let urlVK = newsElement.photos?.items[0].sizes[0].url{
                let url: URL = URL(string: urlVK)!
            }
        
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        //myImage.image = UIImage(data: data!)
        
        let myImage = UIImageView(frame: titleFoto.bounds)
        
        //if let image = user.urlFoto {
            myImage.image = UIImage(data: data!) // titleFoto.image = UIImage(named: image)
        //} else {
        //    myImage.image = UIImage(named: "person")
        //}
        
        myImage.clipsToBounds = true
        myImage.layer.cornerRadius = titleFoto.frame.height / 2
        
        titleFoto.addSubview(myImage)
        }
        catch{}
    }

    @objc func ForwardTapped(gesture: UITapGestureRecognizer){
        forwardButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.forwardButton.transform = .identity
                       }, completion: nil)
    }
    
    @objc func CommentTapped(gesture: UITapGestureRecognizer){
        commentButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.commentButton.transform = .identity
                       }, completion: nil)
    }
    
    @objc func LikeTapped(gesture: UITapGestureRecognizer){
        likeButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.likeButton.transform = .identity
                       }, completion: nil)
    }
    

}
