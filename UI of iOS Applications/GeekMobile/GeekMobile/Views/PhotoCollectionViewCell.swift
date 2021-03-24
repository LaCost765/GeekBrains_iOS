//
//  PhotoCollectionViewCell.swift
//  ClientVK
//
//  Created by Egor on 07.03.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    private var liked: Bool = false
    
    @IBAction func likeButtonTapped(_ sender: Any) {
                
        switch liked {
        case false:
            let num = Int(likeButton.currentTitle ?? "0")! + 1
            likeButton.setTitle(String(num), for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        case true:
            let num = Int(likeButton.currentTitle ?? "0")! - 1
            likeButton.setTitle(String(num), for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        
        
        liked = !liked
    }
}
