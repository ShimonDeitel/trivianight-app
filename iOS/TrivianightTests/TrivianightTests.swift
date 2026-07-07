import XCTest
@testable import Trivianight

@MainActor
final class TrivianightTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
    }

    func testSeedDataBelowFreeLimit() {
        XCTAssertLessThan(store.entries.count, Store.freeLimit)
    }

    func testAddEntryIncreasesCount() {
        let before = store.entries.count
        store.add(NightEntry(title: "New One"))
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testDeleteEntryDecreasesCount() {
        store.add(NightEntry(title: "ToDelete"))
        let before = store.entries.count
        if let entry = store.entries.first(where: { $0.title == "ToDelete" }) {
            store.delete(entry)
        }
        XCTAssertEqual(store.entries.count, before - 1)
    }

    func testCanAddMoreWhenUnderLimit() {
        store.entries = []
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreWhenAtLimitAndNotPro() {
        store.isPro = false
        store.entries = (0..<Store.freeLimit).map { NightEntry(title: "Item \($0)") }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProEvenAtLimit() {
        store.isPro = true
        store.entries = (0..<Store.freeLimit).map { NightEntry(title: "Item \($0)") }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateEntryChangesTitle() {
        store.add(NightEntry(title: "Original"))
        guard var entry = store.entries.first(where: { $0.title == "Original" }) else {
            XCTFail("entry not found"); return
        }
        entry.title = "Updated"
        store.update(entry)
        XCTAssertTrue(store.entries.contains { $0.title == "Updated" })
    }

    func testDeleteAtOffsetsRemovesCorrectEntry() {
        store.entries = []
        store.add(NightEntry(title: "A"))
        store.add(NightEntry(title: "B"))
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.entries.count, 1)
    }
}
