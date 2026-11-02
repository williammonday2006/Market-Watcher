# Phase 1

Using copyWit` creates a new Stock object instead of changing the existing one. This makes the data immutable and helps Flutter recognize updates. Mutating an object changes its existing values, while copyWith preserves the original object and returns an updated copy.