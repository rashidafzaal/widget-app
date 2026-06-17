import { NativeModule, requireNativeModule } from 'expo';

declare class CounterModule extends NativeModule<{}> {}

export default requireNativeModule<CounterModule>('Counter');
