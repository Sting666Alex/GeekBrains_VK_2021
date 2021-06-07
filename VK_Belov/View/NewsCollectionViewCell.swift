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
    
    func configure(titleLableC: String, newsElement: NewsResponseItem){
        
        titleLable.text         = titleLableC
        titleText.text          = titleLableC
        whoAndThenLable.text    = titleLableC
        
        titleFoto.isHidden = false
        
        if newsElement.type == "post"{
            if let numberOfViews = newsElement.views?.count{
                numberOfViewsText.text = String(numberOfViews)
            }
            if let likes = newsElement.likes?.count{
                likeNumber.text = String(likes)
            }
            addPhotoInUiView(newsElement: newsElement)
        }
        else if newsElement.type == "wall_photo"{
            addPhotoInUiView(newsElement: newsElement)
        }else{
            addPhotoInUiView(newsElement: newsElement)
        }
    }

    func addPhotoInUiView(newsElement: NewsResponseItem){
        
        titleFoto.layer.cornerRadius = titleFoto.frame.width / 2
        
        //titleFoto.backgroundColor = .gray
        titleFoto.layer.shouldRasterize = false
        titleFoto.clipsToBounds = false
        titleFoto.layer.shadowPath = UIBezierPath(roundedRect: titleFoto.bounds, cornerRadius: 5).cgPath
        
        titleFoto.layer.shadowColor = UIColor.darkGray.cgColor
        titleFoto.layer.shadowRadius = titleFoto.frame.height * 0.2
        titleFoto.layer.shadowOpacity = 1
        titleFoto.layer.shadowOffset = .init(width: 2, height: 2) //(width: 10, height: 10)
       
        guard let img = UIImage(named: "1") else { return }
        var data = img.jpegData(compressionQuality: 1)
        
        titleFoto.isHidden = true
        
        if let countSize = newsElement.attachments?[0].photo?.sizes{
            if !countSize.isEmpty {
                
                if let url:URL = URL(string: countSize[0].url){
                    data = try? Data(contentsOf: url)
                    titleFoto.isHidden = false
                    titleFoto.frame = CGRect(x: 0, y: 0, width: countSize[0].width, height: countSize[0].height)
                }
                
            }
        }
        
        let myImage = UIImageView(frame: titleFoto.bounds)
        myImage.image = UIImage(data: data!)
        
        //myImage.clipsToBounds = true
        //myImage.layer.cornerRadius = titleFoto.frame.height / 2
        
        
        
        
        titleFoto.addSubview(myImage)
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
