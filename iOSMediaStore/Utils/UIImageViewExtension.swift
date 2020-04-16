//
//  UIImageViewExtension.swift
//  iOSMediaStore
//
//  Created by Roger Navarro on 4/16/20.
//  Copyright © 2020 Roger Navarro. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL, callBack: (() -> ())? = nil ) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                        if let callBack = callBack {
                            callBack()
                        }
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
}
