//
//  EarwormTests.swift
//  EarwormTests
//
//  Created by Hugo Pinheiro  on 26/02/25.
//

import XCTest
@testable import Earworm

final class EarwormTests: XCTestCase {

    //Setup e teardown (pode ser removido se não estiver usando)
    override func setUpWithError() throws {
        // Executado antes de cada teste
    }

    override func tearDownWithError() throws {
        // Executado depois de cada teste
    }

    // Teste de URL válida
    func testValidUrls() {
        XCTAssertTrue(URLValidator.isValid("https://example.com"))
        XCTAssertTrue(URLValidator.isValid("http://www.example.com"))
        XCTAssertTrue(URLValidator.isValid("https://example.com:443"))
        XCTAssertTrue(URLValidator.isValid("http://www.example.com:8080"))
        XCTAssertTrue(URLValidator.isValid("https://example.com/path?query=teste#section"))
        XCTAssertTrue(URLValidator.isValid("https://example.com/ação?busca=áéíóú"))
        XCTAssertTrue(URLValidator.isValid("http://192.168.1.1"))
    }

    // Teste de URL inválida
    func testInvalidUrls() {
        XCTAssertFalse(URLValidator.isValid("example.com"))
        XCTAssertFalse(URLValidator.isValid("www.example.com/path"))
        XCTAssertFalse(URLValidator.isValid("htp://example.com"))
        XCTAssertFalse(URLValidator.isValid("https:/exa mple.com"))
        XCTAssertFalse(URLValidator.isValid("https:/example..com"))
        XCTAssertFalse(URLValidator.isValid("ftp://example.com"))
        XCTAssertFalse(URLValidator.isValid("http//example.com"))
        XCTAssertFalse(URLValidator.isValid("https:/example.com"))
        XCTAssertFalse(URLValidator.isValid("://example.com"))
        XCTAssertFalse(URLValidator.isValid(""))
        XCTAssertFalse(URLValidator.isValid(" "))
        XCTAssertFalse(URLValidator.isValid("invalid-url"))
        
        // URLs maliciosas/inseguras (proteção contra injeção
        XCTAssertFalse(URLValidator.isValid("javascript:alert(1)"))
        XCTAssertFalse(URLValidator.isValid("data:text/html,<script>alert(1)</script>"))
    }

    // Teste de performance (opcional)
    func testPerformanceExample() throws {
        measure {
            // Código para medir desempenho (pode ser apagado se não usar)
        }
    }
}
