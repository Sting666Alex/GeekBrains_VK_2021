//
//  AvatarViewController.swift
//  VK_Belov
//
//  Created by Алексей Белов on 05.03.2021.
//

import UIKit

class AvatarViewController: UIViewController {

    @IBOutlet weak var avatarIV: UIImageView!
    
    let url: URL = URL(string:"") ?? URL(string: "https://upload.wikimedia.org/wikipedia/ru/a/a2/Phil_Collins_Face_Value.jpeg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        
        avatarIV.addGestureRecognizer(tap)
        avatarIV.isUserInteractionEnabled = true
        
/*
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/ru/a/a2/Phil_Collins_Face_Value.jpeg"
        )
*/
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        avatarIV.backgroundColor = .gray
        avatarIV.layer.shouldRasterize = false
        avatarIV.clipsToBounds = false
        avatarIV.layer.shadowPath = UIBezierPath(roundedRect: avatarIV.bounds, cornerRadius: 10).cgPath
        
        avatarIV.layer.shadowColor = UIColor.darkGray.cgColor
        avatarIV.layer.shadowRadius = avatarIV.frame.height * 0.2
        avatarIV.layer.shadowOpacity = 1
        avatarIV.layer.shadowOffset = .init(width: 10, height: 10) //(width: 10, height: 10)
        
        let myImage = UIImageView(frame: avatarIV.bounds)
        myImage.image = UIImage(data: data!)
        myImage.clipsToBounds = true
        myImage.layer.cornerRadius = avatarIV.frame.height / 2
        
        avatarIV.addSubview(myImage)
        
    }
    
    @objc func iconTapped(gesture: UITapGestureRecognizer){
        avatarIV.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.avatarIV.transform = .identity
                       }, completion: nil)
    }
    
}
