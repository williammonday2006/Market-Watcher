# Phase 1

Using copyWit` creates a new Stock object instead of changing the existing one. This makes the data immutable and helps Flutter recognize updates. Mutating an object changes its existing values, while copyWith preserves the original object and returns an updated copy.

# Phase 2

The StreamBuilder knows when to rebuild because it listens for new data from the BLoC stream. Whenever the stream sends a new Stock object, the StreamBuilder receives it and rebuilds the UI. This is different from setState because I don't have to manually tell Flutter to update the screen. The stream automatically triggers the update when new data arrives.

# Phase 3

When a button is pressed, its onPressed event sends a StockAction through the BLoC's input sink. The BLoC receives the action, calculates the price change, and uses copyWith to create a new Stock object. It then sends the updated object through the output stream. The StreamBuilder listens for this new data and rebuilds the widget automatically. The rebuild happens inside the StreamBuilder, not inside the button or BLoC.