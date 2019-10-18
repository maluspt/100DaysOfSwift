//
//  ViewController.swift
//  Milestone Project 3
//
//  Created by Maria Luiza Carvalho Sperotto on 17/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
    }
    
    
    
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(caption: "Unknown", image: imageName)
        photos.append(photo)
        tableView.reloadData()
        dismiss(animated: true)
        let alert = UIAlertController(title: "Caption", message: "Enter a caption for this image!", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] _ in
            guard let caption = alert?.textFields?[0].text else { return }
            photo.caption = caption
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as! PhotoTableViewCell
        let photo = photos[indexPath.row]
        cell.captionLabel.text = photo.caption
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.photoLabel?.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let photo = photos[indexPath.row]
            vc.selectedPhoto?.image = photo.image
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }


}

