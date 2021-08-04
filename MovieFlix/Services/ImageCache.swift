//
//  ImageCache.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    public let cachedImages = NSCache<NSURL, UIImage>()
}
