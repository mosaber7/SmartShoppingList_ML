//
//  ShowDetails.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import UIKit

class ShowDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nameText: UITextField!
    @IBOutlet var dateText: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var task: Item!{
        didSet{
            navigationItem.title = task.name
        }
    }
    var imageStore: ImageStore!
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        return formatter
    }()
    
    let mobileNet = MobileNetV2()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameText.text = task.name
        dateText.text = dateFormatter.string(from: task.dateCreated)
        
        let key = task.taskKey
        let imageToDisplay = imageStore.Image(forKey: key)
        imageView.image = imageToDisplay
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let name = nameText.text{
            task.name = name
        }
        
    }
    
    @IBAction func chooseSourcePhot(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
           let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        alertController.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "library", style: .default) {_ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
             self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType)-> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        imageStore.setImage(image, forKey: task.taskKey)
        if let name = recognize(imag: image){
            nameText.text = name
            task.name = name
            navigationItem.title = name
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    func recognize(imag:UIImage) -> String? {
        if let pixelBufferItem = ImageToPixelBufferConverter.convertToPixelBuffer(image: imag){
            if let predection = try? self.mobileNet.prediction(image: pixelBufferItem){
                return predection.classLabel
            }
            
        }
        
        return nil
    }
    
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}
