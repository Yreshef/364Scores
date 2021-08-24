//
//  HomeViewController.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties | Components
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties | Variables
    
    private var interactor: FootballDataInteracting!
    private var subscriptions: Set<AnyCancellable> = []
    
    var teams: [Team]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Reloaded table view!")
            }
            print("Array has changed! 😱😱😱")
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeamsData()
    }
    
    // MARK: - Methods
    
    static func create(interactor: FootballDataInteracting) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        vc?.interactor = interactor
        
        return vc
    }
    
    private func fetchTeamsData(){
        interactor.getAllTeams().sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("An error has occured: \(error)")
            }
            //TODO: Ponder about this
        } receiveValue: { [weak self] response in
            guard ((self?.teams = response.teams) != nil) else {
                //TODO: Add user friendly alert
                print("Failed to fetch teams data")
                return
            }
            self?.teams = response.teams
        }.store(in: &subscriptions)
    }
}

// MARK: - TableView Implementation

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teams = teams {
            return teams.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: implement
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell")
        
        if let teams = teams {
            if let name = teams[indexPath.row].name {
                cell?.textLabel?.text = name
            }
        } else {
            cell?.textLabel?.text = "No data as of yet!"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Well hello there!")
        if let teams = teams {
            if let vc = TeamViewController.create(interactor: interactor) as? TeamViewController{
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true) {
                    vc.teamId = teams[indexPath.row].id
                }
            }
        }
    }
}

