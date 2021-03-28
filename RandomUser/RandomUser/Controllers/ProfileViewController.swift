//
//  ViewController.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {
    
    //------------------------------------
    // MARK: - IBOutlets
    //------------------------------------

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            profileImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    //------------------------------------
    // MARK: - Properties
    //------------------------------------
    
    // General info
    var firstNameLabel: UILabel = UILabel.createField()
    var lastNameLabel: UILabel = UILabel.createField()
    var emailLabel: UILabel = UILabel.createField()
    var cellPhoneLabel: UILabel = UILabel.createField()
    var usernameLabel: UILabel = UILabel.createField()
    var genderLabel: UILabel = UILabel.createField()
    
    // Address
    var streetLabel: UILabel = UILabel.createField()
    var cityLabel: UILabel = UILabel.createField()
    var stateLabel: UILabel = UILabel.createField()
    var countryLabel: UILabel = UILabel.createField()
    var postcodeLabel: UILabel = UILabel.createField()
    
    var coordinatesLabel: UILabel = UILabel.createField()
    var mapImageView = UIImageView()
    
    //------------------------------------
    // MARK: - VC Life Cycle
    //------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapImageView.heightAnchor.constraint(equalToConstant: mainStackView.frame.width).isActive = true
        view.addSubview(mapImageView)
        
        createLayout()
        fetchUser()
    }
    
    //------------------------------------
    // MARK: - Public Methods
    //------------------------------------
    
    func updateUI(with user: RandomUser) {
        // Profile
        if let url = URL(string: user.pictureURL) {
            profileImageView.load(url: url)
        }
        
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve, .curveEaseIn], animations: { [weak self] in
            // General info
            self?.firstNameLabel.text = UILabel.padding + user.name.title + " " + user.name.first
            self?.lastNameLabel.text = UILabel.padding + user.name.last
            self?.emailLabel.text = UILabel.padding + user.email
            self?.cellPhoneLabel.text = UILabel.padding + user.cellPhone
            self?.usernameLabel.text = UILabel.padding + user.username
            self?.genderLabel.text = UILabel.padding + user.gender.rawValue
            
            // Address
            self?.streetLabel.text = UILabel.padding + user.location.street.name + " " + "\(user.location.street.number)"
            self?.cityLabel.text = UILabel.padding + user.location.city
            self?.stateLabel.text = UILabel.padding + user.location.state
            self?.countryLabel.text = UILabel.padding + user.location.country
            self?.postcodeLabel.text = UILabel.padding + user.location.postcode
            self?.coordinatesLabel.text = UILabel.padding + "\(user.location.coordinates?.description ?? "No coordinates")"
        }, completion: nil)
        
    }
    
    //------------------------------------
    // MARK: - Private Methods
    //------------------------------------
    
    private func createLayout() {
        self.mainStackView.addArrangedSubviews([
            UIView(),
            UILabel.createBigHeader(with: "General Info"),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "First Name"),
                firstNameLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Last Name"),
                lastNameLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Email"),
                emailLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Phone Number"),
                cellPhoneLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Username"),
                usernameLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Gender"),
                genderLabel
            ]),
            UIView(),
            UILabel.createBigHeader(with: "Address"),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Street"),
                streetLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "City"),
                cityLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "State"),
                stateLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Country"),
                countryLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Postcode"),
                postcodeLabel
            ]),
            UIStackView.create(arrangedSubviews: [
                UILabel.createSmallHeader(with: "Location"),
                coordinatesLabel,
                mapImageView
            ])
        ])
    }
    
    private func fetchUser() {
        APIManager.shared.getOneRandomUser { [weak self] (user) in
            DispatchQueue.main.async {
                self?.updateUI(with: user)
                if let coordinates = user.location.coordinates {
                    coordinates.getSnapshot(completion: { image in
                        DispatchQueue.main.async {
                            self?.mapImageView.image = image
                        }
                    })
                }
            }
        } onError: { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    //------------------------------------
    // MARK: - IBActions
    //------------------------------------
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        fetchUser()
    }

}
