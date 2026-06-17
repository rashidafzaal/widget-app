import { registerWebModule, NativeModule } from 'expo';
import { CounterModuleEvents } from './Counter.types';

class CounterModule extends NativeModule<CounterModuleEvents> {
  private count = 0;

  getCount(): number {
    return this.count;
  }

  setCount(value: number): void {
    this.count = value;
    this.emit('onCountChange', { count: value });
  }
}

export default registerWebModule(CounterModule, 'CounterModule');