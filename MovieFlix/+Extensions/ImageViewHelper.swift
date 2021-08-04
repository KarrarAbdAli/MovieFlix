//
//  ImageViewHelper.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        let completedUrl = (Constants.API.imagesBaseUrl + url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let completedUrlString = completedUrl, let url = URL(string: completedUrlString) else {return }
        DispatchQueue.global().async { [weak self] in
            
            // Check for a cached image.
            if let cachedImage = ImageCache().cachedImages.object(forKey: url as NSURL){
                DispatchQueue.main.async {
                    self?.image = cachedImage
                }
                return
            }

            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        ImageCache().cachedImages.setObject(image, forKey: url as NSURL, cost: data.count)
                    }
                }
            }
        }
    }
}
 
