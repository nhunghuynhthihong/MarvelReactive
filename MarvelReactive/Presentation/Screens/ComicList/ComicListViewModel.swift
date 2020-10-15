//
//  ComicListViewModel.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import Foundation
import SwiftUI
import Combine
protocol UnidirectionalDataFlowType {
    associatedtype InputType
    
    func apply(_ input: InputType)
}
final class ComicListViewModel: ObservableObject, UnidirectionalDataFlowType {
    typealias InputType = Input

    private var cancellables: [AnyCancellable] = []
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Output
    @Published private(set) var comics: [Comic] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published private(set) var shouldShowIcon = false
    
    private let responseSubject = PassthroughSubject<GetComicsAPI.ResponsePayload, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    private let trackerService: TrackerType
    private let experimentService: ExperimentServiceType
    init(trackerService: TrackerType = TrackerService(),
         experimentService: ExperimentServiceType = ExperimentService()) {
        self.trackerService = trackerService
        self.experimentService = experimentService

        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        
        
        let getComicsAPI = GetComicsAPI()
        let responsePublisher = onAppearSubject
            .flatMap({ [getComicsAPI, errorSubject] _ in
                getComicsAPI.response(from: GetComicsAPI.RequestPayload())
                    .catch { [errorSubject] (error) -> Empty<GetComicsAPI.ResponsePayload, Never> in
                        errorSubject.send(error)
                        return .init()
                    }
            })
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        let trackingSubjectStream = trackingSubject
            .sink(receiveValue: trackerService.log)
        
        let trackingStream = onAppearSubject
            .map { .listView }
            .subscribe(trackingSubject)
        
        
        cancellables += [
            responseStream,
            trackingSubjectStream,
            trackingStream,
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map({ (response) -> [Comic] in
                return response.comicsResponse.data.results
            })
            .assign(to: \.comics, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
        
        let showIconStream = onAppearSubject
            .map { [experimentService] _ in
                experimentService.experiment(for: .showIcon)
            }
            .assign(to: \.shouldShowIcon, on: self)
        
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream,
            showIconStream
        ]
    }
}
