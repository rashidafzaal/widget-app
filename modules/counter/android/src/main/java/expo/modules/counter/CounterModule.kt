package expo.modules.counter

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class CounterModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("Counter")
  }
}
