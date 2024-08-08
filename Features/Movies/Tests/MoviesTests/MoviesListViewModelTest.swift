//
//  MoviesListViewModelTests.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import XCTest
import Combine
import DataLayer
import NetworkLayer

@testable import Movies

final class MoviesListViewModelTests: XCTestCase {
    
    //MARK: - Properties
    
    private var viewModel: MoviesListViewModel!
    private var mockMoviesRepository: MockMoviesRepository!
    private var cancellable: Set<AnyCancellable> = []
    
    //MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        viewModel = MoviesListViewModel(moviesRepository: mockMoviesRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockMoviesRepository = nil
        super.tearDown()
    }
    
    //MARK: - Test methods
    
    func test_initial_load_all_movies_with_out_any_filter_should_show_all_movies() {
        let expectation = expectation(description: "Wait for loading movies")
       
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation])
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(items.count, 3)
    }
    
    func test_fail_to_load_movies_should_show_error() {
        viewModel = .init(moviesRepository: MockMoviesRepositoryWithError())
        
        let expectation = expectation(description: "Wait for loading movies")
       
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation])
        
        guard case .error(let error) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        guard let apiError = error as? APIError else {
            XCTFail("Unexpected error")
            return
        }
        
        XCTAssertEqual(apiError, .badServerResponse)
    }
    
    func test_load_all_genres_should_load_all_genres() {
        
        let expectation = expectation(description: "Wait for loading genres")
        
        viewModel.$genres
            .dropFirst().sink { _ in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.genres.count, 3)
    }
    
    func test_search_for_movie_with_name_should_filter_movies_with_expected_name() {
        
        // Given
        
        viewModel.searchText = "Movie 2"
        
        let expectation = expectation(description: "Wait for loading movies")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        // Then
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.id, 2)
    }
    
    func test_filter_for_movies_by_Genre_should_filter_movies_with_expected_genre() {
        
        // Given
        
        viewModel.selectedGenreId = 3
        
        let expectation = expectation(description: "Wait for loading movies")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        // Then
        
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items.first?.id, 2)
        XCTAssertEqual(items[1].id, 3)
    }
    
    func test_filter_for_movies_by_genre_and_search_text_should_filter_movies_with_selected_search_and_filter() {
        
        // Given
        
        viewModel.selectedGenreId = 1
        viewModel.searchText = "Movie 3"
        
        let expectation = expectation(description: "Wait for loading movies")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        // Then
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.id, 3)
    }
    
    func test_empty_movies_with_selected_genre_should_not_display_any_movie() {
        
        // Given
        
        viewModel.selectedGenreId = 5
        
        let expectation = expectation(description: "Wait for loading movies")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        // Then
        
        XCTAssertEqual(items.count, 0)
    }
    
    func test_empty_movies_with_search_should_return_no_movies() {
        
        // Given
        
        viewModel.searchText = "Movie 4"
        
        let expectation = expectation(description: "Wait for loading movies")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
        
        guard case .movies(let items) = viewModel.state else {
            XCTFail("Unexpected state: \(viewModel.state)")
            return
        }
        
        // Then
        
        XCTAssertEqual(items.count, 0)
    }
    
}
