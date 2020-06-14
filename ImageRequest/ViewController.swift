//
//  ViewController.swift
//  ImageRequest
//
//  Created by Kishore Krishna M on 09/06/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import UIKit


//simple http
enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}


class ViewController: UIViewController {
    
    let imageLocation = KittenImageLocation.http.rawValue
    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        
        guard let imageURL = URL(string: imageLocation) else {
            print("Cannot create URL")
            return
        }
        //        //retrieving image is data task
        //        let task = URLSession.shared.dataTask(with: imageURL) {
        //            (data, response, error) in
        //
        //            guard let data = data else {
        //                print("no data")
        //                return
        //            }
        //            let downloadedImage = UIImage(data: data)
        //            // we need to load the image in main thread
        //            DispatchQueue.main.async {
        //                self.imageView.image = downloadedImage
        //            }
        //
        //            }
        //        //initially task will be in suspended state, we need to resume
        //        task.resume()
        
        // retreiving the image using download task
        
        let task = URLSession.shared.downloadTask(with: imageURL) {location,response,error in
            
            guard let location = location else {
                print("location is nil")
                return
            }
            print(location)
            
            // load the date from file
            let imageData = try! Data(contentsOf: location)
            // turn to image
            let image = UIImage(data: imageData)
            //set image in imageview
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        task.resume()
        
        
    }
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

