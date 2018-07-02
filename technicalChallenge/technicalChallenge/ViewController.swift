//
//  ViewController.swift
//  technicalChallenge
//
//  Created by Sai prasad Soma on 7/2/18.
//  Copyright © 2018 Sai prasad Soma. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var profiles = [Results]()
    var seletedProfile:Results?
    var selectedCells:Array = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().getProfiles(completion: { [weak self](profile, status, msg) in
            if let profile = profile, status {
                self?.profiles = profile
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                //show alert
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? DetailsViewController {
            desination.profile = seletedProfile
        }
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate, CellProtocol {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = profiles[indexPath.row]
        if let thum = user.picture?.thumbnail, let url = URL.init(string: thum) {
            cell.imageViewUser?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "HQwHI"), options: .cacheMemoryOnly, completed: nil)
        }
        if let fname = (user.name?.first) {
            cell.labelFName.text = "First Name:  " + fname
        }
        
        if let sname = (user.name?.last) {
            cell.labelSname.text = "Last Name:  " + sname
        }
        
        if selectedCells.contains(indexPath.row){
            cell.likeButton.tintColor = .green
        }else {
            cell.likeButton.tintColor = .lightGray
        }
        cell.deleagte = self
        return cell
    }
    
    func selectedCell(cell:UserTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if !selectedCells.contains(indexPath.row){
                selectedCells.append(indexPath.row)
            }else {
                if let index = selectedCells.index(of: indexPath.row) {
                    selectedCells.remove(at: index)
                }
            }
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        cell.shake()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seletedProfile = profiles[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension UITableViewCell {
    func shake(duration: CFTimeInterval = 0.3, pathLength: CGFloat = 15) {
        let position: CGPoint = center
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint.init(x:position.x, y:position.y))
        path.addLine(to: CGPoint.init(x: position.x-pathLength, y:  position.y))
        path.addLine(to: CGPoint.init(x:position.x+pathLength, y:position.y))
        path.addLine(to: CGPoint.init(x:position.x-pathLength, y:position.y))
        path.addLine(to: CGPoint.init(x:position.x+pathLength, y:position.y))
        path.addLine(to: CGPoint.init(x:position.x, y:position.y))
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        
        positionAnimation.path = path.cgPath
        positionAnimation.duration = duration
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
    }
}

extension UIView {
    func shakeas() {
        let midX = center.x
        let midY = center.y
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 10, y: midY)
        animation.toValue = CGPoint(x: midX + 10, y: midY)
        layer.add(animation, forKey: "position")
    }
}
