//
//  TeamViewController.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import UIKit
import Combine

class TeamViewController: UIViewController {
    
    // MARK: - Properties | Components
    
    
    // MARK: - Properties | Variables
    
    private var interactor: FootballDataInteracting!
    private var subscriptions: Set<AnyCancellable> = []
    
    //TODO: Find a better solution!
    var teamId: Int! {
        didSet {
            if let id = teamId {
                print("Team id is: \(id)")
                fetchTeamData(id: String(id))
            }
        }
    }
    private var team: Team!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    static func create(interactor: FootballDataInteracting) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TeamVC") as? TeamViewController
        vc?.interactor = interactor
        
        return vc
    }
    
    private func fetchTeamData(id: String){
        interactor.getTeam(id: id).sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("An error has occured: \(error)")
            }
        } receiveValue: { [weak self] response in
            //TODO: Implement
            self?.team = response
            if let name = self?.team.name {
                print(name)
            }
            if let squad = self?.team.squad {
                print(squad)
            }
        }.store(in: &subscriptions)
    }
}



extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Implement
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: implement
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell")
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Add relevant functionality
        print("Well hello there!")
    }
    
    
}

