#if os(watchOS)
import SnapshotTesting
import SnapshotTestingImageRender
import SwiftUI
import XCTest

// Snapshots recorded on Apple Watch Ultra 2 (49mm) running watchOS 10.0
final class ImageRenderSnapshotStrategyTests: XCTestCase {
  override class func setUp() {
    super.setUp()
    //isRecording = true
  }
  
  func testSwiftUIView_ImageRenderer_watchOS() {
    struct MyView: SwiftUI.View {
      var body: some SwiftUI.View {
        HStack {
          Image(systemName: "checkmark.circle.fill")
          Text("Checked").fixedSize()
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.blue))
        .padding(10)
      }
    }

    let view = MyView().background(Color.yellow)

    assertSnapshot(matching: view, as: .imageRender)
    assertSnapshot(matching: view, as: .imageRender(layout: .sizeThatFits), named: "size-that-fits")
    assertSnapshot(matching: view, as: .imageRender(layout: .fixed(width: 200.0, height: 100.0)), named: "fixed")
  }

  func testSwiftUIView_ImageRenderer_watchOS_ProposedSize() {
    struct MyView: SwiftUI.View {
      var body: some SwiftUI.View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
          .padding()
      }
    }

    let view = MyView()

    assertSnapshot(matching: view, as: .imageRender, named: "default")
    assertSnapshot(matching: view, as: .imageRender(proposedSize: .unspecified), named: "unspecified")
    assertSnapshot(matching: view, as: .imageRender(proposedSize: .init(width: 200, height: 100)), named: "fixed proposal")

    assertSnapshot(
      matching: view,
      as: .imageRender(layout: .fixed(width: 200, height: 100), proposedSize: .unspecified),
      named: "fixed layout, unspecified proposal"
    )

    assertSnapshot(
      matching: view,
      as: .imageRender(layout: .fixed(width: 200, height: 100), proposedSize: .init(width: 50, height: 50)),
      named: "fixed layout, small proposal"
    )
  }
}
#endif
