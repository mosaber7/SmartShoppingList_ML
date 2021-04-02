//
//  ImageStore.swift
//  ToDoApp
//
//  Created by Saber on 08/02/2021.
//
import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    
    
    func Image(forKey key: String)-> UIImage?{
        if let exisitingImage = cache.object(forKey: key as NSString){
            return exisitingImage
        }
        let url = imageURL(forKey: key)
        guard let imageFromDesk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        return imageFromDesk
    }
    func delelteImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch  {
            print("error deleting from the system")
        }

    }
    func setImage(_ image: UIImage, forKey key:String ){
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.5){
            try? data.write(to: url)
        }
        
    }
    
    func imageURL(forKey key:String)-> URL{
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
        
    }
    

    
}
