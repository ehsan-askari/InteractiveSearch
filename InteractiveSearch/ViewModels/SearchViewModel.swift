//
//  SearchViewModel.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import Combine
import MapKit

class SearchViewModel: ObservableObject {
    
    @Published var mapItems: [MKMapItem] = []
    
    @Published var text: String = ""
    {
        didSet{
            if text.count <= 1 {
                self.mapItems = []
            }
        }
    }
    
    private var anyCancellable : AnyCancellable?
    
    init() {
        anyCancellable = $text
            .filter({ (text) -> Bool in
                return text.count > 1
            })
            .debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: search(text:))
    }
    
    private func search(text: String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = .address // or pointOfInterest
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, _) in
            guard let response = response else {
                self?.mapItems = []
                return
            }
            self?.mapItems = response.mapItems
        }
    }
    
    deinit {
        anyCancellable?.cancel()
        anyCancellable = nil
    }
    
}
