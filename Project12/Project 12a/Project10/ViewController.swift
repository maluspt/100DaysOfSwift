//
//  ViewController.swift
//  Project10
//
//  Created by Maria Luiza Carvalho Sperotto on 07/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Collection View"
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCollectionViewCell else {
            fatalError("Unable to dequeue Person Cell")
            
        }
        let person = people[indexPath.item]
        cell.personNameLabel.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.personImage.image = UIImage(contentsOfFile: path.path)
        
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let alert = UIAlertController(title: "Person", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Rename", style: .default, handler: { [weak self] action in
            self?.renamePersonTapped(person)
        }))
        alert.addAction(UIAlertAction(title: "Delete person", style: .destructive, handler: { [weak self] action in
        self?.deletePersonTapped(at: indexPath)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
        
        
    }
    
    func renamePersonTapped(_ person: Person) {
        let alert = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
            guard let newName = alert?.textFields?[0].text else {
                return
            }
            person.name = newName
            self?.save()
            self?.collectionView.reloadData()
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func deletePersonTapped(at indexPath: IndexPath) {
        let ac = UIAlertController(title: "Confirmation", message: "Delete person \"\(people[indexPath.item].name)\"?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.deletePerson(at: indexPath)
        }))

        present(ac, animated: true)
    }
    
    func deletePerson(at indexPath: IndexPath) {
        DispatchQueue.global().async { [weak self] in
            guard let image = self?.people[indexPath.item].image else {
                return
            }
            
            guard let imagePath = (self?.getDocumentsDirectory() as AnyObject).appendingPathComponent(image) else {
                return
            }
            
            do {
                try FileManager.default.removeItem(at: imagePath)
            }
            catch {
                return
            }

            // deletion ok
            self?.people.remove(at: indexPath.item)

            DispatchQueue.main.async {
                self?.collectionView.deleteItems(at: [indexPath])
            }
        }
    }
    
    
    
    
    
    @objc func addNewPerson() {
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
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        dismiss(animated: true)
        
        }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
}



