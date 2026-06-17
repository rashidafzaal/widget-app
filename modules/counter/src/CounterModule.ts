import { NativeModule, requireNativeModule } from 'expo';
import { CounterModuleEvents } from './Counter.types';

declare class CounterModule extends NativeModule<CounterModuleEvents> {
  getCount(): number;
  setCount(value: number): void;
}

export default requireNativeModule<CounterModule>('Counter');